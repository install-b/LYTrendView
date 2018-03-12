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
@end


@interface LYColumn : NSObject

/** <#des#> */
@property(nonatomic,assign) LYColumnValueType valueType ;

/** <#des#> */
@property (nonatomic,strong) UIColor * columnColor;

/** <#des#> */
@property (nonatomic,strong)UIColor * borderColor;

/** <#des#> */
@property(nonatomic,assign) CGFloat borderWidth;

/** <#des#> */
@property(nonatomic,assign) double columnValue ;

/** <#des#> */
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


