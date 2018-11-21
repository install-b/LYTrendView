//
//  LYPieChartView.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/6.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYPieChartView.h"


static CGFloat fullCricleAngle = M_PI * 2;


@implementation UIColor (RandomColor)
+ (UIColor *)ly_randomColor {
    int r = rand() % 255;
    int g = rand() % 255;
    int b = rand() % 255;
    int a = rand() % 99;
    return [self colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:(a + 1)/100.0f];
}

@end

@implementation LYPieChartView

- (void)setPieModels:(NSArray<LYPieModel *> *)pieModels {
    _pieModels = pieModels;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGRect bounds = self.insetRect;
    
    NSArray<LYPieModel *> *pieModels = self.pieModels;
    NSInteger pieCount = pieModels.count;
    
    if ( pieCount < 1 ) return;
    
    LYPieChartAnnotationPosition annotationPosition = self.annotationPosition;
    CGRect circleRect = [self circleRectForBounds:bounds withAnnotationPosition:annotationPosition];
    //
    CGPoint circleCenter = [self circleCenterInRect:circleRect];
    
    // 绘制外圆
    if (self.outCircleRadii > 0) {
        // 获取外圆的路径
         UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleCenter radius:self.outCircleRadii startAngle:0 endAngle:fullCricleAngle clockwise:YES];
        
        // 内填充
        if (self.outCircleColor ) {
            [self.outCircleColor set];
            [path fill];
        }
        
        // 外绘制
        if ((self.outCircleBorderWidth > 0) && self.outCircleBorderColor) {
            [self.outCircleBorderColor set];
            path.lineWidth = self.outCircleBorderWidth;
            [path stroke];
        }
        // 完成外圆绘制的事件
        [self didDrawOutCricleWithPath:path inRect:circleRect];
    }
    
    
    // 绘制区块
    {
        CGFloat radii = (self.outCircleRadii > 0) ? self.outCircleRadii : (MIN(circleRect.size.width, circleRect.size.height)) * 0.5;
        __block CGFloat startAngle = self.startAngle;
        
        [pieModels enumerateObjectsUsingBlock:^(LYPieModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CGFloat endAngle = fullCricleAngle * obj.progress + startAngle;
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleCenter radius:radii+obj.radiiOffset startAngle:startAngle endAngle:endAngle clockwise:self.isClockwise];
            [path addLineToPoint:circleCenter];
            obj.pieColor = obj.pieColor ?: [UIColor ly_randomColor];
            [obj.pieColor set];
            
            [path fill];
            startAngle = endAngle;
            
            // 绘制完一个饼图的事件
            [self didDrawPieWithModel:obj atPath:path inRect:circleRect];
        }];
    }
    
    
    // 绘制内圆
    if (self.inCircleRadii ) {
        // 获取内圆的路径
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleCenter radius:self.inCircleRadii startAngle:0 endAngle:fullCricleAngle clockwise:YES];
        // 填充颜色
        if (self.inCircleColor) {
            [self.inCircleColor set];
            [path fill];
        }
        
        // 绘制边框
        if (self.inCircleBorderWidth && self.inCircleBorderColor) {
            [self.inCircleBorderColor set];
            [path stroke];
        }
        // 完成内圆绘制的事件
        [self didDrawInCricleWithPath:path inRect:circleRect];
    }
    
    // 绘制图例
    if (annotationPosition) {
        CGRect annotationRect = [self annotationRectForBounds:bounds withAnnotationPosition:annotationPosition];
        if (CGRectEqualToRect(CGRectZero, annotationRect)) {
            return;
        }
        
        NSDictionary *antationAttribute = self.annotationAttribute;
        
        CGFloat poinSize = [@"1" sizeWithAttributes:antationAttribute].height;
        CGFloat margin = 10;
        
        CGFloat topOffset = [self p_addjustTopOffsetWithPointSize:poinSize  maxHeight:annotationRect.size.height itemNumber:(int)pieCount preMargin:&margin];
        if (topOffset < 0) {
            return;
        }
        topOffset += annotationRect.origin.y;
        
        CGFloat dotWH = poinSize - 6;
        if (dotWH < 0) {
            dotWH = poinSize;
        }else if (dotWH < 5) {
            dotWH = 5;
        }
        CGFloat dotX = annotationRect.origin.x + margin;
        CGFloat dotRadius = self.annotationType ? (dotWH * 0.5) : 0;
        CGFloat textX = dotX + dotWH * 1.5;
        CGFloat dotFix = (poinSize - dotWH) * 0.5;
        
        [pieModels enumerateObjectsUsingBlock:^(LYPieModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat textY = (poinSize + margin) * idx + topOffset;
            CGRect dotRect = CGRectMake(dotX, textY + dotFix, dotWH, dotWH);
            UIBezierPath *dotPath = [UIBezierPath bezierPathWithRoundedRect:dotRect cornerRadius:dotRadius];
            [obj.pieColor set];
            [dotPath fill];
            if (obj.itemNameAttr) {
                [obj.itemNameAttr drawAtPoint:CGPointMake(textX, textY)];
            }else {
                [obj.itemName drawAtPoint:CGPointMake(textX, textY) withAttributes:self.annotationAttribute];
            }
            if (self.annotationType == LYPieChartAnnotationTypeHollow) {
               UIBezierPath *inner =   [UIBezierPath bezierPath];
                [inner addArcWithCenter:CGPointMake(CGRectGetMidX(dotRect), CGRectGetMidY(dotRect)) radius:0.5 * dotRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
                [self.inCircleColor set];
                [inner fill];
            }
            
        }];
       
    }
}
- (CGFloat)p_addjustTopOffsetWithPointSize:(CGFloat)poinSize
                                 maxHeight:(CGFloat)maxH
                                itemNumber:(int)pieCount
                                 preMargin:(CGFloat *)margin {
    CGFloat topOffset = (maxH - ( poinSize * pieCount + (pieCount - 1)* (*margin)) ) * 0.5;
    if (topOffset < 0) {
        CGFloat marginTemp = (*margin) * 0.5;
        if (marginTemp > 1) {
            *margin = marginTemp;
            return [self p_addjustTopOffsetWithPointSize:poinSize maxHeight:maxH itemNumber:pieCount preMargin:margin];
        }else {
            return -1;
        }
        
    }
    return topOffset;
}
/* 绘制的方向 是否为shu时针反向 */
//@property (nonatomic,assign,getter=isClockwise) BOOL clockwise;
- (BOOL)isClockwise {
    return YES;
}
#pragma mark - 子类拓展的方法
- (void)didDrawOutCricleWithPath:(UIBezierPath *)path inRect:(CGRect)rect {
    
}
- (void)didDrawPieWithModel:(LYPieModel *)model atPath:(UIBezierPath *)path inRect:(CGRect)rect {
    
}

