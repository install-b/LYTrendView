//
//  LYTrendUIFunc.h
//  BallOfBitcoin
//
//  Created by Shangen Zhang on 2018/7/15.
//  Copyright © 2018年 Flame. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 求虚线的个数

 @param length 总长度
 @param solidLength 虚线长度
 @param spaceLength 间隙长度
 @return 虚线个数
 */
UIKIT_EXTERN NSInteger ly_dashLineNumber(CGFloat length,
                            CGFloat solidLength,
                            CGFloat spaceLength);

/**
 绘制 BezierPath 渐变填充

 @param rect 填充的矩形区域一般是view 或 layer的bounds
 @param locationRate 渐变度 0~1  值越大渐变越小
 @param startcolor 开始的颜色
 @param endcolor 结束的颜色
 @param path 填充的路径 nil表示填充整个rect
 */
UIKIT_EXTERN void ly_renderBezierPathGradientColor(CGRect rect,
                                                   CGFloat locationRate,
                                                   UIColor *startcolor,
                                                   UIColor *endcolor,
                                                   UIBezierPath *path);
