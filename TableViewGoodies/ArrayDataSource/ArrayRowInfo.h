//
//  ArrayRowInfo.h
//  TableViewGoodies
//
//  Created by Joseph Lin on 8/18/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ArrayRowInfo : NSObject

@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) void (^configure)(id cell);
@property (nonatomic, copy) void (^action)(void);

+ (instancetype)rowWithClassName:(NSString *)className identifier:(NSString *)identifier configure:(void (^)(id cell))configure action:(void (^)(void))action;
+ (instancetype)rowWithClassName:(NSString *)className configure:(void (^)(id cell))configure action:(void (^)(void))action;

@end
