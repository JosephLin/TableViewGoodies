//
//  ArrayDataSource.m
//  TableViewGoodies
//
//  Created by Joseph Lin on 8/18/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "ArrayDataSource.h"


@interface ArrayDataSource ()
@property (nonatomic, strong) NSMutableArray *sections;
@end


@implementation ArrayDataSource

- (NSMutableArray *)sections
{
    if (!_sections) {
        _sections = [NSMutableArray new];
    }
    return _sections;
}

- (void)addSection:(ArraySectionInfo *)sectionInfo;
{
    [self.sections addObject:sectionInfo];
}

- (void)clear
{
    [self.sections removeAllObjects];
}

- (void)registerReuseIdentifiersToTableView:(UITableView *)tableView
{
    for (ArraySectionInfo *sectionInfo in self.sections) {
        for (ArrayRowInfo *rowInfo in sectionInfo.objects) {
            if ([[NSBundle mainBundle] pathForResource:rowInfo.className ofType:@"nib"]) {
                UINib *nib = [UINib nibWithNibName:rowInfo.className bundle:[NSBundle mainBundle]];
                [tableView registerNib:nib forCellReuseIdentifier:rowInfo.identifier];
            }
            else {
                [tableView registerClass:NSClassFromString(rowInfo.className) forCellReuseIdentifier:rowInfo.identifier];
            }
        }
    }
}


#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ArraySectionInfo *sectionInfo = self.sections[section];
    return sectionInfo.name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ArraySectionInfo *sectionInfo = self.sections[section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArraySectionInfo *sectionInfo = self.sections[indexPath.section];
    ArrayRowInfo *rowInfo = sectionInfo.objects[indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rowInfo.identifier];
    
    if (self.textFont) cell.textLabel.font = self.textFont;
    if (self.detailTextFont) cell.detailTextLabel.font = self.detailTextFont;
    if (self.textColor) cell.textLabel.textColor = self.textColor;
    if (self.detailTextColor) cell.detailTextLabel.textColor = self.detailTextColor;
    
    rowInfo.configure(cell);
    
    return cell;
}


#pragma mark - Delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArraySectionInfo *sectionInfo = self.sections[indexPath.section];
    ArrayRowInfo *rowInfo = sectionInfo.objects[indexPath.row];
    return (rowInfo.action) ? indexPath : nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ArraySectionInfo *sectionInfo = self.sections[indexPath.section];
    ArrayRowInfo *rowInfo = sectionInfo.objects[indexPath.row];
    if (rowInfo.action) rowInfo.action();
}

@end
