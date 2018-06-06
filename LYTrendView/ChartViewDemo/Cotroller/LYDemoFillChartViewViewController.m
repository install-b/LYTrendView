//
//  LYDemoFillChartViewViewController.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/6.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYDemoFillChartViewViewController.h"
#import "LYPoint.h"
#import "LYDemoFillChartView.h"

@interface LYDemoFillChartViewViewController ()

@end

@implementation LYDemoFillChartViewViewController

- (Class)trendViewClass {
    return LYDemoFillChartView.class;
}


- (NSArray *)lines {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in [self dataSource]) {
        LYChartLine *line = [[LYChartLine alloc] init];
        line.borderWidth = [dict[@"borderWidth"] floatValue];
        line.borderColor = dict[@"borderColor"];
        line.pointArray = dict[@"pointArray"];
        line.lineCapStyle = kCGLineCapRound;
        line.lineJoinStyle = kCGLineJoinRound;
        line.smooth = YES;
        [array addObject:line];
        
    }
    return array;
}


- (id)dataSource {
    
    return @[
             @{
                 @"borderWidth" : @"1.0",
                 @"borderColor" : [UIColor redColor],
                 @"pointArray" : @[
                         [[LYPoint alloc] initWithPoint:CGPointMake(0, 0)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(40, 25)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(100, 15)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(140, 25)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(180, 32)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(260, 27)],
                         ]
                 },
//             
//             @{
//                 @"borderWidth" : @"1.0",
//                 @"borderColor" : [UIColor purpleColor],
//                 @"pointArray" : @[
//                         [[LYPoint alloc] initWithPoint:CGPointMake(0, 0)],
//                         [[LYPoint alloc] initWithPoint:CGPointMake(20, 5)],
//                         [[LYPoint alloc] initWithPoint:CGPointMake(45, 10)],
//                         [[LYPoint alloc] initWithPoint:CGPointMake(80, 32)],
//                         [[LYPoint alloc] initWithPoint:CGPointMake(200, 20)],
//                         [[LYPoint alloc] initWithPoint:CGPointMake(260, 30)],
//                         ]
//                 },
             
             @{
                 @"borderWidth" : @"1.0",
                 @"borderColor" : [UIColor greenColor],
                 @"pointArray" : @[
                         [[LYPoint alloc] initWithPoint:CGPointMake(0, 20)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(30, 10)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(130, 3)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(200, 20)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(240, 26)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(260, 23)],
                         ]
                 },
             
             ];
}

@end
