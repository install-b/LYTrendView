//
//  LYChartBaseView.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2018/6/7.
//  Copyright © 2018年 Shangen Zhang. All rights reserved.
//

#import "LYChartBaseView.h"

@implementation LYChartBaseView
- (void)reloadData {
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSetUps];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initSetUps];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSetUps];
}

- (void)initSetUps {
    self.backgroundColor = [UIColor clearColor];
}

- (void)setInsetsBackgroundColor:(UIColor *)insetsBackgroundColor {
    _insetsBackgroundColor = insetsBackgroundColor;
    [self setNeedsDisplay];
}
- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    _contentInsets = contentInsets;
    [self p_resetInsertRect];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self p_resetInsertRect];
}
- (void)p_resetInsertRect {
    CGRect rect = self.bounds;
    _insetRect = CGRectMake(_contentInsets.left + rect.origin.x,
                            _contentInsets.top + rect.origin.y,
                            rect.size.width - _contentInsets.left - _contentInsets.right,
                            rect.size.height - _contentInsets.top - _contentInsets.bottom);
}

- (void)drawRect:(CGRect)rect {
     // Drawing code
     [super drawRect:rect];
     // 1.  Drawing insets background color
     if (_insetsBackgroundColor) {
         UIBezierPath *backGroundPath = [UIBezierPath bezierPathWithRect:self.insetRect];
         [_insetsBackgroundColor set];
         [backGroundPath fill];
     }
}

@end
