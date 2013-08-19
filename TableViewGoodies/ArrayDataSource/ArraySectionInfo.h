//
//  ArraySectionInfo.h
//  TableViewGoodies
//
//  Created by Joseph Lin on 8/18/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArrayRowInfo.h"


@interface ArraySectionInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *indexTitle;
@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, readonly) NSUInteger numberOfObjects;

+ (instancetype)sectionWithName:(NSString *)name;
- (void)addRow:(ArrayRowInfo *)rowInfo;

@end
