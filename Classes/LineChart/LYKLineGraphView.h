//
//  LYKLineGraphView.h
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/22.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

// K-Line Graph K线图

#import "LYLineChartView.h"


@interface LYTimeTrendModel : NSObject
/* 时间 */
@property (nonatomic,assign) CGFloat timeZone;

/* 最高价 */
@property (nonatomic,assign) CGFloat highestPrice;
/* 最低价 */
@property (nonatomic,assign) CGFloat bottomPrice;
/* 开盘价 */
@property (nonatomic,assign) CGFloat openPrice;
/* 收盘价 */
@property (nonatomic,assign) CGFloat closingPrice;
@end


@class LYKLineGraphView;
@protocol LYKLineGraphViewDelegate <LYTrendViewDelegate>
@optional
- (CGFloat)graphWidthForForKLineGraphView:(LYKLineGraphView *)kLineGraphView;

- (CGFloat)graphMarginForForKLineGraphView:(LYKLineGraphView *)kLineGraphView;

- (NSTimeInterval)timeZoneForKLineGraphView:(LYKLineGraphView *)kLineGraphView;

//- (NSArray *)dataSourceForKLineGraphView:(LYKLineGraphView *)kLineGraphView;

@end




@interface LYKLineGraphView : LYLineChartView

- (void)appendTimeTrendModel:(NSArray <LYTimeTrendModel *>*)models;
- (void)insertTimeTrendModel:(NSArray <LYTimeTrendModel *>*)models;

- (void)removeTimeTrendModelToIndex:(NSUInteger)index;
- (void)removeTimeTrendModelFromIndex:(NSUInteger)index;


- (void)setDelegate:(id<LYTrendViewDelegate>)delegate NS_UNAVAILABLE;
@property (weak) id<LYKLineGraphViewDelegate> kLineGraphDelegate;

/* 增长的颜色 默认绿色 */
@property (nonatomic,strong) UIColor * increaseColor;

/* 下降的颜色 默认为红色 */
@property (nonatomic,strong) UIColor * declineColor;

/* c */
@property (nonatomic,assign) CGFloat graphMargin;
/* c */
@property (nonatomic,assign) CGFloat graphWidth;


/* <#des#> */
@property (nonatomic,assign) CGSize contentSize;


@end