- (void)didDrawInCricleWithPath:(UIBezierPath *)path inRect:(CGRect)rect {
    
}

#pragma mark - caculates
- (CGPoint)circleCenterInRect:(CGRect)rect {
    return CGPointMake(rect.origin.x + (rect.size.width * 0.5), rect.origin.y + (rect.size.height * 0.5));
}

- (CGRect)circleRectForBounds:(CGRect)rect withAnnotationPosition:(LYPieChartAnnotationPosition)annotationPosition {
    switch (annotationPosition) {
        case LYPieChartAnnotationPositionTop:
            // 计算高度
        {
            CGFloat h = rect.size.height * 0.5;
            rect.size.height = h;
            rect.origin.y += h;
            return rect;
        }
            break;
        case LYPieChartAnnotationPositionLeft:
        {
            CGFloat w = rect.size.width * 0.5;
            rect.size.width = w;
            rect.origin.x += w;
            return rect;
        }
            break;
        case LYPieChartAnnotationPositionBotton:
        {
            CGFloat h = rect.size.height * 0.5;
            rect.size.height = h;
            return rect;
        }
            break;
        case LYPieChartAnnotationPositionRight:
        {
            CGFloat w = rect.size.width * 0.5;
            rect.size.width = w;
            return rect;
        }
            break;
            
        default:
            break;
    }
    return  rect;
}
- (CGRect)annotationRectForBounds:(CGRect)rect withAnnotationPosition:(LYPieChartAnnotationPosition)annotationPosition {
    switch (annotationPosition) {
        case LYPieChartAnnotationPositionTop:
        {
            CGFloat h = rect.size.height * 0.5;
            rect.size.height = h;
            return rect;
        }
            break;
        case LYPieChartAnnotationPositionLeft:
        {
            CGFloat w = rect.size.width * 0.5;
            rect.size.width = w;
            return rect;
        }
            break;
        case LYPieChartAnnotationPositionBotton:
        {
            CGFloat h = rect.size.height * 0.5;
            rect.size.height = h;
            rect.origin.y += h;
            return rect;
        }
            break;
        case LYPieChartAnnotationPositionRight:
        {
            CGFloat w = rect.size.width * 0.5;
            rect.size.width = w;
            rect.origin.x += w;
            return rect;
        }
            break;
        
        default:
            break;
    }
    return  CGRectZero;
}

#pragma mark - lazy load
- (NSDictionary<NSAttributedStringKey,id> *)annotationAttribute {
    if (!_annotationAttribute) {
        _annotationAttribute =@{
                                NSFontAttributeName :[UIFont systemFontOfSize:12] ,
                                NSForegroundColorAttributeName : [UIColor darkTextColor],
                                //NSBackgroundColorAttributeName : [UIColor yellowColor]
                                };
    }
    return _annotationAttribute;
}

@end
