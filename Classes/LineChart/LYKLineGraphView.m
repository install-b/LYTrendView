//
//  LYKLineGraphView.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/22.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYKLineGraphView.h"

#pragma mark - _LYLongPressPoint class implementation
@implementation LYTimeTrendModel
@end

#pragma mark - _LYLongPressPoint class
@interface _LYLongPressPoint : NSObject
/* 趋势模型 */
@property (nonatomic,strong) LYTimeTrendModel * model;
/* 偏移量 */
@property (nonatomic,assign) NSInteger offsetIndex;
/* 长按手势的位置 */
@property (nonatomic,assign) CGPoint longPressPoint;
@end
@implementation _LYLongPressPoint
@end


#pragma mark - _LYColorBezierPath class
@interface _LYColorBezierPath : UIBezierPath
/* 填充颜色 */
@property (nonatomic,strong) UIColor * strokeColor;
@end
@implementation _LYColorBezierPath
@end


#pragma mark - LYKLineGraphView extension
@interface LYKLineGraphView () <UIGestureRecognizerDelegate>
{
    _LYLongPressPoint * _longPress;   // 控制显示点击的模型
    NSArray <_LYColorBezierPath *>* _kLinePaths; // K线 路径做一个缓存  发生变化设置为nil 重新加载
}

/* 控制显示点击的模型 懒加载 */
@property (readonly) _LYLongPressPoint * longPress;

/* 数据源 */
@property (nonatomic,strong) NSArray <LYTimeTrendModel *>* models;

/* k 线 水平偏移量 */
@property (nonatomic,assign) CGFloat horizontalOffset;

/* 移动手势的位置 */
@property (nonatomic,assign) CGPoint panStartPoint;

@end

#pragma mark - LYKLineGraphView (GestureEvent) implementation
@implementation LYKLineGraphView (GestureEvent)
// 长按手势
- (void)longPressGestureEvent:(UILongPressGestureRecognizer *)longPress {
    
    switch (longPress.state) {
            // 开始
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            if (self.models.count < 1) {
                _longPress = nil;
                return;
            }
            
            CGPoint currentP = [longPress locationInView:self];
            
            CGFloat visibaleLenth = (self.sectionRight + self.horizontalOffset) + 0.5 * self.graphMargin;
            CGFloat graphW = self.graphWidth + self.graphMargin;
            
            CGFloat offset = (visibaleLenth - currentP.x);
            NSInteger indexComplement = (offset < 0) ? -1 : 1;
            NSInteger index =  offset / graphW + indexComplement;
            
            // 点击的点  跳整到中心
            currentP = CGPointMake(visibaleLenth - (index - 0.5 * indexComplement) * graphW, currentP.y);
            
            // 去重
            if (_longPress && CGPointEqualToPoint(currentP, _longPress.longPressPoint) ) {
                return;
            }
            
            // 当前没有点击的点 或者当前点击的点发送变化 重新获取model 和index
            if (!_longPress || (currentP.x != _longPress.longPressPoint.x)) {
                NSInteger offsetIndex = 0;
                LYTimeTrendModel * model = nil;
                // 寻找合适的model
                if (index >= 0) {
                    NSInteger modelIndex = self.models.count - index;
                    if (modelIndex >= 0) {
                        model =  self.models[modelIndex];
                        offsetIndex = 0;
                    }else {
                        model = self.models.firstObject;
                        offsetIndex = modelIndex;
                    }
                    
                }else {
                    model = self.models.lastObject;
                    offsetIndex = -index;
                }
                self.longPress.model = model;
                self.longPress.offsetIndex = offsetIndex;
                // send delegate
                NSLog(@"NEW OBJC ---");
            }
            self.longPress.longPressPoint = currentP;
            [self setNeedsDisplay];
        }
             break;
            // 取消
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            _longPress = nil;
            [self setNeedsDisplay];
        }
        default:
            break;
    }
}
// 捏合手势
- (void)pichGestureEvent:(UIPinchGestureRecognizer *)pich {
    
    // 调节伸缩 待优化。。。。。。
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
            [self setNeedsDisplay];
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

// 拖拽手势
- (void)panGestureEvent:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateChanged:
        {
            if (CGPointEqualToPoint(CGPointZero, self.panStartPoint)) {
                return;
            }
            CGPoint currentP = [pan locationInView:self];
            self.horizontalOffset += currentP.x - self.panStartPoint.x;
            self.panStartPoint = currentP;
            
        }
            break;
        case UIGestureRecognizerStateBegan:
        {
            
            
            self.panStartPoint = [pan locationInView:self];
            
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            self.panStartPoint = CGPointZero;
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            self.panStartPoint = CGPointZero;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 添加手势
- (void)addGestureRecognizer {
    // 拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureEvent:)];
    [self addGestureRecognizer:pan];
    
    // 捏合手势
    UIPinchGestureRecognizer *pich = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pichGestureEvent:)];
    [self addGestureRecognizer:pich];
    
    // 长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureEvent:)];
    [self addGestureRecognizer:longPress];
}
@end


