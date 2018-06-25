//
//  LYKLineGraphView.h
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/22.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

// K-Line Graph K线图

#import "LYLineChartView.h"



/**
 k 线 时间价格走势模型
 */
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



@protocol LYKLineGraphViewDelegate;

/**
 k 线视图
 */
@interface LYKLineGraphView : LYLineChartView

// 添加数据源
- (void)appendTimeTrendModel:(NSArray <LYTimeTrendModel *>*)models;
- (void)insertTimeTrendModel:(NSArray <LYTimeTrendModel *>*)models;
// 移除数据源
- (void)removeTimeTrendModelToIndex:(NSUInteger)index;
- (void)removeTimeTrendModelFromIndex:(NSUInteger)index;

// 需要遵循 K线代理 协议
- (void)setDelegate:(id<LYTrendViewDelegate>)delegate NS_UNAVAILABLE;
@property (weak) id<LYKLineGraphViewDelegate> kLineGraphDelegate;


/* 柱状图之间的间隙 默认为 3 */
@property (nonatomic,assign) CGFloat graphMargin;
/* 柱状图的宽度 默认为 5  */
@property (nonatomic,assign) CGFloat graphWidth;

/* 增长的颜色 默认绿色 */
@property (nonatomic,strong) UIColor * increaseColor;
/* 下降的颜色 默认为红色 */
@property (nonatomic,strong) UIColor * declineColor;


/**
 是否需要填充K线柱状图 默认为YES  不需要填充子类可返回NO
 */
- (BOOL)shouldFillKLinePath;

/**
 自动调节比例 子类实现

 @param priceDifference 当前显示的价格差价
 @param screen_show_H 可显示的屏幕高度
 @param margin 需要返回一个最大最小离上下边界线的距离
 @return 价格与屏幕的比例  一个屏幕点代表多少价格 （价格/屏幕展示的长度）
 */
- (CGFloat)sacleForSectionYPriceDifference:(CGFloat)priceDifference
                            atScreenHeight:(CGFloat)screen_show_H
                                    margin:(CGFloat *)margin;
@end


/**
 k 线视图 代理协议
 */
@protocol LYKLineGraphViewDelegate <LYTrendViewDelegate>
@optional


/**
 长按选择了K线 模型
 
 @param kLineGraphView K线图
 @param model 选择的模型
 @param offset 离当前时间的模型 的距离  如果当前点击的点是存在模型则偏移量为0 当点击的点没有时间趋势模型 则获取到最近的模型传递出来正数为右边
 */
- (void)kLineGraphView:(LYKLineGraphView *)kLineGraphView didTouchTimeTrendModel:(LYTimeTrendModel *)model atSectionOffset:(NSInteger)offset;


/**
 取消长按选择
 
 @param kLineGraphView K线图
 */
- (void)kLineGraphViewDidCancelTouch:(LYKLineGraphView *)kLineGraphView;

/**
 根据价格 返回显示价格字符串 实现代理可以
 
 @param kLineGraphView k线图
 @param price 价格
 @return 选择区域的显示价格
 */
- (NSString *)kLineGraphView:(LYKLineGraphView *)kLineGraphView priceStringWhenTouchWithPrice:(CGFloat)price;

/**
 点击查看详情的时候返回一个显示的时间
 
 @param model 当前时间的模型
 @param offset 离当前时间的模型 的距离  如果当前点击的点是存在模型则偏移量为0 当点击的点没有时间趋势模型 则获取到最近的模型传递出来正数为右边
 @return 显示时间
 */
- (NSString *)kLineGraphView:(LYKLineGraphView *)kLineGraphView dateStringWhenTouchWithModel:(LYTimeTrendModel *)model atSectionOffset:(NSInteger)offset;

@end

