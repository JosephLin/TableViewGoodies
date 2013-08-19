//
//  CustomGroupedCellBackground.m
//  CustomGroupedTableView
//
//  Created by Joseph Lin on 8/16/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "CustomGroupedCellBackground.h"
#import <QuartzCore/QuartzCore.h>


@interface CustomGroupedCellBackground ()
@property (nonatomic, strong) CAShapeLayer *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer *bevelLayer;
@end


@implementation CustomGroupedCellBackground

- (id)init
{
    self = [super init];
    self.backgroundLayer = [CAShapeLayer layer];
    self.bevelLayer = [CAShapeLayer layer];
    self.fillColor = [UIColor yellowColor];
    self.strokeColor = [UIColor redColor];
    self.lineWidth = 1.0;
    self.cornerRadius = 6.0;
    self.showBorder = YES;
    return self;
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    self.backgroundLayer.fillColor = fillColor.CGColor;
    self.backgroundLayer.strokeColor = (self.showBorder) ? self.strokeColor.CGColor : self.fillColor.CGColor;
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    self.backgroundLayer.strokeColor = (self.showBorder) ? self.strokeColor.CGColor : self.fillColor.CGColor;
    self.bevelLayer.strokeColor = strokeColor.CGColor;
    self.bevelLayer.fillColor = strokeColor.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    self.backgroundLayer.lineWidth = lineWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self setNeedsLayout];
}

- (void)setBevelHeight:(CGFloat)bevelHeight
{
    _bevelHeight = bevelHeight;
    [self setNeedsLayout];
}

- (void)setShowBorder:(BOOL)showBorder
{
    _showBorder = showBorder;
    self.backgroundLayer.strokeColor = (self.showBorder) ? self.strokeColor.CGColor : self.fillColor.CGColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGSize radii = CGSizeMake(self.cornerRadius, self.cornerRadius);
    UIBezierPath *path = nil;
    
    void (^showBevel)(BOOL, UIBezierPath*) = ^(BOOL showBevel, UIBezierPath *path){
        if (self.bevelHeight > 0 && showBevel) {

            self.bevelLayer.path = path.CGPath;
            self.bevelLayer.frame = rect;

            CGRect maskRect = CGRectOffset(rect, 0, CGRectGetHeight(rect) - self.bevelHeight);
            maskRect = CGRectInset(maskRect, -10, 0); // makes mask bigger to avoid artifact at the edges.

            CALayer *maskLayer = [CALayer layer];
            maskLayer.frame = maskRect;
            maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
            self.bevelLayer.mask = maskLayer;

            [self.layer addSublayer:self.bevelLayer];
        }
        else {
            [self.bevelLayer removeFromSuperlayer];
        }
    };
    
    
    switch (self.position) {
        case CellPositionTop: {
            CGRect backgroundRect = CGRectMake(0, 1, CGRectGetWidth(rect), CGRectGetHeight(rect) - 1); // to avoid being cut-off
            path = [UIBezierPath bezierPathWithRoundedRect:backgroundRect byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:radii];
            showBevel(NO, path);
            break;
        }
            
        case CellPositionBottom: {
            path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:radii];
            showBevel(YES, path);
            break;
        }
            
        case CellPositionSingle: {
            CGRect backgroundRect = CGRectMake(0, 1, CGRectGetWidth(rect), CGRectGetHeight(rect) - 1); // to avoid being cut-off
            path = [UIBezierPath bezierPathWithRoundedRect:backgroundRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:radii];
            showBevel(YES, path);
            break;
        }
            
        default:
            path = [UIBezierPath bezierPathWithRect:rect];
            showBevel(NO, path);
            break;
    }
    
    self.backgroundLayer.frame = rect;
    self.backgroundLayer.path = path.CGPath;
    
    if (![self.backgroundLayer superlayer]) {
        [self.layer addSublayer:self.backgroundLayer];
    }
}

@end
