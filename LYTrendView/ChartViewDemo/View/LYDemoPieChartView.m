//
//  LYDemoPieChartView.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/7.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYDemoPieChartView.h"

@implementation LYDemoPieChartView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.inCircleColor = [UIColor whiteColor];
        self.inCircleRadii = 30.0f;
    }
    return self;
}

@end
