//
//  CustomGroupedTableView.m
//  CustomGroupedTableView
//
//  Created by Joseph Lin on 8/16/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "CustomGroupedTableView.h"


@interface CustomGroupedTableView () <UITableViewDataSource>
@property (nonatomic, weak) id <UITableViewDataSource> auxDataSource;
@end


@implementation CustomGroupedTableView

- (id <UITableViewDataSource>)dataSource
{
    return self.auxDataSource;
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource
{
    self.auxDataSource = dataSource;
    [super setDataSource:self];
}

#pragma mark - Override 'tableView:cellForRowAtIndexPath:'

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.auxDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[CustomGroupedCell class]]) {
        
        CustomGroupedCell *customGroupedCell = (id)cell;
        NSUInteger count = [tableView numberOfRowsInSection:indexPath.section];
        if (count == 1) {
            customGroupedCell.position = CellPositionSingle;
        }
        else {
            if (indexPath.row == 0) {
                customGroupedCell.position = CellPositionTop;
            }
            else if (indexPath.row == count - 1) {
                customGroupedCell.position = CellPositionBottom;
            }
            else {
                customGroupedCell.position = CellPositionMiddle;
            }
        }
    }
    
    return cell;
}

#pragma mark - Message Forwarding

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ( [super respondsToSelector:aSelector] )
        return YES;
    else if ([self.auxDataSource respondsToSelector:aSelector]){
        return YES;
    }
    return NO;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([self.auxDataSource respondsToSelector:[anInvocation selector]])
        [anInvocation invokeWithTarget:self.auxDataSource];
    else
        [super forwardInvocation:anInvocation];
}

@end
