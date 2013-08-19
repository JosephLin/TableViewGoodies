//
//  SwitchCell.h
//  TableViewGoodies
//
//  Created by Joseph Lin on 8/19/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "CustomGroupedCell.h"


@interface SwitchCell : CustomGroupedCell

@property (nonatomic, strong) UISwitch *cellSwitch;
@property (nonatomic, copy) void (^switched)(BOOL isOn);

@end
