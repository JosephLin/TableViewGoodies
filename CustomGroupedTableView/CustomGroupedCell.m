//
//  CustomGroupedCell.m
//  CustomGroupedTableView
//
//  Created by Joseph Lin on 8/16/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "CustomGroupedCell.h"

@implementation CustomGroupedCell

- (void)setPosition:(CellPosition)position
{
    _position = position;
    
    CustomGroupedCellBackground *background = (id)self.backgroundView;
    if (![background isKindOfClass:[CustomGroupedCellBackground class]]) {
        background = [CustomGroupedCellBackground new];
        background.fillColor = self.fillColor;
        background.strokeColor = self.strokeColor;
        background.lineWidth = self.lineWidth.floatValue;
        background.cornerRadius = self.cornerRadius.floatValue;
        background.footerHeight = self.footerHeight.floatValue;
        self.backgroundView = background;
    }
    background.position = position;
    
    
    CustomGroupedCellBackground *selectedBackground = (id)[super selectedBackgroundView];
    if (![selectedBackground isKindOfClass:[CustomGroupedCellBackground class]]) {
        selectedBackground = [CustomGroupedCellBackground new];
        selectedBackground.fillColor = self.strokeColor;
        selectedBackground.strokeColor = self.strokeColor;
        selectedBackground.lineWidth = self.lineWidth.floatValue;
        selectedBackground.cornerRadius = self.cornerRadius.floatValue;
        self.selectedBackgroundView = selectedBackground;
    }
    selectedBackground.position = position;
    
    self.backgroundColor = [UIColor clearColor];
}


#pragma mark - Default Values

- (UIColor *)fillColor
{
    if (!_fillColor) {
        _fillColor = [UIColor whiteColor];
    }
    return _fillColor;
}

- (UIColor *)strokeColor
{
    if (!_strokeColor) {
        _strokeColor = [UIColor lightGrayColor];
    }
    return _strokeColor;
}

- (NSNumber *)lineWidth
{
    if (!_lineWidth) {
        _lineWidth = @1.0;
    }
    return _lineWidth;
}

- (NSNumber *)cornerRadius
{
    if (!_cornerRadius) {
        _cornerRadius = @3.0;
    }
    return _cornerRadius;
}

- (NSNumber *)footerHeight
{
    if (!_footerHeight) {
        _footerHeight = @3.0;
    }
    return _footerHeight;
}

@end
