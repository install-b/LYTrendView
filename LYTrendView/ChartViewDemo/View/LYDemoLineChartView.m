//
//  LYTestTrendView.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2017/9/7.
//  Copyright © 2017年 Shangen Zhang. All rights reserved.
//

#import "LYDemoLineChartView.h"

@implementation LYDemoLineChartView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        self.contentInsets = UIEdgeInsetsMake(10, 5, 10, 10);
        self.insetsBackgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.axesXColor = [UIColor orangeColor];
        self.axesYColor = [UIColor cyanColor];
        
        
        self.axesYBorderWidth = 2.0f;
        self.axesXBorderWidth = 2.0f;
        self.axesZBorderWidth = 0.0f;
        self.axesTBorderWidth = 0.0f;
        
        self.sectionXValue = 25.0f;
        self.sectionYValue = 10.0f;
        self.attributesSectionXDict[NSForegroundColorAttributeName] = [UIColor redColor];
       
        self.sectionXSegmentType = LYSectionSegmentTypeDashed;
        self.sectionYSegmentType = LYSectionSegmentTypeFullLine;
        self.sectionYColor = [UIColor lightGrayColor];
        self.sectionYBorderWidth = 0.5f;
    }
    return self;
}



@end
