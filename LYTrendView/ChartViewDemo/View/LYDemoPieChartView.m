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
        self.inCircleRadii = 20.0f;
        self.annotationPosition = LYPieChartAnnotationPositionLeft;
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (CGRect)annotationRectForBounds:(CGRect)rect withAnnotationPosition:(LYPieChartAnnotationPosition)annotationPosition {
    CGRect rect1 = [super annotationRectForBounds:rect withAnnotationPosition:annotationPosition];
    
    rect1.origin.x += 20;
    
    return rect1;
}

@end
