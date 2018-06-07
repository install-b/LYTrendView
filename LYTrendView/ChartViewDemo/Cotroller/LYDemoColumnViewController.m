//
//  LTDemoColumnViewController.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/3/13.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYDemoColumnViewController.h"
#import "LYDemoColumnView.h"

@interface LYDemoColumnViewController () <LYColumnViewDelegate>
/** <#des#> */
@property (nonatomic,weak) LYDemoColumnView * columnView;

/** <#des#> */
@property (nonatomic,strong) NSArray <NSArray <NSNumber *>*>* dataSource;
@end

@implementation LYDemoColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.columnView stratAnimate];
}
#pragma mark - LYTrendViewDelegate
- (NSUInteger)numberOfSectionYForTrendView:(LYTrendView *)trendView {
    return 10;
}
- (NSUInteger)numberOfSectionXForTrendView:(LYTrendView *)trendView {
    return self.dataSource.count;
}
- (NSUInteger)numberOfSectionZForTrendView:(LYTrendView *)trendView {
    return 0;
}

- (NSString *)trendView:(LYTrendView *)trendView titleForSectionY:(NSUInteger)sectionY {
    return [NSString stringWithFormat:@"%zd",sectionY];
}
- (NSString *)trendView:(LYTrendView *)trendView titleForSectionX:(NSUInteger)sectionX {
    return [NSString stringWithFormat:@"%zd",sectionX];
}
- (NSString *)trendView:(LYTrendView *)trendView titleForSectionZ:(NSUInteger)sectionZ {
    return nil;
}

- (CGFloat)spaceOfSectionYTitleWidthForTrendView:(LYTrendView *)trendView {
    return 30;
}
- (CGFloat)spaceOfSectionXTitleHeightForTrendView:(LYTrendView *)trendView {
    return 20;
}
- (CGFloat)spaceOfSectionZTitleWidthForTrendView:(LYTrendView *)trendView {
    return 0;
}
- (void)columnView:(LYColumnView *)columnView didselectIndexPath:(NSIndexPath *)indexPath atTouchPoint:(CGPoint)touchP {
    [columnView addBackgoundColor:[UIColor colorWithWhite:0 alpha:0.1] atSection:indexPath.section];
}
- (void)columnView:(LYColumnView *)columnView deDidselectIndexPath:(NSIndexPath *)indexPath atTouchPoint:(CGPoint)touchP {
    [columnView removeBackgoundColorAtSection:indexPath.section];
}
#pragma mark - LYColumnViewDelegate

- (NSUInteger)columnView:(LYColumnView *)columnView numberOfColumnAtSetion:(NSUInteger)section {
    return [self.dataSource[section] count];
}

- (LYColumn *)columnView:(LYColumnView *)columnView columnAtIndexPath:(NSIndexPath *)indexPath  {
    LYColumn *column =  [[LYColumn alloc] init];
    column.valueType = LYColumnValueTypeY;
    column.columnColor = [UIColor colorWithRed:0.9 green:0.3 blue:0.5 alpha:1];
    column.columnValue = [self.dataSource[indexPath.section][indexPath.row] doubleValue];
    return column;
}


- (LYDemoColumnView *)columnView {
    if (!_columnView) {
        LYDemoColumnView *columnView = [[LYDemoColumnView alloc] initWithFrame:CGRectMake(10, 100, self.view.bounds.size.width - 20, 300)];
        columnView.delegate = self;
        [self.view addSubview:columnView];
        _columnView = columnView;
    }
    return _columnView;
}

- (NSArray <NSArray <NSNumber *>*>*)dataSource {
    if (!_dataSource) {
        _dataSource = @[
                        @[@10,@5],
                        @[@8,@9],
                        @[@1,@2,@8.5],
                        @[@6,@4],
                        @[@7,@2],
                        ];
    }
    return _dataSource;
}

@end
