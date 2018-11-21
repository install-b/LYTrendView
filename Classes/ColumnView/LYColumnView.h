//
//  HBColumnView.h
//  HBPay
//
//  Created by Shangen Zhang on 2018/1/30.
//

#import <UIKit/UIKit.h>
#import "LYTrendAnimateView.h"


@protocol LYColumnViewDelegate;
@interface LYColumnView : LYTrendAnimateView
- (void)setDelegate:(id<LYColumnViewDelegate>)delegate;

/* removeAllDrawRects */
- (void)removeAllDrawRects;

- (void)addBackgoundColor:(UIColor *)color atSection:(NSUInteger)section;
- (void)removeBackgoundColorAtSection:(NSUInteger)section;

- (CGFloat)equalColoumWidthAtSection:(NSUInteger)section;
@end


@interface LYColumn : NSObject

/** 属于哪个 坐标轴的 */
@property(nonatomic,assign) LYColumnValueType valueType ;

/** 柱状颜色 */
@property (nonatomic,strong) UIColor * columnColor;

/** 边框颜色 */
@property (nonatomic,strong)UIColor * borderColor;

/** 边框宽度 */
@property(nonatomic,assign) CGFloat borderWidth;

/** 柱状值 即 高度 */
@property(nonatomic,assign) double columnValue ;

/** 柱状宽度  */
@property(nonatomic,assign) CGFloat columnWidth ;

/** <#des#> */
@property (nonatomic,copy)NSString * title;
/*
 ...
 */

@end


@protocol LYColumnViewDelegate <LYTrendViewDelegate>

- (NSUInteger)columnView:(LYColumnView *)columnView numberOfColumnAtSetion:(NSUInteger)section;

- (LYColumn *)columnView:(LYColumnView *)columnView columnAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)columnView:(LYColumnView *)columnView didselectIndexPath:(NSIndexPath *)indexPath atTouchPoint:(CGPoint)touchP;
- (void)columnView:(LYColumnView *)columnView deDidselectIndexPath:(NSIndexPath *)indexPath atTouchPoint:(CGPoint)touchP;
@end


