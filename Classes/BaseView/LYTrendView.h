//
//  LYTrendView.h
//  LYTrendView
//
//  Created by Shangen Zhang on 2017/4/11.
//  Copyright © 2017年 Shangen Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "LYTendMath.h"
#import "LYChartBaseView.h"

typedef NS_ENUM(NSInteger,LYSectionSegmentType) {
    LYSectionSegmentTypeScale,
    LYSectionSegmentTypeNone,
    LYSectionSegmentTypeFullLine,
    LYSectionSegmentTypeDashed,
};

typedef NS_ENUM(NSInteger,LYColumnValueType) {
    LYColumnValueTypeY,
    LYColumnValueTypeZ,
};

typedef double LYTrendValue;


@protocol LYTrendViewDelegate;

@interface LYTrendView : LYChartBaseView

/** delegate */
@property (nonatomic,weak) id<LYTrendViewDelegate> delegate;

/** trend view background color */
@property (nonatomic,strong) UIColor * trendBackGroundColor;

/** section X value size default is 1.0 */
@property(nonatomic,assign) CGFloat sectionXValue;
/** section Y value size default is 1.0 */
@property(nonatomic,assign) CGFloat sectionYValue;
/** section Z value size default is 1.0 */
@property(nonatomic,assign) CGFloat sectionZValue;

/** axesX color */
@property (nonatomic,strong) UIColor * axesXColor;
/** axesY color */
@property (nonatomic,strong) UIColor * axesYColor;
/** axesZ color */
@property (nonatomic,strong) UIColor * axesZColor;
/** axesT color */
@property (nonatomic,strong) UIColor * axesTColor;

/** section segment style for X axes */
@property(nonatomic,assign) LYSectionSegmentType sectionXSegmentType;
/** section segment style for Y axes */
@property(nonatomic,assign) LYSectionSegmentType sectionYSegmentType;
/** section segment style for Z axes */
@property(nonatomic,assign) LYSectionSegmentType sectionZSegmentType;

/** axesX border  width */
@property(nonatomic,assign) CGFloat axesXBorderWidth;
/** axesY border  width */
@property(nonatomic,assign) CGFloat axesYBorderWidth;
/** axesZ border  width */
@property(nonatomic,assign) CGFloat axesZBorderWidth;
/** axesT border  width */
@property(nonatomic,assign) CGFloat axesTBorderWidth;


/** sectionX line corlor */
@property (nonatomic,strong) UIColor * sectionXColor;
/** sectionY line corlor */
@property (nonatomic,strong) UIColor * sectionYColor;
/** sectionZ line corlor */
@property (nonatomic,strong) UIColor * sectionZColor;

/** horization line out offset  0~1 */
@property (nonatomic,assign) CGFloat horizationOutOffset;
/** vertical line out offset  0~1 */
@property (nonatomic,assign) CGFloat verticalOutOffset;


/** sectionX line width */
@property (nonatomic,assign) CGFloat sectionXBorderWidth;
/** sectionY line width */
@property (nonatomic,assign) CGFloat sectionYBorderWidth;
/** sectionZ line width */
@property (nonatomic,assign) CGFloat sectionZBorderWidth;


/** draw section X title attributesTextInfo */
@property (nonatomic,strong) NSMutableDictionary * attributesSectionXDict;
/** draw section Y title attributesTextInfo */
@property (nonatomic,strong) NSMutableDictionary * attributesSectionYDict;
/** draw section Z title attributesTextInfo */
@property (nonatomic,strong) NSMutableDictionary * attributesSectionZDict;

/** axesY originX */
@property(nonatomic,assign,readonly) CGFloat sectionLeft ;
/** axesY originX */
@property(nonatomic,assign,readonly) CGFloat sectionBottom ;
/** <#des#> */
@property(nonatomic,assign,readonly) CGFloat sectionRight ;
///** <#des#> */
//@property(nonatomic,assign,readonly) CGFloat sectionTop ;
/** <#des#> */
@property(nonatomic,assign,readonly) CGFloat spaceX ;
/** <#des#> */
@property(nonatomic,assign,readonly) CGFloat spaceY ;
/** <#des#> */
@property(nonatomic,assign,readonly) CGFloat spaceZ ;

/** sectionYLabelText */
@property (nonatomic,copy)NSString * sectionYLabelText;
/** sectionYLabelText */
@property (nonatomic,copy)NSString * sectionZLabelText;
@end

@interface LYTrendView (SectionLine)

- (CGFloat)solidLengthOfSectionXDashedFormLineWith:(CGFloat)lineWith atSection:(NSInteger)section;
- (CGFloat)spaceLengthOfSectionXDashedFormLineWith:(CGFloat)lineWith atSection:(NSInteger)section;

- (CGFloat)solidLengthOfSectionYDashedFormLineWith:(CGFloat)lineWith atSection:(NSInteger)section;
- (CGFloat)spaceLengthOfSectionYDashedFormLineWith:(CGFloat)lineWith atSection:(NSInteger)section;

- (CGFloat)solidLengthOfSectionZDashedFormLineWith:(CGFloat)lineWith atSection:(NSInteger)section;
- (CGFloat)spaceLengthOfSectionZDashedFormLineWith:(CGFloat)lineWith atSection:(NSInteger)section;
@end

@interface LYTrendView (TranferPoint)

/**
 valuePoint transfer to ScreenPoint(view position)

 @param valuePoint valuePoint
 @param valueType valueType
 @return ScreenPoint
 */
- (CGPoint)tranferScreenPointWithValuePoint:(CGPoint)valuePoint
                                  valueType:(LYColumnValueType)valueType;


- (CGFloat)lenthFromValue:(CGFloat)value
            withValueType:(LYColumnValueType)valueType;


- (CGFloat)sectionXValueFormPointX:(CGFloat)px;
- (CGFloat)sectionYValueFormPointY:(CGFloat)py;
- (CGFloat)sectionZValueFormPointZ:(CGFloat)pz;

@end

@interface LYTrendView (AutoAdjustSectionValue)

- (void)autoAdjustSectionYValueWithMaxValue:(LYTrendValue)value;

- (void)autoAdjustSectionZValueWithMaxValue:(LYTrendValue)value;

- (void)autoAdjustSectionXValueWithMaxValue:(LYTrendValue)value;
@end





@protocol LYTrendViewDelegate <NSObject>
- (NSUInteger)numberOfSectionYForTrendView:(LYTrendView *)trendView;
- (NSUInteger)numberOfSectionXForTrendView:(LYTrendView *)trendView;
- (NSUInteger)numberOfSectionZForTrendView:(LYTrendView *)trendView;

- (NSString *)trendView:(LYTrendView *)trendView titleForSectionY:(NSUInteger)sectionY;
- (NSString *)trendView:(LYTrendView *)trendView titleForSectionX:(NSUInteger)sectionX;
- (NSString *)trendView:(LYTrendView *)trendView titleForSectionZ:(NSUInteger)sectionZ;

- (CGFloat)spaceOfSectionYTitleWidthForTrendView:(LYTrendView *)trendView;
- (CGFloat)spaceOfSectionXTitleHeightForTrendView:(LYTrendView *)trendView;
- (CGFloat)spaceOfSectionZTitleWidthForTrendView:(LYTrendView *)trendView;
@optional
- (CGFloat)trendView:(LYTrendView *)trendView sectionYValue:(NSUInteger)sectionY;
- (CGFloat)trendView:(LYTrendView *)trendView sectionXValue:(NSUInteger)sectionX;
- (CGFloat)trendView:(LYTrendView *)trendView sectionZValue:(NSUInteger)sectionZ;

@end
