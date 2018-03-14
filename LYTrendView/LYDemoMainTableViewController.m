//
//  LYDemoTableViewController.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/3/13.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYDemoMainTableViewController.h"

@interface LYDemoMainTableViewController ()
/** <#des#> */
@property (nonatomic,strong) NSArray <NSDictionary *> * demoes;
@end

@implementation LYDemoMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell_reuse_id"];
    
    self.demoes = [self dataSource];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demoes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell_reuse_id" forIndexPath:indexPath];
    cell.textLabel.text = [self.demoes[indexPath.row] objectForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *pushVcStr = [self.demoes[indexPath.row] objectForKey:@"pushVc"];
    Class vcClass = NSClassFromString(pushVcStr);
    
    UIViewController *pushVc = (UIViewController *)[[vcClass alloc] init];
    if ([pushVc isKindOfClass:UIViewController.class] == NO) {
        return;
    }
    [self.navigationController pushViewController:pushVc animated:YES];
}

- (NSArray <NSDictionary *>*)dataSource {
    return @[
             @{
                 @"title" : @"曲线图DEMO",
                 @"pushVc" : @"LYDemoLineChartViewController"
                 },
             @{
                 @"title" : @"柱状图DEMO",
                 @"pushVc" : @"LYDemoColumnViewController"
                 },
             ];
}

@end
