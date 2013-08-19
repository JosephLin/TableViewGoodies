//
//  DemoViewController.m
//  CustomGroupedTableView
//
//  Created by Joseph Lin on 8/16/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "DemoViewController.h"
#import "ArrayDataSource.h"
#import "TextFieldCell.h"
#import "SwitchCell.h"


@interface DemoViewController ()
@property (nonatomic, strong) ArrayDataSource *dataSource;
@end


@implementation DemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];    
    [self makeSections];
}

- (void)makeSections
{
    self.dataSource = [ArrayDataSource new];
    self.dataSource.textFont = [UIFont systemFontOfSize:16];
    self.dataSource.textColor = [UIColor darkGrayColor];
    self.dataSource.detailTextFont = [UIFont systemFontOfSize:12];
    self.dataSource.detailTextColor = [UIColor lightGrayColor];
    
    ArraySectionInfo *sectionInfo = nil;
    
    
    sectionInfo = [ArraySectionInfo sectionWithName:@"Basic"];
    [sectionInfo addRow:[ArrayRowInfo rowWithClassName:@"SlimCell" configure:^(UITableViewCell *cell) {
        cell.textLabel.text = @"Basic";
        cell.detailTextLabel.text = nil;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } action:nil]];
    [sectionInfo addRow:[ArrayRowInfo rowWithClassName:@"SlimCell" configure:^(UITableViewCell *cell) {
        cell.textLabel.text = @"Basic";
        cell.detailTextLabel.text = @"Detail";
        cell.accessoryType = UITableViewCellAccessoryNone;
    } action:nil]];
    [sectionInfo addRow:[ArrayRowInfo rowWithClassName:@"SlimCell" configure:^(UITableViewCell *cell) {
        cell.textLabel.text = @"Disclosure Indicator";
        cell.detailTextLabel.text = nil;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    } action:^{
        [self performSegueWithIdentifier:@"childSegue" sender:nil];
    }]];
    [sectionInfo addRow:[ArrayRowInfo rowWithClassName:@"SlimCell" configure:^(UITableViewCell *cell) {
        cell.textLabel.text = @"Disclosure Indicator";
        cell.detailTextLabel.text = @"Detail";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } action:^{
        [self performSegueWithIdentifier:@"childSegue" sender:nil];
    }]];
    [self.dataSource addSection:sectionInfo];
    
    
    sectionInfo = [ArraySectionInfo sectionWithName:@"Text Field"];
    [sectionInfo addRow:[ArrayRowInfo rowWithClassName:@"TextFieldCell" configure:^(TextFieldCell *cell) {
        cell.textField.font = self.dataSource.textFont;
        cell.textField.placeholder = @"First Name";
    } action:nil]];
    [sectionInfo addRow:[ArrayRowInfo rowWithClassName:@"TextFieldCell" configure:^(TextFieldCell *cell) {
        cell.textField.font = self.dataSource.textFont;
        cell.textField.placeholder = @"Last Name";
    } action:nil]];
    [self.dataSource addSection:sectionInfo];
    
    
    sectionInfo = [ArraySectionInfo sectionWithName:@"Switch"];
    [sectionInfo addRow:[ArrayRowInfo rowWithClassName:@"SwitchCell" configure:^(SwitchCell *cell) {
        __weak typeof(cell) weakCell = cell;
        cell.switched = ^(BOOL isOn){
            weakCell.textLabel.text = (isOn) ? @"Switch on" : @"Switch off";
        };
        cell.switched(NO);
    } action:nil]];
    [self.dataSource addSection:sectionInfo];
        
    
    [self.dataSource registerReuseIdentifiersToTableView:self.tableView];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
}


@end
