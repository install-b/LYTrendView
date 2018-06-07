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
        model.itemName = obj[@"itemName"];
        model.pieColor = obj[@"pieColor"];
        
        NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *str1 =  [[NSAttributedString alloc] initWithString:model.itemName attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}];
        [attrM appendAttributedString:str1];
        
        NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %.2f%%",model.progress * 100] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11], NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
        [attrM appendAttributedString:str2];
        
        model.itemNameAttr = attrM;
        [tempArrayM addObject:model];
    }];
    return [NSArray arrayWithArray:tempArrayM];
}

- (NSArray *)dataSource {
    return @[
             @{
                 @"progress" : @"0.05",
                 @"pieColor" : [UIColor redColor],
                 @"itemName" : @"BTC",
                 },
             @{
                 @"progress" : @"0.6",
                 @"pieColor" : [UIColor greenColor],
                 @"itemName" : @"ETH",
                 },
             @{
                 @"progress" : @"0.2",
                 @"pieColor" : [UIColor purpleColor],
                 @"itemName" : @"EOS",
                 },
             @{
                 @"progress" : @"0.15",
                 @"pieColor" : [UIColor blueColor],
                 @"itemName" : @"XVG",
                 },
             
             ];
}

- (LYDemoPieChartView *)pieChartView {
    if (!_pieChartView) {
        LYDemoPieChartView *pieChartView = [[LYDemoPieChartView alloc] initWithFrame:CGRectMake(50, 100, 250, 250)];
        
        [self.view addSubview:pieChartView];
        _pieChartView = pieChartView;
    }
    return _pieChartView;
}

@end
