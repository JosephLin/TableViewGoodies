//
//  ArraySectionInfo.m
//  TableViewGoodies
//
//  Created by Joseph Lin on 8/18/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "ArraySectionInfo.h"


@implementation ArraySectionInfo

+ (instancetype)sectionWithName:(NSString *)name
{
    ArraySectionInfo *sectionInfo = [self new];
    sectionInfo.name = name;
    return sectionInfo;
}

- (void)addRow:(ArrayRowInfo *)rowInfo
{
    [self.objects addObject:rowInfo];
}


#pragma mark -

- (NSMutableArray *)objects
{
    if (!_objects) {
        _objects = [NSMutableArray new];
    }
    return _objects;
}

- (NSUInteger)numberOfObjects
{
    return [self.objects count];
}

@end
