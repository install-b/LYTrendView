//
//  LYDemoKLineGraphViewController.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/22.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYDemoKLineGraphViewController.h"
#import "LYDemoKLineGraphView.h"

@interface LYDemoKLineGraphViewController () <LYKLineGraphViewDelegate>

/* <#des#> */
@property (nonatomic,weak) LYDemoKLineGraphView * kLineGraphView;
/* <#des#> */
@property (nonatomic,weak) UIView * kLineGraphSectionView;
@end


@implementation LYDemoKLineGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [self kLineGraphSectionView];
    
    // 添加k线数据
    [self.kLineGraphView appendTimeTrendModel:[self models]];
    
}

#pragma mark - LYKLineGraphViewDelegate
- (NSUInteger)numberOfSectionYForTrendView:(LYTrendView *)trendView {
    return 4;
}
- (NSUInteger)numberOfSectionXForTrendView:(LYTrendView *)trendView {
    return 7;
}
- (NSUInteger)numberOfSectionZForTrendView:(LYTrendView *)trendView {
    return 0;
}

- (NSString *)trendView:(LYTrendView *)trendView titleForSectionY:(NSUInteger)sectionY {
    return nil;
}
- (NSString *)trendView:(LYTrendView *)trendView titleForSectionX:(NSUInteger)sectionX {
    return nil;
}
- (NSString *)trendView:(LYTrendView *)trendView titleForSectionZ:(NSUInteger)sectionZ {
    return nil;
}

- (CGFloat)spaceOfSectionYTitleWidthForTrendView:(LYTrendView *)trendView {
    return 0;
}
- (CGFloat)spaceOfSectionXTitleHeightForTrendView:(LYTrendView *)trendView {
    return 0;
}
- (CGFloat)spaceOfSectionZTitleWidthForTrendView:(LYTrendView *)trendView {
    return 0;
}


#pragma mark - kLineGraphView
- (LYDemoKLineGraphView *)kLineGraphView {
    if (!_kLineGraphView) {
        LYDemoKLineGraphView *kLineGraphView = [[LYDemoKLineGraphView alloc] initWithFrame:CGRectMake(0, 128, self.view.bounds.size.width, 280)];
        
        [self.view addSubview:kLineGraphView];
        kLineGraphView.kLineGraphDelegate = self;
        
        _kLineGraphView = kLineGraphView;
    }
    return _kLineGraphView;
}

- (UIView *)kLineGraphSectionView {
    if (!_kLineGraphSectionView) {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, 40)];
        sectionView.backgroundColor = [UIColor colorWithWhite:0.12 alpha:0.98];
        [self.view addSubview:sectionView];
        
        _kLineGraphSectionView = sectionView;
    }
    return _kLineGraphSectionView;
}



#pragma mark - data source
- (NSArray <LYTimeTrendModel *>*)models {
    NSArray *data = [self kLineModesData];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:data.count];
    
    CGFloat fix = 0.12 ;
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LYTimeTrendModel *model = [[LYTimeTrendModel alloc] init];
        [arrayM addObject:model];
        
        model.highestPrice = [obj[@"highestPrice"] doubleValue] + fix*idx;
        model.bottomPrice = [obj[@"bottomPrice"] doubleValue] + fix*idx;
        model.openPrice = [obj[@"openPrice"] doubleValue] + fix*idx;
        model.closingPrice = [obj[@"closingPrice"] doubleValue] + fix*idx;
        model.volume = (rand() % 300)* (idx+ 1) + 1;
    }];
    
    return [NSArray arrayWithArray:arrayM];
}


