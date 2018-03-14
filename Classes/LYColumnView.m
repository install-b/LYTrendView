//
//  HBColumnView.m
//  HBPay
//
//  Created by Shangen Zhang on 2018/1/30.
//

#import "LYColumnView.h"

@implementation LYColumn
- (instancetype)init {
    if (self = [super init]) {
        _columnWidth = 10;
        _columnColor = [UIColor redColor];
        _borderColor = [UIColor darkGrayColor];
    }
    return self;
}
@end

#define selfDelegate (id <LYColumnViewDelegate>)self.delegate

@interface LYColumnView ()
/** 蒙版底色集合 */
@property (nonatomic,strong) NSMutableDictionary * seclectionColorDictM;
@end


@implementation LYColumnView

- (void)setDelegate:(id<LYColumnViewDelegate>)delegate {
    [super setDelegate:delegate];
}


- (void)removeAllDrawRects {
    if (self.shouldHiddenDrawRect) {
        return;
    }
    self.shouldHiddenDrawRect = YES;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 绘制底色框
    [super drawRect:rect];
    
    if (self.shouldHiddenDrawRect) {
        return;
    }
    // 绘制柱状图
    if (![self.delegate respondsToSelector:@selector(numberOfSectionXForTrendView:)] ||
        ![self.delegate respondsToSelector:@selector(columnView:numberOfColumnAtSetion:)] ||
        ![self.delegate respondsToSelector:@selector(columnView:columnAtIndexPath:)]) {
        return;
    }
    NSUInteger sectionX = [self.delegate numberOfSectionXForTrendView:self];

    CGFloat columnHeight = 0;
 
    for (NSUInteger section = 0; section < sectionX; section++) {
       
        NSUInteger sectionIndex = [selfDelegate columnView:self numberOfColumnAtSetion:section];
        
        CGFloat indexSpace = self.spaceX / (sectionIndex + 1);
        
        for (NSUInteger index = 0; index < sectionIndex; index++) {
            LYColumn *column = [selfDelegate columnView:self columnAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]];
            
            CGFloat tempValue = column.columnValue * self.progress;
            columnHeight = [self lenthFromValue:tempValue >  column.columnValue ? column.columnValue : tempValue
                                  withValueType:column.valueType];

            CGFloat bottom = self.sectionBottom;
            CGFloat top    = bottom - columnHeight;
            CGFloat left   = indexSpace * (index + 1) - 0.5 * column.columnWidth + self.spaceX * section + self.sectionLeft;
            CGFloat right  = left + column.columnWidth;
            
            UIBezierPath *path = [[UIBezierPath alloc] init];
            [path moveToPoint:CGPointMake(left, bottom)];
            [path addLineToPoint:CGPointMake(left,top )];
            [path addLineToPoint:CGPointMake(right,top )];
            [path addLineToPoint:CGPointMake(right,bottom)];
            [column.borderColor set];
            [path stroke];
            
            UIBezierPath *backGroundPath = [UIBezierPath bezierPathWithRect:CGRectMake(left, top, column.columnWidth, columnHeight)];
            [column.columnColor set];
            [backGroundPath fill];
        }
        UIColor *bgColor = [_seclectionColorDictM objectForKey:@(section)];
        if ([bgColor isKindOfClass:UIColor.class]) {
            UIBezierPath *bgPath = [UIBezierPath bezierPathWithRect:
                                    CGRectMake((self.spaceX * section + self.sectionLeft),
                                               self.contentInsets.top,
                                               self.spaceX,
                                               self.sectionBottom - self.contentInsets.top)];
            [bgColor set];
            [bgPath fill];
        }
    }
    
}


- (void)addBackgoundColor:(UIColor *)color atSection:(NSUInteger)section {
    [self.seclectionColorDictM setObject:color forKey:@(section)];
    [self setNeedsDisplay];
}
- (void)removeBackgoundColorAtSection:(NSUInteger)section {
    if ([_seclectionColorDictM objectForKey:@(section)]) {
        [_seclectionColorDictM removeObjectForKey:@(section)];
        [self setNeedsDisplay];
    }
}

#pragma mark click events
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    [self sendTouchEventToDelegate:YES WithTouches:touches];
//}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self sendTouchEventToDelegate:YES WithTouches:touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self sendTouchEventToDelegate:YES WithTouches:touches];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self sendTouchEventToDelegate:NO WithTouches:touches];
}

- (void)sendTouchEventToDelegate:(BOOL)isSelect WithTouches:(NSSet<UITouch *> *)touches {
    
    CGPoint touchP = [touches.anyObject locationInView:self];
    NSIndexPath *indexPath = [self indexPathWithPoint:touchP];
    if (indexPath == nil) {
        return;
    }
    if (isSelect) {
        if ([self.delegate respondsToSelector:@selector(columnView:didselectIndexPath:atTouchPoint:)]) {
            [(id<LYColumnViewDelegate>)self.delegate columnView:self didselectIndexPath:indexPath atTouchPoint:touchP];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(columnView:deDidselectIndexPath:atTouchPoint:)]) {
            [(id<LYColumnViewDelegate>)self.delegate columnView:self deDidselectIndexPath:indexPath atTouchPoint:touchP];
        }
    }
}

- (NSIndexPath *)indexPathWithPoint:(CGPoint)point {
    
    double sectionXValue = [self sectionXValueFormPointX:point.x];
    int section = sectionXValue / self.sectionXValue;
    if (section >= [self.delegate numberOfSectionXForTrendView:self]) {
        return nil;
    }
    
    NSInteger unberIndex = [(id<LYColumnViewDelegate>)self.delegate columnView:self numberOfColumnAtSetion:section];
    int index = (sectionXValue - section * self.sectionXValue) / (self.sectionXValue / unberIndex);
    
    return [NSIndexPath indexPathForRow:index inSection:section];
}

- (NSMutableDictionary *)seclectionColorDictM {
    if (!_seclectionColorDictM) {
        _seclectionColorDictM = [NSMutableDictionary dictionary];
    }
    return _seclectionColorDictM;
}
@end
