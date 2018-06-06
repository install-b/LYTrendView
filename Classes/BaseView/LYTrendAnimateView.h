//
//  LYTrendAnimateView.h
//  HBPay
//
//  Created by Shangen Zhang on 2018/2/27.
//

#import "LYTrendView.h"

@interface LYTrendAnimateView : LYTrendView

/** 进度 */
@property(nonatomic,assign,readonly) double progress;
/** 动画过程是否隐藏需要 */
@property(nonatomic,assign) BOOL shouldHiddenDrawRect;

- (void)reloadDataWithAnimate:(BOOL)animate NS_REQUIRES_SUPER;

- (void)stopAnimate;
- (void)stratAnimate;
@end
