//
//  ViewController.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2017/4/11.
//  Copyright © 2017年 Shangen Zhang. All rights reserved.
//

#import "LYDemoLineChartViewController.h"
#import "LYDemoLineChartView.h"
#import "LYPoint.h"


@interface LYDemoLineChartViewController ()<LYTrendViewDelegate>

/** trendView */
@property (nonatomic,weak) LYDemoLineChartView * trendView;


/* BOO */
@property (nonatomic,assign) BOOL didAddLines;
@end

@implementation LYDemoLineChartViewController

- (Class)trendViewClass {
    return LYDemoLineChartView.class;
}

- (LYDemoLineChartView *)trendView {
    if (!_trendView) {
        LYDemoLineChartView *trendView = [[[self trendViewClass] alloc] initWithFrame:CGRectMake(20, 100, 320, 250)];
         trendView.delegate = self;
        [self.view addSubview:trendView];
        _trendView = trendView;
    }
    return _trendView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // add trend view
    [self trendView];
}


#pragma mark - add line
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self trendLineClick];
}


- (void)trendLineClick {

    if (self.didAddLines) {
        return;
    }
    [self.trendView addChartLines:[self lines] withAnimate:YES];
    self.didAddLines = YES;
}

#pragma mark -  LYTrendViewDelegate
- (NSUInteger)numberOfSectionYForTrendView:(LYTrendView *)trendView {
    return 4;
}
- (NSUInteger)numberOfSectionXForTrendView:(LYTrendView *)trendView {
    return 12;
}

- (CGFloat)spaceOfSectionYTitleWidthForTrendView:(LYTrendView *)trendView {
    return 50.0f;
}
- (CGFloat)spaceOfSectionXTitleHeightForTrendView:(LYTrendView *)trendView {
    return 14.0f;
}

- (NSString *)trendView:(LYTrendView *)trendView titleForSectionY:(NSUInteger)sectionY {
    return [NSString stringWithFormat:@"%.2f",sectionY * trendView.sectionYValue];
}
- (NSString *)trendView:(LYTrendView *)trendView titleForSectionX:(NSUInteger)sectionX {
    if (sectionX  % 2) {
        return nil;
    }
    return [NSString stringWithFormat:@"%zd",sectionX / 2];
}

- (NSUInteger)numberOfSectionZForTrendView:(LYTrendView *)trendView {
    return 0;
}


- (CGFloat)spaceOfSectionZTitleWidthForTrendView:(LYTrendView *)trendView {
    return 0;
}


- (NSString *)trendView:(LYTrendView *)trendView titleForSectionZ:(NSUInteger)sectionZ {
    return nil;
}

#pragma mark - data source 假数据
- (NSArray *)lines {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in [self dataSource]) {
        LYChartLine *line = [[LYChartLine alloc] init];
        line.borderWidth = [dict[@"borderWidth"] floatValue];
        line.borderColor = dict[@"borderColor"];
        line.pointArray = dict[@"pointArray"];
        line.lineCapStyle = kCGLineCapRound;
        line.lineJoinStyle = kCGLineJoinRound;
        line.dotRadii = 3.0f;
        line.dotColor = (array.count % 2 ) ? [UIColor redColor] : [UIColor darkGrayColor];
        line.smooth = (array.count % 2 == 0);
        [array addObject:line];
        
    }
    return array;
}




- (id)dataSource {
    
    return @[
             @{
                 @"borderWidth" : @"2.0",
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
             
             @{
                 @"borderWidth" : @"1.0",
                 @"borderColor" : [UIColor blueColor],
                 @"pointArray" : @[
                         [[LYPoint alloc] initWithPoint:CGPointMake(0, 0)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(20, 5)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(45, 10)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(80, 32)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(200, 20)],
                         [[LYPoint alloc] initWithPoint:CGPointMake(260, 30)],
                         ]
                 },
             
             @{
                 @"borderWidth" : @"3.0",
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
