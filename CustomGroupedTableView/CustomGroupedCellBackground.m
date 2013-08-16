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
@property (nonatomic, strong) CAShapeLayer *footerLayer;
@end


@implementation CustomGroupedCellBackground

- (id)init
{
    self = [super init];
    self.backgroundLayer = [CAShapeLayer layer];
    self.footerLayer = [CAShapeLayer layer];
    self.fillColor = [UIColor yellowColor];
    self.strokeColor = [UIColor redColor];
    self.lineWidth = 1.0;
    self.cornerRadius = 6.0;
    return self;
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    self.backgroundLayer.fillColor = fillColor.CGColor;
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    self.backgroundLayer.strokeColor = strokeColor.CGColor;
    self.footerLayer.strokeColor = strokeColor.CGColor;
    self.footerLayer.fillColor = strokeColor.CGColor;
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

- (void)setFooterHeight:(CGFloat)footerHeight
{
    _footerHeight = footerHeight;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGSize radii = CGSizeMake(self.cornerRadius, self.cornerRadius);
    UIBezierPath *path = nil;
    
    switch (self.position) {
        case CellPositionTop:
            path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:radii];
            [self.footerLayer removeFromSuperlayer];
            break;
            
        case CellPositionBottom: {
            path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:radii];
            
            if (self.footerHeight > 0) {
                CGRect footerRect = CGRectMake(0, CGRectGetHeight(rect) - self.footerHeight, CGRectGetWidth(rect), self.footerHeight);
                self.footerLayer.path = [UIBezierPath bezierPathWithRoundedRect:footerRect byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:radii].CGPath;
                [self.layer addSublayer:self.footerLayer];
            }
            else {
                [self.footerLayer removeFromSuperlayer];
            }
            break;
        }
            
        case CellPositionSingle:
            path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:radii];
            [self.footerLayer removeFromSuperlayer];
            break;
            
        default:
            path = [UIBezierPath bezierPathWithRect:rect];
            [self.footerLayer removeFromSuperlayer];
            break;
    }
    
    self.backgroundLayer.path = path.CGPath;
    
    if (![self.backgroundLayer superlayer]) {
        [self.layer addSublayer:self.backgroundLayer];
    }
}

@end