#pragma mark - LYKLineGraphView implementation
@implementation LYKLineGraphView
// K线代理 强制转化
- (void)setKLineGraphDelegate:(id<LYKLineGraphViewDelegate>)kLineGraphDelegate {
    [super setDelegate:kLineGraphDelegate];
}
- (id<LYKLineGraphViewDelegate>)kLineGraphDelegate {
    return (id<LYKLineGraphViewDelegate>)super.delegate;
}

#pragma mark - 初始化
- (void)initSetUps {
    [super initSetUps];
    _graphWidth = 5.0f;
    _graphMargin = 3.0f;
    [self addGestureRecognizer];
}

#pragma mark - 重绘
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // 懒加载计算
    [[self p_getKLinePaths] enumerateObjectsUsingBlock:^(_LYColorBezierPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.strokeColor set];
        [obj stroke];
        // 是否需要填充
        if ([self shouldFillKLinePath]) {
            [obj fill];
        }
    }];
    
    
    // 显示当前点击的价格详细
    if (_longPress) {
#define price_offset 0
#define date_offset 5
#define textSpace  5

        UIBezierPath *showPath = [UIBezierPath bezierPath];
        NSDictionary *attr = @{
                               NSFontAttributeName : [UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName : [UIColor whiteColor],
                               };
        
        // 当前价格
        NSString *price = [NSString stringWithFormat:@"%.4f",[self sectionYValueFormPointY:self.longPress.longPressPoint.y]];
        
        CGSize priceSize = [price sizeWithAttributes:attr];
        
        priceSize.width += (textSpace * 2);
        
        CGPoint p1 = CGPointMake(self.sectionLeft + price_offset, self.longPress.longPressPoint.y - 0.5 * priceSize.height);
        CGPoint p2 = CGPointMake(p1.x, self.longPress.longPressPoint.y + 0.5 * priceSize.height);
        CGPoint p3 = CGPointMake(p1.x + priceSize.width, p2.y);
        CGPoint p4 = CGPointMake(p3.x, p1.y);
        // 显示价格
        [price drawInRect:CGRectMake(p1.x + textSpace, p1.y, priceSize.width, priceSize.height) withAttributes:attr];
        
        // 横轴
        [showPath moveToPoint:p1];
        [showPath addLineToPoint:p2];
        [showPath addLineToPoint:p3];
        [showPath addLineToPoint:p4];
        [showPath addLineToPoint:p1];
        [showPath moveToPoint:CGPointMake(p3.x, self.longPress.longPressPoint.y)];
        [showPath addLineToPoint:CGPointMake(self.sectionRight, self.longPress.longPressPoint.y)];
        
        // 竖轴
        NSString *dateStr = [self p_getShowDateString];
        
        
        CGSize dateSize = [dateStr sizeWithAttributes:attr];
        dateSize.width += (2 * textSpace);
        
        // 显示越界处理
        CGPoint p = CGPointMake(self.longPress.longPressPoint.x - 0.5 * dateSize.width, self.contentInsets.top + date_offset);
        CGFloat maxX = self.bounds.size.width - dateSize.width;
        if (p.x  > maxX) {
            p.x = maxX;
        }else if (p.x < 0) {
            p.x = 0;
        }
        
        [dateStr drawInRect:CGRectMake(p.x + textSpace, p.y, dateSize.width, dateSize.height) withAttributes:attr];
        
        [showPath moveToPoint:CGPointMake(self.longPress.longPressPoint.x, self.contentInsets.top)];
        [showPath addLineToPoint:CGPointMake(self.longPress.longPressPoint.x, p.y)];
        
        [showPath moveToPoint:p];
        [showPath addLineToPoint:CGPointMake(p.x, p.y + dateSize.height)];
        [showPath addLineToPoint:CGPointMake(p.x + dateSize.width, p.y + dateSize.height)];
        [showPath addLineToPoint:CGPointMake(p.x + dateSize.width, p.y)];
        [showPath addLineToPoint:p];
        
        [showPath moveToPoint:CGPointMake(self.longPress.longPressPoint.x,  p.y + dateSize.height)];
        
        [showPath addLineToPoint:CGPointMake(self.longPress.longPressPoint.x, self.sectionBottom)];
        
        [[UIColor whiteColor] set];
        [showPath stroke];
    }
    
}

#pragma mark - private method

