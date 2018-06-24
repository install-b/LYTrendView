//
//  LYLineChartView.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/3/12.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYLineChartView.h"
#import "UIBezierPath+SmoothLine.h"



typedef void(^LYDrawingTitleBlock)(void);


@interface LYLineChartView ()
/** 曲线 */
@property (nonatomic,strong) NSMutableArray <LYChartLine *>* chartLines;
/** 是否处于animate 状态 */
@property(nonatomic,assign,getter=isBeginAnimate) BOOL beginAnimate;
@end



@implementation LYLineChartView

- (void)drawRect:(CGRect)rect {
    
    // Drawing frame /> 绘制主体框架
    [super drawRect:rect];
    
   // Drawing charts />  绘制折线
    [_chartLines enumerateObjectsUsingBlock:^(LYChartLine * _Nonnull line, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        // define temp various
        NSMutableArray <UIBezierPath *>*dotPaths = nil;
        dotPaths = (line.dotRadii <= 0) ? nil : [NSMutableArray array];
        __block NSMutableArray <LYDrawingTitleBlock>* dotTitleBlockArray = nil;
        
        [line.pointArray enumerateObjectsUsingBlock:^(id<LYChartLinePointProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // value point transform to view point
            CGPoint p = [self tranferScreenPointWithValuePoint:CGPointMake(obj.sectionValueX, obj.sectionValueY)valueType:LYColumnValueTypeY];
            
            if (idx) {
                line.smooth ? [path ly_addSmoothLineToPoint:p] : [path addLineToPoint:p];
            }else {
                [path moveToPoint:p];
            }
            
            // collect dot bezier path
            if (dotPaths) {
                CGRect dotRect = CGRectMake(p.x - line.dotRadii, p.y - line.dotRadii, 2 * line.dotRadii, 2 * line.dotRadii);
                UIBezierPath *dotPath = [UIBezierPath bezierPathWithOvalInRect:dotRect];
                [dotPaths addObject:dotPath];
            }
            
            // collect dotTitle drawing code
            if ([obj respondsToSelector:@selector(pointLableFormate)] &&
                [obj respondsToSelector:@selector(pointAttributs)] &&
                [obj respondsToSelector:@selector(pointPosition)] &&
                obj.pointLableFormate.length) {
                // alloc dotTitleBlockArray
                dotTitleBlockArray = dotTitleBlockArray ? : [NSMutableArray array];
                
                // add object
                [dotTitleBlockArray addObject:^{
                    // code here drawing title
                    NSString *title = dotTitle(obj, obj.pointLableFormate);
                    CGRect rect = dotRect(title, p,obj.pointAttributs,obj.pointPosition);
                    
                    [title drawInRect:rect withAttributes:obj.pointAttributs];
                }];
            }
            
        }];
        
        path.lineWidth = line.borderWidth;
        if (line.lineCapStyle) {
            path.lineCapStyle = line.lineCapStyle;
        }
        if (line.lineJoinStyle) {
            path.lineJoinStyle = line.lineJoinStyle;
        }else {
            path.miterLimit = line.miterLimit;
        }
        
        // drawing line
        [line.borderColor set];
        [path stroke];
        
        
        // draw path other (eg. bg color)
        [self didAddLinePath:path color:line.borderColor inrect:rect];
        
        // drawing dot
        [dotPaths enumerateObjectsUsingBlock:^(UIBezierPath * _Nonnull dotPath, NSUInteger idx, BOOL * _Nonnull stop) {
            [line.dotColor set];
            [dotPath fill];
        }];
        
        // drawing title
        [dotTitleBlockArray enumerateObjectsUsingBlock:^(LYDrawingTitleBlock  _Nonnull drawingTitleBlock, NSUInteger idx, BOOL * _Nonnull stop) {
            drawingTitleBlock();
        }];
    }];
    
}

- (void)didAddLinePath:(UIBezierPath *)path color:(UIColor *)bgColor inrect:(CGRect)rect {
    // code here when add line path.  it may implement at sub class
}


#define animateDuration 2.5f

