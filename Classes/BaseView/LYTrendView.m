//
//  LYTrendView.m
//  LYTrendView
//
//  Created by Shangen Zhang on 2017/4/11.
//  Copyright © 2017年 Shangen Zhang. All rights reserved.
//

#import "LYTrendView.h"
#import "NSString+LYSize.h"
#import "LYTendMath.h"

#define dotTitleMargin 3.0f

typedef void(^DrawingTitleBlock)(void);


#pragma mark -
@interface LYTrendView ()

/** original point */
@property(nonatomic,assign) CGPoint originalPoint;

/** screen scale */
@property(nonatomic,assign) CGFloat screenScale ;

/** sectionY width */
@property(nonatomic,assign) CGFloat sectionYWidth ;

/** sectionX width */
@property(nonatomic,assign) CGFloat sectionXWidth ;

/** sectionY width */
@property(nonatomic,assign) CGFloat sectionZWidth ;

@end

@implementation LYTrendView

- (void)removeAllDrawRects {
    // SUB_LCASS implementation
}

#pragma mark - init setup
- (void)initSetUps {
    [super initSetUps];
    self.axesYBorderWidth = 1.0;
    self.axesXBorderWidth = 1.0;
    self.axesZBorderWidth = 1.0;
    self.axesTBorderWidth = 1.0;
    
    self.sectionYBorderWidth = 1.0;
    self.sectionXBorderWidth = 1.0;
    self.sectionZBorderWidth = 1.0;
    
    self.sectionXValue = 1.0;
    self.sectionYValue = 1.0;
    self.sectionZValue = 1.0;
    
}

