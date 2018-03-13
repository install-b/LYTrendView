//
//  LYPoint.h
//  LYTrendView
//
//  Created by Shangen Zhang on 2017/4/12.
//  Copyright © 2017年 Shangen Zhang. All rights reserved.
//
//
// 自己的点模型

#import "LYLineChartView.h"

@interface LYPoint : NSObject <LYChartLinePointProtocol>

- (instancetype)initWithPoint:(CGPoint)point;

@end
