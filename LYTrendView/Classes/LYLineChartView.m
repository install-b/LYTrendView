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

/** <#des#> */
@property (nonatomic,strong) NSMutableArray <LYChartLine *>* chartLines;

@end



@implementation LYLineChartView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
   
    [_chartLines enumerateObjectsUsingBlock:^(LYChartLine * _Nonnull line, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        // define temp various
        NSMutableArray <UIBezierPath *>*dotPaths = nil;
        dotPaths = (line.dotRadii <= 0) ? nil : [NSMutableArray array];
        __block NSMutableArray <LYDrawingTitleBlock>* dotTitleBlockArray = nil;
        
        [line.pointArray enumerateObjectsUsingBlock:^(id<LYChartLinePointProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // value point transform to view point
            CGPoint p = [self tranferScreenPointWithValuePoint:CGPointMake(obj.sectionValueX, obj.sectionValueY)valueType:LYColumnValueTypeY];
            
            //idx ? [path addLineToPoint:p] :  [path moveToPoint:p];
            if (idx) {
                line.smooth ? [path addSmoothLineToPoint:p] : [path addLineToPoint:p];
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
            if (obj.pointLableFormate.length) {
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

- (void)addChartLines:(NSArray<LYChartLine *> *)lines withAnimate:(BOOL)animate {
    [self.chartLines addObjectsFromArray:lines];
    // begin animate
    
    [self setNeedsDisplay];
}

- (void)removeChartLine:(LYChartLine *)line withAnimate:(BOOL)animate {
    
}

- (void)removeChartLines {
    _chartLines = nil;
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
