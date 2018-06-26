//
//  LYDemoKLineGraphView.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/25.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYDemoKLineGraphView.h"

@implementation LYDemoKLineGraphView

- (void)initSetUps {
    [super initSetUps];
    self.contentInsets = UIEdgeInsetsMake(0, 1, 80, 1);
    
    UIColor *sectionColor = [UIColor darkGrayColor];
    self.sectionXColor = sectionColor;
    self.sectionYColor = sectionColor;
    self.sectionXSegmentType = LYSectionSegmentTypeDashed;
    self.sectionYSegmentType = LYSectionSegmentTypeDashed;
    
    UIColor *axColor = [UIColor colorWithWhite:0.1 alpha:1];
    self.axesXColor = axColor;
    self.axesYColor = axColor;
    self.axesZColor = axColor;
    self.axesTColor = axColor;
    self.axesXBorderWidth = 1.0f;
    self.axesYBorderWidth = 1.0f;
    self.axesZBorderWidth = 1.0f;
    self.axesTBorderWidth = 1.0f;
    
    self.backgroundColor = [UIColor colorWithRed:0.15 green:0.20 blue:0.20 alpha:0.98];
}

@end