- (NSArray *)kLineModesData {
    return @[
             @{
                 @"highestPrice"  : @"42.2312",
                 @"bottomPrice"   : @"37.1023",
                 @"openPrice"     : @"41.3232",
                 @"closingPrice"  : @"38.233",
                 },
             @{
                 @"highestPrice"  : @"39.2312",
                 @"bottomPrice"   : @"33.1023",
                 @"openPrice"     : @"39.2001",
                 @"closingPrice"  : @"37.233",
                 },
             @{
                 @"highestPrice"  : @"38.2312",
                 @"bottomPrice"   : @"36.1023",
                 @"openPrice"     : @"37.7232",
                 @"closingPrice"  : @"36.2887",
                 },
             @{
                 @"highestPrice"  : @"36.8586",
                 @"bottomPrice"   : @"36.0087",
                 @"openPrice"     : @"36.2849",
                 @"closingPrice"  : @"36.7685",
                 },
             @{
                 @"highestPrice"  : @"39.5007",
                 @"bottomPrice"   : @"37.8665",
                 @"openPrice"     : @"37.6575",
                 @"closingPrice"  : @"39.0098",
                 },
             @{
                 @"highestPrice"  : @"38.2312",
                 @"bottomPrice"   : @"23.1023",
                 @"openPrice"     : @"38.1923",
                 @"closingPrice"  : @"25.233",
                 },
             @{
                 @"highestPrice"  : @"25.3232",
                 @"bottomPrice"   : @"22.8373",
                 @"openPrice"     : @"24.37233",
                 @"closingPrice"  : @"23.6342",
                 },
             @{
                 @"highestPrice"  : @"27.7342",
                 @"bottomPrice"   : @"22.1023",
                 @"openPrice"     : @"23.7342",
                 @"closingPrice"  : @"26.3276",
                 },
             @{
                 @"highestPrice"  : @"29.2312",
                 @"bottomPrice"   : @"25.1023",
                 @"openPrice"     : @"26.3232",
                 @"closingPrice"  : @"27.8231",
                 },
             @{
                 @"highestPrice"  : @"27.2312",
                 @"bottomPrice"   : @"20.1023",
                 @"openPrice"     : @"26.3232",
                 @"closingPrice"  : @"21.233",
                 },
             @{
                 @"highestPrice"  : @"22.2312",
                 @"bottomPrice"   : @"15.1023",
                 @"openPrice"     : @"21.3232",
                 @"closingPrice"  : @"17.233",
                 },
             @{
                 @"highestPrice"  : @"19.2324",
                 @"bottomPrice"   : @"17.1023",
                 @"openPrice"     : @"17.3232",
                 @"closingPrice"  : @"18.6333",
                 },
             @{
                 @"highestPrice"  : @"18.2312",
                 @"bottomPrice"   : @"14.1023",
                 @"openPrice"     : @"17.3232",
                 @"closingPrice"  : @"15.3276",
                 },
             @{
                 @"highestPrice"  : @"16.2312",
                 @"bottomPrice"   : @"8.1023",
                 @"openPrice"     : @"15.3232",
                 @"closingPrice"  : @"9.233",
                 },
             @{
                 @"highestPrice"  : @"14.2312",
                 @"bottomPrice"   : @"9.1023",
                 @"openPrice"     : @"10.3232",
                 @"closingPrice"  : @"13.2233",
                 },
             @{
                 @"highestPrice"  : @"18.2312",
                 @"bottomPrice"   : @"12.1023",
                 @"openPrice"     : @"13.3232",
                 @"closingPrice"  : @"16.233",
                 },
             @{
                 @"highestPrice"  : @"20.8283",
                 @"bottomPrice"   : @"14.2342",
                 @"openPrice"     : @"15.3232",
                 @"closingPrice"  : @"19.2233",
                 },
             @{
                 @"highestPrice"  : @"21.2312",
                 @"bottomPrice"   : @"18.1023",
                 @"openPrice"     : @"19.3232",
                 @"closingPrice"  : @"20.2333",
                 },
             @{
                 @"highestPrice"  : @"29.2312",
                 @"bottomPrice"   : @"17.4023",
                 @"openPrice"     : @"20.3232",
                 @"closingPrice"  : @"27.2233",
                 },
             @{
                 @"highestPrice"  : @"40.4312",
                 @"bottomPrice"   : @"18.1023",
                 @"openPrice"     : @"19.3232",
                 @"closingPrice"  : @"38.7433",
                 },
             
             @{
                 @"highestPrice"  : @"42.2312",
                 @"bottomPrice"   : @"37.1023",
                 @"openPrice"     : @"41.3232",
                 @"closingPrice"  : @"38.233",
                 },
             @{
                 @"highestPrice"  : @"39.2312",
                 @"bottomPrice"   : @"33.1023",
                 @"openPrice"     : @"39.2001",
                 @"closingPrice"  : @"37.233",
                 },
             @{
                 @"highestPrice"  : @"38.2312",
                 @"bottomPrice"   : @"36.1023",
                 @"openPrice"     : @"37.7232",
                 @"closingPrice"  : @"36.2887",
                 },
             @{
                 @"highestPrice"  : @"36.8586",
                 @"bottomPrice"   : @"36.0087",
                 @"openPrice"     : @"36.2849",
                 @"closingPrice"  : @"36.7685",
                 },
             @{
                 @"highestPrice"  : @"39.5007",
                 @"bottomPrice"   : @"37.8665",
                 @"openPrice"     : @"37.6575",
                 @"closingPrice"  : @"39.0098",
                 },
             @{
                 @"highestPrice"  : @"38.2312",
                 @"bottomPrice"   : @"23.1023",
                 @"openPrice"     : @"38.1923",
                 @"closingPrice"  : @"25.233",
                 },
             @{
                 @"highestPrice"  : @"25.3232",
                 @"bottomPrice"   : @"22.8373",
                 @"openPrice"     : @"24.37233",
                 @"closingPrice"  : @"23.6342",
                 },
             @{
                 @"highestPrice"  : @"27.7342",
                 @"bottomPrice"   : @"22.1023",
                 @"openPrice"     : @"23.7342",
                 @"closingPrice"  : @"26.3276",
                 },
             @{
                 @"highestPrice"  : @"29.2312",
                 @"bottomPrice"   : @"25.1023",
                 @"openPrice"     : @"26.3232",
                 @"closingPrice"  : @"27.8231",
                 },
             @{
                 @"highestPrice"  : @"27.2312",
                 @"bottomPrice"   : @"20.1023",
                 @"openPrice"     : @"26.3232",
                 @"closingPrice"  : @"21.233",
                 },
             @{
                 @"highestPrice"  : @"22.2312",
                 @"bottomPrice"   : @"15.1023",
                 @"openPrice"     : @"21.3232",
                 @"closingPrice"  : @"17.233",
                 },
             @{
                 @"highestPrice"  : @"19.2324",
                 @"bottomPrice"   : @"17.1023",
                 @"openPrice"     : @"17.3232",
                 @"closingPrice"  : @"18.6333",
                 },
             @{
                 @"highestPrice"  : @"18.2312",
                 @"bottomPrice"   : @"14.1023",
                 @"openPrice"     : @"17.3232",
                 @"closingPrice"  : @"15.3276",
                 },
             @{
                 @"highestPrice"  : @"16.2312",
                 @"bottomPrice"   : @"8.1023",
                 @"openPrice"     : @"15.3232",
                 @"closingPrice"  : @"9.233",
                 },
             @{
                 @"highestPrice"  : @"14.2312",
                 @"bottomPrice"   : @"9.1023",
                 @"openPrice"     : @"10.3232",
                 @"closingPrice"  : @"13.2233",
                 },
             @{
                 @"highestPrice"  : @"18.2312",
                 @"bottomPrice"   : @"12.1023",
                 @"openPrice"     : @"13.3232",
                 @"closingPrice"  : @"16.233",
                 },
             @{
                 @"highestPrice"  : @"20.8283",
                 @"bottomPrice"   : @"14.2342",
                 @"openPrice"     : @"15.3232",
                 @"closingPrice"  : @"19.2233",
                 },
             @{
                 @"highestPrice"  : @"30.2312",
                 @"bottomPrice"   : @"18.1023",
                 @"openPrice"     : @"20.3232",
                 @"closingPrice"  : @"28.2333",
                 },
             @{
                 @"highestPrice"  : @"35.2312",
                 @"bottomPrice"   : @"20.4023",
                 @"openPrice"     : @"23.3232",
                 @"closingPrice"  : @"33.2233",
                 },
             @{
                 @"highestPrice"  : @"40.4312",
                 @"bottomPrice"   : @"18.1023",
                 @"openPrice"     : @"19.3232",
                 @"closingPrice"  : @"38.7433",
                 },
             @{
                 @"highestPrice"  : @"42.2312",
                 @"bottomPrice"   : @"37.1023",
                 @"openPrice"     : @"41.3232",
                 @"closingPrice"  : @"38.233",
                 },
             @{
                 @"highestPrice"  : @"39.2312",
                 @"bottomPrice"   : @"33.1023",
                 @"openPrice"     : @"39.2001",
                 @"closingPrice"  : @"37.233",
                 },
             @{
                 @"highestPrice"  : @"38.2312",
                 @"bottomPrice"   : @"36.1023",
                 @"openPrice"     : @"37.7232",
                 @"closingPrice"  : @"36.2887",
                 },
             @{
                 @"highestPrice"  : @"36.8586",
                 @"bottomPrice"   : @"36.0087",
                 @"openPrice"     : @"36.2849",
                 @"closingPrice"  : @"36.7685",
                 },
             @{
                 @"highestPrice"  : @"39.5007",
                 @"bottomPrice"   : @"37.8665",
                 @"openPrice"     : @"37.6575",
                 @"closingPrice"  : @"39.0098",
                 },
             @{
                 @"highestPrice"  : @"38.2312",
                 @"bottomPrice"   : @"23.1023",
                 @"openPrice"     : @"38.1923",
                 @"closingPrice"  : @"25.233",
                 },
             @{
                 @"highestPrice"  : @"25.3232",
                 @"bottomPrice"   : @"22.8373",
                 @"openPrice"     : @"24.37233",
                 @"closingPrice"  : @"23.6342",
                 },
             @{
                 @"highestPrice"  : @"27.7342",
                 @"bottomPrice"   : @"22.1023",
                 @"openPrice"     : @"23.7342",
                 @"closingPrice"  : @"26.3276",
                 },
             @{
                 @"highestPrice"  : @"29.2312",
                 @"bottomPrice"   : @"25.1023",
                 @"openPrice"     : @"26.3232",
                 @"closingPrice"  : @"27.8231",
                 },
             @{
                 @"highestPrice"  : @"27.2312",
                 @"bottomPrice"   : @"20.1023",
                 @"openPrice"     : @"26.3232",
                 @"closingPrice"  : @"21.233",
                 },
             @{
                 @"highestPrice"  : @"22.2312",
                 @"bottomPrice"   : @"15.1023",
                 @"openPrice"     : @"21.3232",
                 @"closingPrice"  : @"17.233",
                 },
             @{
                 @"highestPrice"  : @"19.2324",
                 @"bottomPrice"   : @"17.1023",
                 @"openPrice"     : @"17.3232",
                 @"closingPrice"  : @"18.6333",
                 },
             @{
                 @"highestPrice"  : @"18.2312",
                 @"bottomPrice"   : @"14.1023",
                 @"openPrice"     : @"17.3232",
                 @"closingPrice"  : @"15.3276",
                 },
             @{
                 @"highestPrice"  : @"16.2312",
                 @"bottomPrice"   : @"8.1023",
                 @"openPrice"     : @"15.3232",
                 @"closingPrice"  : @"9.233",
                 },
             @{
                 @"highestPrice"  : @"14.2312",
                 @"bottomPrice"   : @"9.1023",
                 @"openPrice"     : @"10.3232",
                 @"closingPrice"  : @"13.2233",
                 },
             @{
                 @"highestPrice"  : @"18.2312",
                 @"bottomPrice"   : @"12.1023",
                 @"openPrice"     : @"13.3232",
                 @"closingPrice"  : @"16.233",
                 },
             @{
                 @"highestPrice"  : @"20.8283",
                 @"bottomPrice"   : @"14.2342",
                 @"openPrice"     : @"15.3232",
                 @"closingPrice"  : @"19.2233",
                 },
             @{
                 @"highestPrice"  : @"80.2312",
                 @"bottomPrice"   : @"18.1023",
                 @"openPrice"     : @"19.3232",
                 @"closingPrice"  : @"79.2333",
                 },
             @{
                 @"highestPrice"  : @"90.2312",
                 @"bottomPrice"   : @"80.4023",
                 @"openPrice"     : @"85.3232",
                 @"closingPrice"  : @"89.2233",
                 },
             @{
                 @"highestPrice"  : @"100.4312",
                 @"bottomPrice"   : @"78.1023",
                 @"openPrice"     : @"99.3232",
                 @"closingPrice"  : @"90.7433",
                 },
             ];
}

@end
