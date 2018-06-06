//
//  LYTitlePoint.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/6.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYTitlePoint.h"
@interface LYTitlePoint ()
/** <#des#> */
@property (nonatomic,strong) NSDictionary * attributesDict;
@end
@implementation LYTitlePoint
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
