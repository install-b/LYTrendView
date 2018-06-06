//
//  LYPieChartView.h
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/6.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    LYPieChartAnnotationPositionNone,  // 没有图例
    LYPieChartAnnotationPositionTop,   // 图例放在顶部
    LYPieChartAnnotationPositionLeft,  // 图例放在左边
    LYPieChartAnnotationPositionBotton,// 图例放在底部
    LYPieChartAnnotationPositionRight, // 图例放在右边
    LYPieChartAnnotationPositionSurround  // 环绕
} LYPieChartAnnotationPosition;

@interface LYPieChartView : UIView

/* 图例说明的位置 */
@property (nonatomic,assign) LYPieChartAnnotationPosition annotationPosition;

/* 外圈半径 default is min of half——width or half——height  */
@property (nonatomic,assign) CGFloat outCircleRadii;

/* 内圈半径 default is zero*/
@property (nonatomic,assign) CGFloat inCircleRadii;



- (void)reloadData:(NSArray *)datas;

@end
