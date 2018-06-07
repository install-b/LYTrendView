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

@interface LYPieChartView : UIView

/* 图例说明的位置 */
@property (nonatomic,assign) LYPieChartAnnotationPosition annotationPosition;

/* 饼图模型 */
@property (nonatomic,strong) NSArray <LYPieModel *> * pieModels;

/* 开始的角度 */
@property (nonatomic,assign) CGFloat startAngle;
/* 绘制的方向 */
@property (nonatomic,assign,getter=isClockwise) BOOL clockwise;


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



@end
