//
//  LYKLineGraphView.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/22.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYKLineGraphView.h"
@implementation LYTimeTrendModel
@end



@interface LYKLineGraphView ()
/* <#des#> */
@property (nonatomic,strong) NSArray <LYTimeTrendModel *>* visibleModels;

/* <#des#> */
@property (nonatomic,strong) NSArray <LYTimeTrendModel *>* models;
@end

@implementation LYKLineGraphView
- (void)setKLineGraphDelegate:(id<LYKLineGraphViewDelegate>)kLineGraphDelegate {
    [super setDelegate:kLineGraphDelegate];
}
- (id<LYKLineGraphViewDelegate>)kLineGraphDelegate {
    return (id<LYKLineGraphViewDelegate>)super.delegate;
}

- (void)initSetUps {
    [super initSetUps];
    self.graphWidth = 5.0f;
    self.graphMargin = 3.0f;
    
    self.contentInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    UIColor *color = [UIColor lightGrayColor];
    self.sectionXColor = color;
    self.sectionYColor = color;
    
    // 长按手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureEvent:)];
    
    [self addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pich = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pichGestureEvent:)];
    [self addGestureRecognizer:pich];
}

- (void)pichGestureEvent:(UIPinchGestureRecognizer *)pich {
    //(1 - pich.scale) * 0.5
    CGFloat scale = pich.scale + (1 - pich.scale) * 0.5 ;
    switch (pich.state) {
        case UIGestureRecognizerStateBegan:
        {
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat graphWidth = self.graphWidth * scale;
            if (graphWidth > 12) {
                graphWidth = 12;
            }else if(graphWidth < 2){
                graphWidth = 2;
            }
            self.graphWidth = graphWidth;
            [self p_updateKLineGraphView];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            
        }
            break;
            
        default:
            break;
    }
}

// 长按手势
- (void)panGestureEvent:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat halfWidth = 0.5 * self.graphWidth;
    __block CGFloat leftMargin = self.sectionRight - halfWidth;
    CGFloat graphW = self.graphWidth + self.graphMargin;
    __block UIColor *fillColor = nil;
    __block CGFloat max;
    __block CGFloat min;
    __block CGFloat top;
    __block CGFloat bottom;
    
    
    [self.models enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(LYTimeTrendModel * _Nonnull timeTrend, NSUInteger idx, BOOL * _Nonnull stop) {
        
        max = [self tranferScreenPointWithValuePoint:CGPointMake(0, timeTrend.highestPrice) valueType:LYColumnValueTypeY].y;
        min = [self tranferScreenPointWithValuePoint:CGPointMake(0, timeTrend.bottomPrice) valueType:LYColumnValueTypeY].y;
        
        if (timeTrend.openPrice < timeTrend.closingPrice) {
            fillColor = self.increaseColor;
            top = [self tranferScreenPointWithValuePoint:CGPointMake(0, timeTrend.closingPrice) valueType:LYColumnValueTypeY].y;
            bottom = [self tranferScreenPointWithValuePoint:CGPointMake(0, timeTrend.openPrice) valueType:LYColumnValueTypeY].y;
        }else {
            fillColor = self.declineColor;
            top = [self tranferScreenPointWithValuePoint:CGPointMake(0, timeTrend.openPrice) valueType:LYColumnValueTypeY].y;
            bottom = [self tranferScreenPointWithValuePoint:CGPointMake(0, timeTrend.closingPrice) valueType:LYColumnValueTypeY].y;
           
        }
        
        
        UIBezierPath *kKinePath = [UIBezierPath bezierPath];
        
        [kKinePath moveToPoint:CGPointMake(leftMargin, max)];
        [kKinePath addLineToPoint:CGPointMake(leftMargin, top)];
        [kKinePath moveToPoint:CGPointMake(leftMargin, min)];
        [kKinePath addLineToPoint:CGPointMake(leftMargin, bottom)];
        
        [kKinePath addLineToPoint:CGPointMake(leftMargin - halfWidth, bottom)];
        [kKinePath addLineToPoint:CGPointMake(leftMargin - halfWidth, top)];
        [kKinePath addLineToPoint:CGPointMake(leftMargin + halfWidth, top)];
        [kKinePath addLineToPoint:CGPointMake(leftMargin + halfWidth, bottom)];
        
        [kKinePath addLineToPoint:CGPointMake(leftMargin, bottom)];
        
        [fillColor set];
        
        [kKinePath stroke];
        [kKinePath fill];
        

        leftMargin -= graphW;
    }];
   
}

- (void)p_updateKLineGraphView {
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)appendTimeTrendModel:(NSArray <LYTimeTrendModel *>*)models {
    if (models.count) {
        _models = _models ? [models arrayByAddingObjectsFromArray:_models] : models.copy;
        // 刷新界面
        [self p_updateKLineGraphView];
    }
   
}
- (void)insertTimeTrendModel:(NSArray <LYTimeTrendModel *>*)models {
    if (models.count) {
        _models = _models ? [_models arrayByAddingObjectsFromArray:models] : models.copy;
        // 刷新界面
      [self p_updateKLineGraphView];
    }
}

- (void)removeTimeTrendModelToIndex:(NSUInteger)index {
    NSUInteger count = _models.count;
    if (count == 0 || index <= 0) {
        return;
    }
   
    if (index >= count) {
        _models = nil;
    }else {
        NSRange range = NSMakeRange(index, count);
        _models = [_models subarrayWithRange:range];
    }
    
    // 刷新界面
    [self p_updateKLineGraphView];
}

- (void)removeTimeTrendModelFromIndex:(NSUInteger)index {
    NSUInteger count = _models.count;
    if (count == 0 || index >= count ) {
        return;
    }
    
    if (index <= 0) {
        _models = nil;
    }else {
        NSRange range = NSMakeRange(0, index);
        _models = [_models subarrayWithRange:range];
    }
   // 刷新界面
    [self p_updateKLineGraphView];
}

#pragma mark -
- (UIColor *)increaseColor {
    if (!_increaseColor) {
        _increaseColor = [UIColor greenColor];
    }
    return _increaseColor;
}
- (UIColor *)declineColor {
    if (!_declineColor) {
        _declineColor = [UIColor redColor];
    }
    return _declineColor;
}
@end
