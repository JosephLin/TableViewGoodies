//
//  CustomGroupedCell.h
//  CustomGroupedTableView
//
//  Created by Joseph Lin on 8/16/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomGroupedCellBackground.h"


@interface CustomGroupedCell : UITableViewCell

@property (nonatomic) CellPosition position;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat bevelHeight;
@property (nonatomic) BOOL showBorder;

- (void)initialize;

@end
