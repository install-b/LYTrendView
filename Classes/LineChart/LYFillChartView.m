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
    
    // 渲染渐变
    ly_renderBezierPathGradientColor(rect,
                                     0.0,
                                     bgColor,
                                     [bgColor colorWithAlphaComponent:0.0],
                                     path);
}


@end
