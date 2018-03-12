//
//  LYLineChartView.h
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/3/12.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYTrendAnimateView.h"
#import "LYChartLine.h"


@interface LYLineChartView : LYTrendAnimateView
/**
 add a trend line with point array
 
 @param lines line data model
 @param animate is show animation (leave to future)
 */
- (void)addChartLines:(NSArray <LYChartLine *> *)lines withAnimate:(BOOL)animate;

- (void)removeChartLine:(LYChartLine *)line withAnimate:(BOOL)animate;

- (void)removeChartLines;
@end
