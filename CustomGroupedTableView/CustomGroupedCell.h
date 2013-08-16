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
@property (nonatomic, strong) NSNumber *lineWidth;
@property (nonatomic, strong) NSNumber *cornerRadius;
@property (nonatomic, strong) NSNumber *footerHeight;

@end
