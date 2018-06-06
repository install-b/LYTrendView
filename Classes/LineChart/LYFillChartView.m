//
//  LYFillChartView.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/6.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYFillChartView.h"

@implementation LYFillChartView
-(void)didAddLinePath:(UIBezierPath *)path color:(UIColor *)bgColor inrect:(CGRect)rect {
    if (bgColor == nil)  return;
    
    // stoke path 
    CGPoint currentPoint = path.currentPoint;
    CGPoint originP = [self tranferScreenPointWithValuePoint:CGPointZero valueType:LYColumnValueTypeY];
    [path addLineToPoint:CGPointMake(currentPoint.x, originP.y)];
    [path addLineToPoint:originP];
    
    
    // 1. 获取当前的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 2. Create a DeviceRGB color space.  //> 获取颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 设置渐变梯度
    CGFloat locations[] = {1.0, 0.0};
    // 设置渐变颜色
    id startColor = (__bridge id)bgColor.CGColor;
    id endColor   = (__bridge id)[bgColor colorWithAlphaComponent:0.0].CGColor;
    NSArray *colors  = @[startColor, endColor];
    
    
    // Creates a gradient by pairing the colors  //> 获取渐变颜色
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    // 设置渐变方向
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    
    /* Push a copy of the current graphics state onto the graphics state stack.
     Note that the path is not considered part of the graphics state, and is
     not saved. */
    // push context //> 上下文入栈
    CGContextSaveGState(context);
    {
        // add  BezierPath
        CGContextAddPath(context, path.CGPath);
        //CGContextAddRect(context, rect);
        // clips  //> 设置裁剪
        CGContextClip(context);
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    }
    /* Restore the current graphics state from the one on the top of the
     graphics state stack, popping the graphics state stack in the process. */
    // pop context  //>  出栈
    CGContextRestoreGState(context);
    
    // 释放内存
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}


@end
