//
//  LYPieModel.h
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/6.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYPieModel : NSObject
/* 颜色 */
@property (nonatomic,strong) UIColor * pieColor;

/* 名称 */
@property (nonatomic,strong) NSString * itemName;
/* 名称的富文本 */
@property (nonatomic,strong) NSAttributedString * itemNameAttr;

/* 简介 */
@property (nonatomic,strong) NSString * summary;

/* 百分比  取值范围;0 ~ 1 */
@property (nonatomic,assign) CGFloat progress;

/* 半径偏移量 相对于 外圆半径的偏移 */
@property (nonatomic,assign) CGFloat radiiOffset;

@end
