//
//  LYChartBaseView.h
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/7.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYChartBaseView : UIView

/* reloadData */
- (void)reloadData;

/** contentInsets  */
@property(nonatomic,assign) UIEdgeInsets contentInsets;
/*  */
@property (nonatomic,assign,readonly) CGRect insetRect;

/** content insets background color */
@property (nonatomic,strong) UIColor * insetsBackgroundColor;

// initSetUp call when init or awake form xib
- (void)initSetUps NS_REQUIRES_SUPER;
@end
