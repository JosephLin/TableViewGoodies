//
//  ArrayRowInfo.m
//  TableViewGoodies
//
//  Created by Joseph Lin on 8/18/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "ArrayRowInfo.h"


@implementation ArrayRowInfo

+ (instancetype)rowWithClassName:(NSString *)className identifier:(NSString *)identifier configure:(void (^)(id cell))configure action:(void (^)(void))action
{
    ArrayRowInfo *rowInfo = [ArrayRowInfo new];
    rowInfo.className = className;
    rowInfo.identifier = identifier;
    rowInfo.configure = configure;
    rowInfo.action = action;
    return rowInfo;
}

+ (instancetype)rowWithClassName:(NSString *)className configure:(void (^)(id cell))configure action:(void (^)(void))action
{
    return [self rowWithClassName:className identifier:className configure:configure action:action];
}


@end