- (NSString *)p_getShowDateString {
    LYTimeTrendModel *model = self.longPress.model;
    NSString *str = nil;
    if ([self.kLineGraphDelegate respondsToSelector:@selector(kLineGraphView:dateStringWhenTouchWithModel:atSectionOffset:)]) {
        str = [self.kLineGraphDelegate kLineGraphView:self dateStringWhenTouchWithModel:model atSectionOffset:self.longPress.offsetIndex];
    }else {
        CGFloat time = model.timeZone + self.longPress.offsetIndex * 5;
        str = [NSString stringWithFormat:@"%.2f",time];
    }
    
    return str;
}

// 获取k线 路径 懒加载
- (NSArray <_LYColorBezierPath *>*)p_getKLinePaths {
    if (_kLinePaths) {
        return _kLinePaths;
    }
    
    // 自动调节价格
    [self p_addjustKLineGraphValue];
    
    CGFloat graphW = self.graphWidth + self.graphMargin;
    CGFloat halfWidth = 0.5 * self.graphWidth;
    
    // 游标
    __block CGFloat vernierX = self.sectionRight - halfWidth + self.horizontalOffset;
    
    __block CGFloat max;
    __block CGFloat min;
    __block CGFloat top;
    __block CGFloat bottom;
    
    NSMutableArray *tempArrayM = [NSMutableArray array];
    
    // 从右到左绘制
    [self.models enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(LYTimeTrendModel * _Nonnull timeTrend, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 越界不绘制
        if (vernierX > self.sectionRight) {  // 右边越界
            vernierX -= graphW;
            return ;
        }
        if (vernierX < self.sectionLeft) { // 左边越界 停止绘制
            *stop = YES;
            return ;
        }
        
        // 获取当前时间最大值和最小值
        max = [self tranferScreenPointWithValuePoint:CGPointMake(0, timeTrend.highestPrice) valueType:LYColumnValueTypeY].y;
        min = [self tranferScreenPointWithValuePoint:CGPointMake(0, timeTrend.bottomPrice) valueType:LYColumnValueTypeY].y;
        
        UIColor *fillColor = nil;
        // 获取当前时间开盘和结束价 确定是上涨还是下降
        if (timeTrend.openPrice < timeTrend.closingPrice) {
            fillColor = self.increaseColor;
            top = [self tranferScreenPointWithValuePoint:CGPointMake(0, timeTrend.closingPrice) valueType:LYColumnValueTypeY].y;
            bottom = [self tranferScreenPointWithValuePoint:CGPointMake(0, timeTrend.openPrice) valueType:LYColumnValueTypeY].y;
        }else {
            fillColor = self.declineColor;
            top = [self tranferScreenPointWithValuePoint:CGPointMake(0, timeTrend.openPrice) valueType:LYColumnValueTypeY].y;
            bottom = [self tranferScreenPointWithValuePoint:CGPointMake(0, timeTrend.closingPrice) valueType:LYColumnValueTypeY].y;
        }
        
        
        _LYColorBezierPath *kKinePath = [_LYColorBezierPath bezierPath];
        kKinePath.strokeColor = fillColor;
        
        [kKinePath moveToPoint:CGPointMake(vernierX, max)];
        [kKinePath addLineToPoint:CGPointMake(vernierX, top)];
        [kKinePath moveToPoint:CGPointMake(vernierX, min)];
        [kKinePath addLineToPoint:CGPointMake(vernierX, bottom)];
        
        // 越界处理
        CGFloat left = vernierX - halfWidth;
        if (left < self.sectionLeft) {
            left = self.sectionLeft;
        }
        CGFloat right = vernierX + halfWidth;
        if (right > self.sectionRight) {
            right = self.sectionRight;
        }
        
        // 添加 K 线柱状 路径
        [kKinePath addLineToPoint:CGPointMake(left, bottom)];
        [kKinePath addLineToPoint:CGPointMake(left, top)];
        [kKinePath addLineToPoint:CGPointMake(right, top)];
        [kKinePath addLineToPoint:CGPointMake(right, bottom)];
        [kKinePath addLineToPoint:CGPointMake(vernierX, bottom)];
        // 偏移一个长度
        vernierX -= graphW;
        [tempArrayM addObject:kKinePath];
    }];
    
    _kLinePaths = [NSArray arrayWithArray:tempArrayM];
    
    return _kLinePaths;
}