#pragma mark - redraw
#define scaleLenth 5

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    // 1. location position
    CGFloat top = self.contentInsets.top;
    CGFloat left = self.sectionYSpace + self.contentInsets.left;
    CGFloat bottom = rect.size.height - self.contentInsets.bottom - self.sectionXSpace;
    CGFloat right = rect.size.width - (self.contentInsets.right + self.sectionZSpace);
    
    
    self.originalPoint = CGPointMake(left, bottom);
    _sectionLeft = left;
    _sectionBottom = bottom;
    _sectionRight = right;
    
    // 2. drawing trend background color
    if (_trendBackGroundColor) {
        UIBezierPath *backGroundPath = [UIBezierPath bezierPathWithRect:CGRectMake(left, top, right - left, bottom - top)];
        [_trendBackGroundColor set];
        [backGroundPath fill];
    }
    
    // temp variable point
    NSDictionary *attributesDict = nil;
    NSString *sectionTitle = nil;
    
    // 3. drawing sectionY line
    NSUInteger rowY = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfSectionYForTrendView:)]) {
        rowY = [self.delegate numberOfSectionYForTrendView:self];
    }
    UIFont *font = [UIFont systemFontOfSize:11];
    if (rowY) {
        
        CGFloat spaceY = (bottom - top) / (rowY + self.verticalOutOffset);
        _spaceY = spaceY;
        UIBezierPath * sectionYPath = [UIBezierPath bezierPath];
        CGFloat tempSectionY = 0;
        CGFloat titleX =  self.contentInsets.left;
        CGFloat titleW = (left - self.contentInsets.left);
        
        
        attributesDict = self.attributesSectionYDict;
        for (NSInteger i = 0; i < rowY; i++) {
            tempSectionY = bottom - (i + 1) * spaceY;
            
            [sectionYPath moveToPoint:CGPointMake(left, tempSectionY)];
            
            CGFloat rightP = left;
            if (self.sectionYSegmentType == LYSectionSegmentTypeScale) {
                rightP += scaleLenth;
            }else if (self.sectionYSegmentType == LYSectionSegmentTypeFullLine) {
                rightP = right;
            }
            [sectionYPath addLineToPoint:CGPointMake(rightP, tempSectionY)];
            
            if ([self.delegate respondsToSelector:@selector(trendView:titleForSectionY:)]) {
                sectionTitle = [self.delegate trendView:self titleForSectionY:i];
                if (sectionTitle.length) {
                    CGRect rect = [self titleRectWithTitle:sectionTitle attributs:attributesDict fromRect:CGRectMake(titleX, tempSectionY + spaceY * 0.5, titleW, spaceY)];
                    
                    [sectionTitle drawInRect:rect withAttributes:attributesDict];
                }
            }
        }
        if ([self.delegate respondsToSelector:@selector(trendView:titleForSectionY:)]) {
            sectionTitle = [self.delegate trendView:self titleForSectionY:rowY];
            CGRect rect = [self titleRectWithTitle:sectionTitle attributs:attributesDict fromRect:CGRectMake(titleX, tempSectionY - spaceY * 0.5, titleW, spaceY)];
            [sectionTitle drawInRect:rect withAttributes:attributesDict];
            
        }
        sectionYPath.lineWidth = self.sectionYBorderWidth;
        [self.sectionYColor set];
        [sectionYPath stroke];
        _sectionYWidth = spaceY;
        
        if (self.sectionYLabelText.length) {
            CGSize size = [self.sectionYLabelText sizeWith_Font:font];
            [self.sectionYLabelText drawInRect:CGRectMake(self.sectionLeft - 0.5 * size.width, self.contentInsets.top - size.height, size.width , size.height) withAttributes:@{NSFontAttributeName : font}];
            
        }
    }else {
        _sectionYWidth = bottom - top;
    }

    
    // 4. drawing sectionZ line
    NSUInteger rowZ = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfSectionZForTrendView:)]) {
        rowZ = [self.delegate numberOfSectionZForTrendView:self];
    }
    if (rowZ) {
        CGFloat spaceZ = (bottom - top) / (rowZ + self.verticalOutOffset);
        _spaceZ = spaceZ;
        UIBezierPath * sectionZPath = [UIBezierPath bezierPath];
        CGFloat tempSectionZ = 0;
        CGFloat titleX =  right;
        CGFloat titleW = self.sectionZSpace;
    
        attributesDict = self.attributesSectionZDict;
        for (NSInteger i = 0; i < rowZ; i++) {
            tempSectionZ = bottom - (i + 1) * spaceZ;
            CGFloat leftP = right;
            if (self.sectionYSegmentType == LYSectionSegmentTypeScale) {
                leftP -= scaleLenth;
            }else if (self.sectionYSegmentType == LYSectionSegmentTypeFullLine) {
                leftP = left;
            }
            [sectionZPath moveToPoint:CGPointMake(leftP, tempSectionZ)];
            [sectionZPath addLineToPoint:CGPointMake(right, tempSectionZ)];
            
            if ([self.delegate respondsToSelector:@selector(trendView:titleForSectionZ:)]) {
                sectionTitle = [self.delegate trendView:self titleForSectionZ:i];
                if (sectionTitle.length) {
                    CGRect rect = [self titleRectWithTitle:sectionTitle attributs:attributesDict fromRect:CGRectMake(titleX, tempSectionZ + spaceZ * 0.5, titleW, spaceZ)];
                    
                    [sectionTitle drawInRect:rect withAttributes:attributesDict];
                }
            }
        }
        if ([self.delegate respondsToSelector:@selector(trendView:titleForSectionZ:)]) {
            sectionTitle = [self.delegate trendView:self titleForSectionZ:rowZ];
            CGRect rect = [self titleRectWithTitle:sectionTitle attributs:attributesDict fromRect:CGRectMake(titleX, tempSectionZ - spaceZ * 0.5, titleW, spaceZ)];
            [sectionTitle drawInRect:rect withAttributes:attributesDict];
            
        }
        sectionZPath.lineWidth = self.sectionYBorderWidth;
        [self.sectionZColor set];
        [sectionZPath stroke];
        _sectionZWidth = spaceZ;
        
        if (self.sectionZLabelText.length) {
            
            CGSize size = [self.sectionZLabelText sizeWith_Font:font];
            [self.sectionZLabelText drawInRect:CGRectMake(self.sectionRight - 0.5 * size.width, self.contentInsets.top - size.height, size.width , size.height) withAttributes:@{NSFontAttributeName : font}];
            
        }
        
    }else {
        _sectionZWidth = bottom - top;
    }
    
    
    // 4. drawing sectionX line
    NSUInteger rowX = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfSectionXForTrendView:)]) {
        rowX = [self.delegate numberOfSectionXForTrendView:self];
    }
    if (rowX) {

        CGFloat spaceX = rowZ ? (right - left) / (rowX) : (right - left) / (rowX + self.horizationOutOffset);
        _spaceX = spaceX;
        UIBezierPath * sectionXPath = [UIBezierPath bezierPath];
        CGFloat tempSectionX = 0;
        CGFloat titleY = bottom;
        attributesDict = self.attributesSectionXDict;
        for (NSInteger i = 0; i < rowX; i++) {
            tempSectionX = left + (i + 1) * spaceX;
            [sectionXPath moveToPoint:CGPointMake(tempSectionX, bottom)];
            CGFloat topP = bottom;
            if (self.sectionXSegmentType == LYSectionSegmentTypeScale) {
                topP -= scaleLenth;
            }else if (self.sectionXSegmentType == LYSectionSegmentTypeFullLine) {
                topP = top;
            }
            [sectionXPath addLineToPoint:CGPointMake(tempSectionX, topP)];
            if ([self.delegate respondsToSelector:@selector(trendView:titleForSectionX:)]) {
                sectionTitle = [self.delegate trendView:self titleForSectionX:i];
                [sectionTitle drawAtPoint:CGPointMake(tempSectionX - spaceX,titleY)withAttributes:attributesDict];
            }
        }

        if ([self.delegate respondsToSelector:@selector(trendView:titleForSectionX:)]) {
            sectionTitle = [self.delegate trendView:self titleForSectionX:rowX];
            [sectionTitle drawAtPoint:CGPointMake(left + rowX * spaceX,titleY)withAttributes:attributesDict];
        }
        sectionXPath.lineWidth = self.sectionXBorderWidth;
        [self.sectionXColor set];
        [sectionXPath stroke];
        _sectionXWidth = spaceX;
    }else {
        _sectionXWidth = right - left;
    }
    
    
    // 5. drawing axes
    // top 上
    UIBezierPath * axesTPath = [UIBezierPath bezierPath];
    [axesTPath moveToPoint:CGPointMake(left, top)];
    [axesTPath addLineToPoint:CGPointMake(right,top)];
    axesTPath.lineWidth = self.axesTBorderWidth;
    [self.axesXColor set];
    [axesTPath stroke];
    
    // left 左
    UIBezierPath * axesYPath = [UIBezierPath bezierPath];
    [axesYPath moveToPoint:CGPointMake(left,top)];
    [axesYPath addLineToPoint:CGPointMake(left, bottom)];
    axesYPath.lineWidth = self.axesYBorderWidth;
    [self.axesYColor set];
    [axesYPath stroke];
    
    // bottom 下
    UIBezierPath * axesXPath = [UIBezierPath bezierPath];
    [axesXPath moveToPoint:CGPointMake(left, bottom)];
    [axesXPath addLineToPoint:CGPointMake(right,bottom)];
    axesXPath.lineWidth = self.axesXBorderWidth;
    [self.axesXColor set];
    [axesXPath stroke];
    
    // right 右
    UIBezierPath * axesZPath = [UIBezierPath bezierPath];
    [axesZPath moveToPoint:CGPointMake(right,top)];
    [axesZPath addLineToPoint:CGPointMake(right,bottom)];
    axesZPath.lineWidth = self.axesZBorderWidth;
    [self.axesZColor set];
    [axesZPath stroke];
}



