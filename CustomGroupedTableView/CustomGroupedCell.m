//
//  CustomGroupedCell.m
//  CustomGroupedTableView
//
//  Created by Joseph Lin on 8/16/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "CustomGroupedCell.h"

@implementation CustomGroupedCell

- (void)initialize
{
    self.fillColor = [UIColor whiteColor];
    self.strokeColor = [UIColor lightGrayColor];
    self.lineWidth = 1.0;
    self.cornerRadius = 3.0;
    self.bevelHeight = 3.0;
    self.showBorder = YES;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initialize];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

- (void)setPosition:(CellPosition)position
{
    _position = position;
    
    CustomGroupedCellBackground *background = (id)self.backgroundView;
    if (![background isKindOfClass:[CustomGroupedCellBackground class]]) {
        background = [CustomGroupedCellBackground new];
        background.fillColor = self.fillColor;
        background.strokeColor = self.strokeColor;
        background.lineWidth = self.lineWidth;
        background.cornerRadius = self.cornerRadius;
        background.bevelHeight = self.bevelHeight;
        background.showBorder = self.showBorder;
        self.backgroundView = background;
    }
    background.position = position;
    
    
    CustomGroupedCellBackground *selectedBackground = (id)[super selectedBackgroundView];
    if (![selectedBackground isKindOfClass:[CustomGroupedCellBackground class]]) {
        selectedBackground = [CustomGroupedCellBackground new];
        selectedBackground.fillColor = self.strokeColor;
        selectedBackground.strokeColor = self.strokeColor;
        selectedBackground.lineWidth = self.lineWidth;
        selectedBackground.cornerRadius = self.cornerRadius;
        selectedBackground.showBorder = self.showBorder;
        self.selectedBackgroundView = selectedBackground;
    }
    selectedBackground.position = position;
    
    self.backgroundColor = [UIColor clearColor];
}

@end