- (NSArray <LYTimeTrendModel *>*)p_getCurrentVisibleArray {
    CGFloat length = self.sectionRight - self.sectionLeft;
    if (length <= 0) {
        return nil;
    }
    
    CGFloat graphW = self.graphWidth + self.graphMargin;
    
    NSInteger visibleNumber  = 0;
    NSInteger lastRemoveNumber = 0;
    
    if (_horizontalOffset >= 0) {
        lastRemoveNumber = (NSInteger)((_horizontalOffset + 0.5 * self.graphWidth) / graphW);
        visibleNumber = (NSInteger)((length + _horizontalOffset + 0.5 * self.graphWidth)/graphW);
    } else {
        visibleNumber = (NSInteger)((length - _horizontalOffset + 0.5 * self.graphWidth)/graphW);
    }
    
    NSArray *visiableArray =  nil;
    NSInteger objecNumber = self.models.count;
    visibleNumber = MIN(visibleNumber, objecNumber);
    
    if (visibleNumber > 0) {
        NSInteger loc = objecNumber - visibleNumber;
        loc = (loc > 0) ? loc : 0;
        NSInteger len = visibleNumber - lastRemoveNumber;
        len = (len > 0) ? len : 0;
        visiableArray = [self.models subarrayWithRange:NSMakeRange(loc, len)];
    }
    
    return visiableArray;
}

- (void)p_addjustKLineGraphValue {
    // 获取当前数组
    NSArray <LYTimeTrendModel *>* array = [self p_getCurrentVisibleArray];
    
    // 计算出最高价和最低价
    __block CGFloat max_price = 0;
    __block CGFloat min_price = 0;
    [array enumerateObjectsUsingBlock:^(LYTimeTrendModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        max_price = MAX(obj.highestPrice, max_price);
        min_price = MIN(obj.bottomPrice, min_price);
    }];
    
    CGFloat top_bottom_space = 0;
    
    CGFloat scaleY = [self sacleForSectionYPriceDifference:max_price - min_price
                                            atScreenHeight:self.sectionBottom - self.contentInsets.top
                                                    margin:&top_bottom_space];
    
    [self addjustSectionYValueWithScale:scaleY offsetValue:top_bottom_space * scaleY];
}

#pragma mark - publick mothod
- (void)appendTimeTrendModel:(NSArray <LYTimeTrendModel *>*)models {
    if (models.count) {
        _models = _models ? [models arrayByAddingObjectsFromArray:_models] : models.copy;
        _kLinePaths = nil;
        // 刷新界面
        [self setNeedsDisplay];
    }
    
}
- (void)insertTimeTrendModel:(NSArray <LYTimeTrendModel *>*)models {
    if (models.count) {
        _models = _models ? [_models arrayByAddingObjectsFromArray:models] : models.copy;
        _kLinePaths = nil;
        // 刷新界面
        [self setNeedsDisplay];
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
    _kLinePaths = nil;
    // 刷新界面
    [self setNeedsDisplay];
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
    _kLinePaths = nil;
    // 刷新界面
    [self setNeedsDisplay];
}

#pragma mark - over write setter >// setter  重写
- (void)setGraphWidth:(CGFloat)graphWidth {
    if (_graphWidth == graphWidth) {
        return;
    }
    _graphWidth = graphWidth;
    _kLinePaths = nil;
    [self setNeedsDisplay];
}
- (void)setGraphMargin:(CGFloat)graphMargin {
    if (_graphMargin == graphMargin) {
        return;
    }
    _graphMargin = graphMargin;
    _kLinePaths = nil;
    [self setNeedsDisplay];
}
- (void)setHorizontalOffset:(CGFloat)horizontalOffset {
    if (horizontalOffset == _horizontalOffset) {
        return;
    }
    _horizontalOffset = horizontalOffset;
    _kLinePaths = nil;
    [self setNeedsDisplay];
}

#pragma mark - custom setting method 子类可实现
- (BOOL)shouldFillKLinePath {
    return YES;
}

- (CGFloat)sacleForSectionYPriceDifference:(CGFloat)priceDifference atScreenHeight:(CGFloat)screen_show_H margin:(CGFloat *)margin{
    
    CGFloat top_bottom_space = 30;

    if (screen_show_H <= (2 * top_bottom_space)) {
        top_bottom_space = screen_show_H * 0.1;
    } else if (screen_show_H <= (5 * top_bottom_space)) {
        top_bottom_space *= 0.5;
    }
    
    *margin = top_bottom_space;
    
    return (priceDifference) / (screen_show_H - 2 * top_bottom_space);
}
#pragma mark - lazy load
- (_LYLongPressPoint *)longPress {
    if (!_longPress) {
        _longPress = [[_LYLongPressPoint alloc] init];
    }
    return _longPress;
}
- (UIColor *)increaseColor {
    if (!_increaseColor) {
        _increaseColor = [UIColor colorWithRed:0.03 green:0.96 blue:0.06 alpha:0.99];
    }
    return _increaseColor;
}
- (UIColor *)declineColor {
    if (!_declineColor) {
        _declineColor =[UIColor colorWithRed:0.9 green:0.06 blue:0.03 alpha:0.99];
    }
    return _declineColor;
}
@end
