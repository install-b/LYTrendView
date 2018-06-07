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

/* 简介 */
@property (nonatomic,strong) NSString * summary;

/* 百分比 0 ~ 1 */
@property (nonatomic,assign) CGFloat progress;

/* <#des#> */
@property (nonatomic,assign) CGFloat rdiiOffset;

@end
