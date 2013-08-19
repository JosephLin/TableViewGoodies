//
//  SlimCell.m
//  TableViewGoodies
//
//  Created by Joseph Lin on 8/19/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "SlimCell.h"


@implementation SlimCell

- (void)initialize
{
    self.fillColor = [UIColor whiteColor];
    self.strokeColor = [UIColor lightGrayColor];
    self.lineWidth = 1.0;
    self.cornerRadius = 3.0;
    self.bevelHeight = 3.0;
    self.showBorder = YES;
}

@end
