//
//  SwitchCell.m
//  TableViewGoodies
//
//  Created by Joseph Lin on 8/19/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "SwitchCell.h"


@implementation SwitchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.cellSwitch = [UISwitch new];
    [self.cellSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.accessoryView = self.cellSwitch;
    return self;
}

- (IBAction)switchValueChanged:(UISwitch *)sender
{
    if (self.switched) self.switched(sender.on);
}

@end
