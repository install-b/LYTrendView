//
//  LYChartLine.h
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/22.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger,LYDotPosition) {
    LYDotPositionTop,
    LYDotPositionLeft,
    LYDotPositionBottom,
    LYDotPositionRight,
    LYDotPositionCenter,
};

#pragma mark -
@protocol LYChartLinePointProtocol <NSObject>
@required
- (CGFloat)sectionValueX;
- (CGFloat)sectionValueY;
- (CGFloat)sectionValueZ;
@optional
/**
 dot lable formate
 example: LYTrendLinePoint:sectionValueX=10,sectionValueY=22.10;  formate = @"(xx,yy)" show:(10,22.10)
 */
- (NSString *)pointLableFormate;

- (LYDotPosition)pointPosition;

- (NSDictionary <NSString *,id>*)pointAttributs;
@end


@interface LYChartLine : NSObject

/** point array  */
@property (nonatomic,strong) NSArray <id<LYChartLinePointProtocol>> * pointArray;

/** smooth */
@property(nonatomic,assign) BOOL smooth;

/** border color defaul is blcak */
@property (nonatomic,strong) UIColor * borderColor;

/** border width defaul is 1 */
@property(nonatomic,assign) CGFloat borderWidth;

/** dot radii (if dotRadii > 0 will show dot) */
@property(nonatomic,assign) CGFloat dotRadii;
/** dot color */
@property (nonatomic,strong) UIColor * dotColor;

// line styles
@property(nonatomic,assign) CGLineCap lineCapStyle;
@property(nonatomic,assign) CGLineJoin lineJoinStyle;
@property(nonatomic,assign) CGFloat miterLimit; // Used when lineJoinStyle is kCGLineJoinMiter
@end
