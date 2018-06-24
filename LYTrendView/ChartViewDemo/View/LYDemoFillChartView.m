//
//  LYDemoFillChartView.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/6.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYDemoFillChartView.h"

@implementation LYDemoFillChartView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentInsets = UIEdgeInsetsMake(10, 5, 10, 10);
        //self.insetsBackgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.axesXColor = [UIColor darkGrayColor];
        self.axesYColor = [UIColor darkGrayColor];
        self.axesZColor = [UIColor darkGrayColor];
        
        self.axesYBorderWidth = 1.0f;
        self.axesXBorderWidth = 1.0f;
        self.axesZBorderWidth = 0.0f;
        self.axesTBorderWidth = 0.0f;
        
        self.sectionXValue = 25.0f;
        self.sectionYValue = 10.0f;
        self.attributesSectionXDict[NSForegroundColorAttributeName] = [UIColor redColor];
        
        
        self.sectionYSegmentType = LYSectionSegmentTypeDashed;
        self.sectionYColor = [UIColor lightGrayColor];
        self.sectionYBorderWidth = 0.5f;
    }
    return self;
}

@end
