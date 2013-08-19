//
//  ArrayDataSource.h
//  TableViewGoodies
//
//  Created by Joseph Lin on 8/18/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArraySectionInfo.h"


@interface ArrayDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

// Optional properties to set table-wide font/color
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIFont *detailTextFont;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *detailTextColor;

- (void)addSection:(ArraySectionInfo *)sectionInfo;
- (void)clear;
- (void)registerReuseIdentifiersToTableView:(UITableView *)tableView;

@end