- (void)animateCharts {
    self.beginAnimate = YES;
    NSMutableArray <CALayer *>* animateLayers = [NSMutableArray array];
    [_chartLines enumerateObjectsUsingBlock:^(LYChartLine * _Nonnull line, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [line.pointArray enumerateObjectsUsingBlock:^(id<LYChartLinePointProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // value point transform to view point
            CGPoint p = [self tranferScreenPointWithValuePoint:CGPointMake(obj.sectionValueX, obj.sectionValueY)valueType:LYColumnValueTypeY];
        
            if (idx) {
                line.smooth ? [path ly_addSmoothLineToPoint:p] : [path addLineToPoint:p];
            }else {
                [path moveToPoint:p];
            }
        }];
        CAShapeLayer  *animLayer = [CAShapeLayer layer];
        animLayer.path = path.CGPath;
        animLayer.lineWidth = line.borderWidth;
        if (line.lineCapStyle) {
            path.lineCapStyle = line.lineCapStyle;
        }
        if (line.lineJoinStyle) {
            path.lineJoinStyle = line.lineJoinStyle;
        }else {
            path.miterLimit = line.miterLimit;
        }
        animLayer.strokeColor = line.borderColor.CGColor;
        
        animLayer.fillColor = [UIColor clearColor].CGColor;
        
        [self.layer addSublayer:animLayer];
        [animateLayers addObject:animLayer];
        
        animLayer.strokeStart = 0.f;   // 设置起点为 0
        animLayer.strokeEnd = 0.f;     // 设置终点为 0
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = animateDuration;   // 持续时间
        animation.fromValue = @(0); // 从 0 开始
        animation.toValue = @(1);   // 到 1 结束
        // 保持动画结束时的状态
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        // 动画缓慢的进入，中间加速，然后减速的到达目的地。
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [animLayer addAnimation:animation forKey:@""];
        
    }];
    // 移除layer
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animateDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.beginAnimate = NO;
        [self setNeedsDisplay];
        [animateLayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull layer, NSUInteger idx, BOOL * _Nonnull stop) {
            [layer removeFromSuperlayer];
        }];
    });
}
#pragma mark -
- (void)addChartLines:(NSArray<LYChartLine *> *)lines withAnimate:(BOOL)animate {
    [self.chartLines addObjectsFromArray:lines];
    if (self.isBeginAnimate == YES) {
        return;
    }
    
    // begin animate
    if (animate) {
        [self restartAnimateForCharts];
    }else {
        [self setNeedsDisplay];
    }
}

- (void)restartAnimateForCharts {
    if (self.beginAnimate) {
        return;
    }
    [self animateCharts];
}

- (void)removeChartLine:(LYChartLine *)line withAnimate:(BOOL)animate {
    [_chartLines removeObject:line];
    if (self.isBeginAnimate) {
        return;
    }
    [self setNeedsDisplay];
}

- (void)removeChartLines {
    _chartLines = nil;
    if (self.isBeginAnimate) {
        return;
    }
    [self setNeedsDisplay];
}


- (NSMutableArray<LYChartLine *> *)chartLines {
    if (!_chartLines) {
        _chartLines = [NSMutableArray array];
    }
    return _chartLines;
}


#pragma mark - C function


#define dotTitleMargin 3.0f

static CGRect dotRect(NSString * dotTitle,CGPoint point,NSDictionary *attributes,LYDotPosition position) {
    
    CGSize size = [dotTitle sizeWithAttributes:attributes];
    
    switch (position) {
        case LYDotPositionTop:
            return CGRectMake(point.x - size.width * 0.5, point.y - size.height - dotTitleMargin, size.width, size.height);
        case LYDotPositionBottom:
            return CGRectMake(point.x - size.width * 0.5, point.y + dotTitleMargin, size.width, size.height);
        case LYDotPositionLeft:
            return CGRectMake(point.x - size.width - dotTitleMargin, point.y - size.height * 0.5, size.width, size.height);
        case LYDotPositionRight:
            return CGRectMake(point.x + dotTitleMargin, point.y - size.height * 0.5, size.width, size.height);
        case LYDotPositionCenter:
            return CGRectMake(point.x - size.width * 0.5, point.y - size.height * 0.5, size.width, size.height);
        default:
            break;
    }
    
    return CGRectZero;
}

static NSString *dotTitle(id<LYChartLinePointProtocol>point,NSString *formate) {
    
    NSRange rangX = [formate rangeOfString:@"xx"];
    if (rangX.length) {
        formate = [formate stringByReplacingCharactersInRange:rangX withString:[NSString stringWithFormat:@"%.2f",point.sectionValueX]];
    }
    
    NSRange rangY = [formate rangeOfString:@"yy"];
    if (rangY.length) {
        return [formate stringByReplacingCharactersInRange:rangY withString:[NSString stringWithFormat:@"%.2f",point.sectionValueY]];
    }
    return formate;
    
}
@end
