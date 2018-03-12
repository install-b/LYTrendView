//
//  UIBezierPath+SmoothLine.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2017/4/18.
//  Copyright © 2017年 Shangen Zhang. All rights reserved.
//

#import "UIBezierPath+SmoothLine.h"
#import <objc/message.h>

#pragma mark - C function define
static CGPoint minPoint(CGPoint,CGPoint);
static CGPoint controlPoint(CGPoint,CGPoint);

#pragma mark -  UIBezierPath category implementation
@implementation UIBezierPath (SmoothLine)
#pragma mark  method_exchange
+ (void)initialize {
     // 黑魔法 交换
    Method moveToPointM = class_getInstanceMethod(self,@selector(moveToPoint:));
    Method ly_moveToPointM = class_getInstanceMethod(self,@selector(ly_moveToPoint:));
    method_exchangeImplementations(moveToPointM,ly_moveToPointM);
}

- (void)ly_moveToPoint:(CGPoint)point {
    [self ly_moveToPoint:point];
    [self setLastPoint:point];
}
#pragma mark add property
- (void)setLastPoint:(CGPoint)point {
    id lastP = [NSValue valueWithCGPoint:point];
    objc_setAssociatedObject(self, @"last_point_key", lastP, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGPoint)lastPoint {
    id lastP = objc_getAssociatedObject(self, @"last_point_key");
    return lastP ? [lastP CGPointValue] : CGPointZero;
}
#pragma mark  add smooth line method
- (void)addSmoothLineToPoint:(CGPoint)toPoint {
    CGPoint fromP = [self lastPoint];
    CGPoint minP = minPoint(fromP, toPoint);
    
    [self addQuadCurveToPoint:minP controlPoint:controlPoint(minP, fromP)];
    [self addQuadCurveToPoint:toPoint controlPoint:controlPoint(minP , toPoint)];
    
    [self setLastPoint:toPoint];
}
@end

#pragma mark - C function
static CGPoint controlPoint(CGPoint p1,CGPoint p2) {
    
    CGPoint controlPoint = minPoint(p1, p2);
    CGFloat diffY = abs((int) (p2.y - controlPoint.y));
    if (p1.y < p2.y)
        controlPoint.y += diffY;
    else if (p1.y > p2.y)
        controlPoint.y -= diffY;
    return controlPoint;
}

static CGPoint minPoint(CGPoint p1,CGPoint p2) {
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}
