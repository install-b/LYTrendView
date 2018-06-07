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
    
    if (self.pieModels.count < 1 ) {
        
        return;
    }
    
    CGPoint circleCenter = [self circleCenterInRect:rect];
    
    //
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
        [self didDrawOutCricleWithPath:path inRect:rect];
    }
    
    
    // 绘制区块
    {
        CGFloat radii = (self.outCircleRadii > 0) ? self.outCircleRadii : (MIN(rect.size.width, rect.size.height)) * 0.5;
        __block CGFloat startAngle = self.startAngle;
        
        [self.pieModels enumerateObjectsUsingBlock:^(LYPieModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CGFloat endAngle = fullCricleAngle * obj.progress + startAngle;
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleCenter radius:radii+obj.rdiiOffset startAngle:startAngle endAngle:endAngle clockwise:self.isClockwise];
            [path addLineToPoint:circleCenter];
            [obj.pieColor ? : [UIColor ly_randomColor] set];
            [path fill];
            startAngle = endAngle;
            
            // 绘制完一个饼图的事件
            [self didDrawPieWithModel:obj atPath:path inRect:rect];
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
        [self didDrawInCricleWithPath:path inRect:rect];
    }
    
}
#pragma mark - 子类拓展的方法
- (void)didDrawOutCricleWithPath:(UIBezierPath *)path inRect:(CGRect)rect {
    
}
- (void)didDrawPieWithModel:(LYPieModel *)model atPath:(UIBezierPath *)path inRect:(CGRect)rect {
    
}

- (void)didDrawInCricleWithPath:(UIBezierPath *)path inRect:(CGRect)rect {
    
}
#pragma mark -
- (CGPoint)circleCenterInRect:(CGRect)rect {
    return CGPointMake(rect.origin.x + (rect.size.width * 0.5), rect.origin.y + (rect.size.height * 0.5));
}

@end
