//
//  LYPieChartView.h
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/6.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYPieModel.h"

// 描述信息位置
typedef enum : NSInteger {
    LYPieChartAnnotationPositionNone,       // 没有图例
    LYPieChartAnnotationPositionTop,        // 图例放在顶部
    LYPieChartAnnotationPositionLeft,       // 图例放在左边
    LYPieChartAnnotationPositionBotton,     // 图例放在底部
    LYPieChartAnnotationPositionRight,      // 图例放在右边
    LYPieChartAnnotationPositionSurround    // 环绕
} LYPieChartAnnotationPosition;

// 图例类型
typedef enum : NSUInteger {
    LYPieChartAnnotationTypeRect,  // 矩形框
    LYPieChartAnnotationTypeDot,   // 圆点
    LYPieChartAnnotationTypeHollow // 空心圆
} LYPieChartAnnotationType;


@interface LYPieChartView : UIView

/* 饼图模型 */
@property (nonatomic,strong) NSArray <LYPieModel *> * pieModels;

/* 开始绘制的角度 默认三点中方向顺时针 */
@property (nonatomic,assign) CGFloat startAngle;



/* 图例说明的位置 */
@property (nonatomic,assign) LYPieChartAnnotationPosition annotationPosition;
/* 图例的样式 */
@property (nonatomic,assign) LYPieChartAnnotationType annotationType;
/* 图例说明的字体风格 默认13 */
@property (nonatomic,strong) NSDictionary <NSAttributedStringKey,id> *annotationAttribute;


/* 外圈半径 default is min of half——width or half——height  */
@property (nonatomic,assign) CGFloat outCircleRadii;
/* 内圈半径 default is zero*/
@property (nonatomic,assign) CGFloat inCircleRadii;

/* 外圈边框 default is zero  */
@property (nonatomic,assign) CGFloat outCircleBorderWidth;
/* 内圈边框 default is zero*/
@property (nonatomic,assign) CGFloat inCircleBorderWidth;

/* 外圈边框颜色 default is nil  */
@property (nonatomic,strong) UIColor * outCircleBorderColor;
/* 内圈边框颜色 default is nil */
@property (nonatomic,strong) UIColor * inCircleBorderColor;

/* 外圆颜色 */
@property (nonatomic,strong) UIColor * outCircleColor;
/* 外圆颜色 */
@property (nonatomic,strong) UIColor * inCircleColor;


/**
 return point form the rect. where is the center of circle at this view.
  -- it can implement at your sub class

 @param rect drawrect
 @return a point
 */
- (CGPoint)circleCenterInRect:(CGRect)rect;


/**
 where rect should Cricle pie draw
 -- it can implement at your sub class

 @param rect may be self bounds
 @param annotationPosition annotation position
 @return annotation rect
 */
- (CGRect)circleRectForBounds:(CGRect)rect withAnnotationPosition:(LYPieChartAnnotationPosition)annotationPosition;


/**
 where rect should pie annotation  draw
 -- it can implement at your sub class

 @param rect may be self bounds
 @param annotationPosition annotation position
 @return annotation rect
 */
- (CGRect)annotationRectForBounds:(CGRect)rect withAnnotationPosition:(LYPieChartAnnotationPosition)annotationPosition;
@end
