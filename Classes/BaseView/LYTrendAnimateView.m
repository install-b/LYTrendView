//
//  LYTrendAnimateView.m
//  HBPay
//
//  Created by Shangen Zhang on 2018/2/27.
//

#import "LYTrendAnimateView.h"


#define duration 1.0f


@interface LYTrendAnimateView ()
/** 开始动画 */
@property(nonatomic,assign) BOOL beginAnima;

/** 动画定时器 */
@property (nonatomic,strong)CADisplayLink * displayLink;

/** 动画开始的时间 */
@property(nonatomic,assign) NSTimeInterval startTime ;

@end



@implementation LYTrendAnimateView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.progress = 1.0;
    }
    return self;
}
- (void)setProgress:(CGFloat)progress {
    if (progress < 0) {
        _progress = 0;
    }else if(progress > 1){
        _progress = 1;
    }
    _progress = progress;
}

- (void)reloadDataWithAnimate:(BOOL)animate {
    self.shouldHiddenDrawRect = NO;
    if (animate) {
        if (self.beginAnima) {
            return;
        }
        self.beginAnima = YES;
        [self stratAnimate];
    }else {
        [super reloadData];
    }
}

- (void)drawRectAnimate:(CADisplayLink *)displayLink {
    self.progress = (CFAbsoluteTimeGetCurrent() - self.startTime) / duration;
    [self reloadData];
}

- (void)stratAnimate {
    self.startTime = CFAbsoluteTimeGetCurrent();
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stopAnimate];
    });
}
- (void)stopAnimate {
    
    [_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.beginAnima = NO;
}

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawRectAnimate:)];
    }
    return _displayLink;
}
@end
