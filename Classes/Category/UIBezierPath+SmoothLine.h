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
- (void)ly_addSmoothLineToPoint:(CGPoint)toPoint;


/**
 调用 ‘ly_addSmoothLineToPoint:’ 之前需要用 ‘ly_moveToPoint:’ 代替 ‘moveToPoint’

 @param point 需要移动到的点
 */
- (void)ly_moveToPoint:(CGPoint)point;
@end
