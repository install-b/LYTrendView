//
//  LYDemoPieViewController.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/7.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYDemoPieViewController.h"
#import "LYDemoPieChartView.h"

@interface LYDemoPieViewController ()
/* <#des#> */
@property (nonatomic,weak) LYDemoPieChartView * pieChartView;
@end

@implementation LYDemoPieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.pieChartView.pieModels = [self pieModels];
}


- (NSArray <LYPieModel *>*)pieModels {
    NSArray *data = [self dataSource];
    if (data.count < 1) {
        return nil;
    }
    NSMutableArray *tempArrayM = [NSMutableArray arrayWithCapacity:data.count];
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LYPieModel *model = [[LYPieModel alloc] init];
        model.progress = [obj[@"progress"] floatValue];
        [tempArrayM addObject:model];
    }];
    return [NSArray arrayWithArray:tempArrayM];
}

- (NSArray *)dataSource {
    return @[
             @{
                 @"progress" : @"0.1",
                 @"itemName" : @"",
                 },
             @{
                 @"progress" : @"0.4",
                 @"itemName" : @"",
                 },
             @{
                 @"progress" : @"0.3",
                 @"itemName" : @"",
                 },
             @{
                 @"progress" : @"0.2",
                 @"itemName" : @"",
                 },
             
             ];
}

- (LYDemoPieChartView *)pieChartView {
    if (!_pieChartView) {
        LYDemoPieChartView *pieChartView = [[LYDemoPieChartView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
        
        [self.view addSubview:pieChartView];
        _pieChartView = pieChartView;
    }
    return _pieChartView;
}

@end
