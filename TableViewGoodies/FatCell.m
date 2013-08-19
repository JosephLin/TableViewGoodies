//
//  FatCell.m
//  TableViewGoodies
//
//  Created by Joseph Lin on 8/19/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "FatCell.h"


@implementation FatCell

- (void)initialize
{
    self.fillColor = [UIColor yellowColor];
    self.strokeColor = [UIColor orangeColor];
    self.lineWidth = 2.0;
    self.cornerRadius = 5.0;
    self.bevelHeight = 0.0;
    self.showBorder = YES;
}

@end
