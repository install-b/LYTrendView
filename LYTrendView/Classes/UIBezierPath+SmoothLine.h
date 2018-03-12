//
//  UIBezierPath+SmoothLine.h
//  LYTrendView
//
//  Created by Shangen Zhang on 2017/4/18.
//  Copyright © 2017年 Shangen Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (SmoothLine)

/**
 绘制一条曲线

 @param toPoint 终点
 */
- (void)addSmoothLineToPoint:(CGPoint)toPoint;
@end
