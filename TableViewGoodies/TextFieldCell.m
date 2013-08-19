//
//  TextFieldCell.m
//  TableViewGoodies
//
//  Created by Joseph Lin on 8/18/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "TextFieldCell.h"


@implementation TextFieldCell

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