#pragma mark - pravit method

- (CGRect)titleRectWithTitle:(NSString *)title attributs:(NSDictionary <NSString *,id>*)attributs fromRect:(CGRect)rect {
    
    CGSize size = [title sizeWithAttributes:attributs];
    
    return CGRectMake((rect.size.width - size.width) * 0.5 + rect.origin.x, (rect.size.height - size.height) * 0.5 + rect.origin.y, size.width, size.height);
}

- (CGFloat)sectionXSpace {
    if ([self.delegate respondsToSelector:@selector(spaceOfSectionXTitleHeightForTrendView:)]) {
        return [self.delegate spaceOfSectionXTitleHeightForTrendView:self];
    }
    return 17.0f;
}
- (CGFloat)sectionYSpace {
    if ([self.delegate respondsToSelector:@selector(spaceOfSectionYTitleWidthForTrendView:)]) {
        return [self.delegate spaceOfSectionYTitleWidthForTrendView:self];
    }
    return 35.0f;
}
- (CGFloat)sectionZSpace {
    if ([self.delegate respondsToSelector:@selector(spaceOfSectionZTitleWidthForTrendView:)]) {
        return [self.delegate spaceOfSectionZTitleWidthForTrendView:self];
    }
    return 35.0f;
}
#pragma mark - setter
- (void)setTrendBackGroundColor:(UIColor *)trendBackGroundColor {
    _trendBackGroundColor = trendBackGroundColor;
    [self setNeedsDisplay];
}


#pragma mark - lazy load
- (UIColor *)axesYColor {
    if (!_axesYColor) {
        _axesYColor = [UIColor blackColor];
    }
    return _axesYColor;
}
- (UIColor *)axesXColor {
    if (!_axesXColor) {
        _axesXColor = [UIColor blackColor];
    }
    return _axesXColor;
}
- (UIColor *)axesZColor {
    if (!_axesZColor) {
        _axesZColor = [UIColor blackColor];
    }
    return _axesZColor;
}
- (UIColor *)axesTColor {
    if (!_axesZColor) {
        _axesZColor = [UIColor blackColor];
    }
    return _axesZColor;
}

