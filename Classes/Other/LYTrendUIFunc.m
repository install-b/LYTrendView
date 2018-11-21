//
//  LYTrendUIFunc.m
//  BallOfBitcoin
//
//  Created by Shangen Zhang on 2018/7/15.
//  Copyright © 2018年 Flame. All rights reserved.
//

#import "LYTrendUIFunc.h"


void ly_renderBezierPathGradientColor(CGRect rect,
                                      CGFloat locationRate,
                                      UIColor *startcolor,
                                      UIColor *endcolor,
                                      UIBezierPath *path) {
    // 获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //  Create a DeviceRGB color space.  //> 获取颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (locationRate > 1) {
        locationRate = 1;
    }else if (locationRate < 0) {
        locationRate = 0;
    }
    
    // 设置渐变梯度
    CGFloat locations[] = {1.0,locationRate};
    // 设置渐变颜色
    NSArray *colors  = @[(__bridge id)startcolor.CGColor, (__bridge id)endcolor.CGColor];
    
    
    // Creates a gradient by pairing the colors  //> 获取渐变颜色
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors,locations);
    
    // 设置渐变方向
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    
    // 填充
    /* Push a copy of the current graphics state onto the graphics state stack.
     Note that the path is not considered part of the graphics state, and is
     not saved. */
    // push context //> 上下文入栈
    CGContextSaveGState(context);
    {
        
        if (path) {
            // add  BezierPath
            CGContextAddPath(context, path.CGPath);
        }else {
            // add rect
            CGContextAddRect(context, rect);
        }
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


//
NSInteger ly_dashLineNumber(CGFloat length,CGFloat solidLength, CGFloat spaceLength) {
    CGFloat perLenth = solidLength + spaceLength;
    CGFloat tempNumber = length/perLenth;
    NSInteger number = (NSInteger)tempNumber;
    if ((tempNumber - number) * perLenth > solidLength) {
        number += 1;
    }
    return number;
}
