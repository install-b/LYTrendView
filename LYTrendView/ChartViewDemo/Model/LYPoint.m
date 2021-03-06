//
//  LYPoint.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2017/4/12.
//  Copyright © 2017年 Shangen Zhang. All rights reserved.
//

#import "LYPoint.h"

@interface LYPoint ()
/** 包装的点 */
@property(nonatomic,assign) CGPoint point;

@end

@implementation LYPoint
- (instancetype)initWithPoint:(CGPoint)point {
    if (self = [super init]) {
        self.point = point;
    }
    return self;
}

- (CGFloat)sectionValueY {
    return self.point.y;
}
- (CGFloat)sectionValueX {
    return self.point.x;
}
- (CGFloat)sectionValueZ {
    return 0;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"X= %f Y=%f",_point.x,_point.y];
}
@end
