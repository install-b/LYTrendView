//
//  LYTrendAnimateView.h
//  HBPay
//
//  Created by Shangen Zhang on 2018/2/27.
//

#import "LYTrendView.h"

@interface LYTrendAnimateView : LYTrendView

/** <#des#> */
@property(nonatomic,assign,readonly) double progress;
/** <#des#> */
@property(nonatomic,assign) BOOL shouldHiddenDrawRect;

- (void)reloadDataWithAnimate:(BOOL)animate NS_REQUIRES_SUPER;

- (void)stopAnimate;
- (void)stratAnimate;
@end
