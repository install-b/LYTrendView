//
//  LYLineChartView.h
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/3/12.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYTrendView.h"
#import "LYChartLine.h"


@interface LYLineChartView : LYTrendView
/**
 add a trend line with point array
 
 @param lines line data model
 @param animate is show animation (leave to future)
 */
- (void)addChartLines:(NSArray <LYChartLine *> *)lines withAnimate:(BOOL)animate;


/**
 delete a trend line

 @param line line data model
 @param animate current havn't use
 */
- (void)removeChartLine:(LYChartLine *)line withAnimate:(BOOL)animate;


/**
 delete all trend lines
 */
- (void)removeChartLines;


/**
 show animation for line chart view
    -- it can call viewDidAppear or app did ResignActive
 */
- (void)restartAnimateForCharts;
@end