- (UIColor *)sectionYColor {
    if (!_sectionYColor) {
        _sectionYColor = [UIColor darkGrayColor];
    }
    return _sectionYColor;
}
- (UIColor *)sectionXColor {
    if (!_sectionXColor) {
        _sectionXColor = [UIColor darkGrayColor];
    }
    return _sectionXColor;
}
- (UIColor *)sectionZColor {
    if (!_sectionZColor) {
        _sectionZColor = [UIColor darkGrayColor];
    }
    return _sectionZColor;
}

- (NSMutableDictionary *)attributesSectionYDict {
    if (!_attributesSectionYDict) {
        NSMutableDictionary*attributesDict = [NSMutableDictionary dictionary];
        attributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        attributesDict[NSForegroundColorAttributeName] = self.sectionYColor;
        attributesDict[NSStrokeWidthAttributeName] = @"0";
        _attributesSectionYDict = attributesDict;
    }
    return _attributesSectionYDict;
}

- (NSMutableDictionary *)attributesSectionXDict {
    if (!_attributesSectionXDict) {
        NSMutableDictionary*attributesDict = [NSMutableDictionary dictionary];
        attributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        attributesDict[NSForegroundColorAttributeName] = self.sectionXColor;
        attributesDict[NSStrokeWidthAttributeName] = @"0";
        _attributesSectionXDict = attributesDict;
    }
    return _attributesSectionXDict;
}
- (NSMutableDictionary *)attributesSectionZDict {
    if (!_attributesSectionZDict) {
        NSMutableDictionary*attributesDict = [NSMutableDictionary dictionary];
        attributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        attributesDict[NSForegroundColorAttributeName] = self.sectionXColor;
        attributesDict[NSStrokeWidthAttributeName] = @"0";
        _attributesSectionZDict = attributesDict;
    }
    return _attributesSectionZDict;
}
@end


@implementation LYTrendView (TranferPoint)
- (CGPoint)tranferScreenPointWithValuePoint:(CGPoint)valuePoint valueType:(LYColumnValueType)valueType{
    
    CGFloat scaleY = (valueType == LYColumnValueTypeY) ?
                    _sectionYWidth / _sectionYValue  :
                    _sectionZWidth / _sectionZValue ;
    
    CGFloat scaleX = _sectionXWidth / _sectionXValue ;
    
    return CGPointMake(valuePoint.x * scaleX + self.originalPoint.x, self.originalPoint.y - valuePoint.y * scaleY);
}
- (CGFloat)lenthFromValue:(CGFloat)value withValueType:(LYColumnValueType)valueType {
    CGFloat scale = (valueType == LYColumnValueTypeY) ?
    _sectionYWidth / _sectionYValue  :
    _sectionZWidth / _sectionZValue ;
    
    return value * scale;
}


- (CGFloat)sectionXValueFormPointX:(CGFloat)px {
    return (px - self.originalPoint.x) * self.sectionXValue / self.sectionXWidth;
}
- (CGFloat)sectionYValueFormPointX:(CGFloat)py {
    return (self.originalPoint.y - py) * self.sectionYValue / self.sectionYWidth;
}
- (CGFloat)sectionZValueFormPointX:(CGFloat)py {
    return (self.originalPoint.y - py) * self.sectionZValue / self.sectionZWidth;
}
@end

@implementation LYTrendView (AutoAdjustSectionValue)
- (void)autoAdjustSectionYValueWithMaxValue:(LYTrendValue)value {
    int sectionYCount = (int)[self.delegate numberOfSectionYForTrendView:self];
    
    self.sectionYValue = ly_fixDoubleValueToInterValue(value, sectionYCount,0.3,NULL,NULL);
}
- (void)autoAdjustSectionZValueWithMaxValue:(LYTrendValue)value {
    int sectionZCount = (int)[self.delegate numberOfSectionZForTrendView:self];
    
    self.sectionZValue = ly_fixDoubleValueToInterValue(value, sectionZCount,0.3,NULL,NULL);
}
- (void)autoAdjustSectionXValueWithMaxValue:(LYTrendValue)value {
    int sectionXCount = (int)[self.delegate numberOfSectionXForTrendView:self];
    
    self.sectionXValue = ly_fixDoubleValueToInterValue(value, sectionXCount,0,NULL,NULL);
}
@end
