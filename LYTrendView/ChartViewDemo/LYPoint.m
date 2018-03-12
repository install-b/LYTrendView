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
/** <#des#> */
@property (nonatomic,strong) NSDictionary * attributesDict;
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

- (LYDotPosition)pointPosition {
    return LYDotPositionTop;
}

- (NSString *)pointLableFormate {
    return @"(yy)";
}
- (NSDictionary<NSString *,id> *)pointAttributs {
    return self.attributesDict;
}

- (NSDictionary *)attributesDict {
    if (!_attributesDict) {
        NSMutableDictionary*attributesDict = [NSMutableDictionary dictionary];
        attributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:8];
        attributesDict[NSForegroundColorAttributeName] = [UIColor redColor];
        attributesDict[NSStrokeWidthAttributeName] = @"0";
        _attributesDict = attributesDict;
    }
    return _attributesDict;
}

@end
