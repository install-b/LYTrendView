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
        self.contentInsets = UIEdgeInsetsMake(10, 5, 10, 5);
        self.insetsBackgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.axesXColor = [UIColor orangeColor];
        self.axesYColor = [UIColor orangeColor];
        
        
        self.axesYBorderWidth = 1.0f;
        self.axesXBorderWidth = 1.0f;
        self.axesZBorderWidth = 0.0f;
        self.axesTBorderWidth = 0.0f;
        
        self.sectionXValue = 85.0f;
        //[self autoAdjustSectionYValueWithMaxValue:50];
        //[self autoAdjustSectionXValueWithMaxValue:90];
        self.sectionYValue = 32.0f;
        self.originYValueOffset = CGPointMake(0, -240);
        //
        self.attributesSectionXDict[NSForegroundColorAttributeName] = [UIColor redColor];
       
        self.sectionXSegmentType = LYSectionSegmentTypeDashed;
        self.sectionYSegmentType = LYSectionSegmentTypeFullLine;
        self.sectionYColor = [UIColor lightGrayColor];
        self.sectionYBorderWidth = 0.5f;
    }
    return self;
}



@end
