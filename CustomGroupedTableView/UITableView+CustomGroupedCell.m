//
//  UITableView+CustomGroupedCell.m
//  CustomGroupedTableView
//
//  Created by Joseph Lin on 8/16/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "UITableView+CustomGroupedCell.h"
#import <objc/runtime.h>

static char const * const kAuxDataSourceKey;


@interface UITableView () <UITableViewDataSource>
@property (nonatomic, weak) id <UITableViewDataSource> auxDataSource;
@end


@implementation UITableView (CustomGroupedCell)


#pragma mark - Swizzle dataSource and auxDataSource

+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(dataSource));
    Method otherMethod = class_getInstanceMethod(self, @selector(swizzledDataSource));
    method_exchangeImplementations(originalMethod, otherMethod);
    
    originalMethod = class_getInstanceMethod(self, @selector(setDataSource:));
    otherMethod = class_getInstanceMethod(self, @selector(swizzledSetDataSource:));
    method_exchangeImplementations(originalMethod, otherMethod);
    
    originalMethod = class_getInstanceMethod(self, @selector(forwardInvocation:));
    otherMethod = class_getInstanceMethod(self, @selector(swizzledForwardInvocation:));
    method_exchangeImplementations(originalMethod, otherMethod);

    originalMethod = class_getInstanceMethod(self, @selector(methodSignatureForSelector:));
    otherMethod = class_getInstanceMethod(self, @selector(swizzledMethodSignatureForSelector:));
    method_exchangeImplementations(originalMethod, otherMethod);
}

- (id <UITableViewDataSource>)swizzledDataSource
{
    return self.auxDataSource;
}

- (void)swizzledSetDataSource:(id <UITableViewDataSource>)dataSource
{
    [self swizzledSetDataSource:self];
    self.auxDataSource = dataSource;
}


#pragma mark - auxDataSource Getter/Setter

- (id <UITableViewDataSource>)auxDataSource
{
    return objc_getAssociatedObject(self, kAuxDataSourceKey);
}

- (void)setAuxDataSource:(id<UITableViewDataSource>)auxDataSource
{
    objc_setAssociatedObject(self, kAuxDataSourceKey, auxDataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

- (NSMethodSignature*)swizzledMethodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [self swizzledMethodSignatureForSelector:selector];
//    if (!signature) {
//        signature = [self.auxDataSource methodSignatureForSelector:selector];
//    }
    return signature;
}


- (void)swizzledForwardInvocation:(NSInvocation *)anInvocation
{
    if ([self.auxDataSource respondsToSelector:[anInvocation selector]])
        [anInvocation invokeWithTarget:self.auxDataSource];
    else
        [self swizzledForwardInvocation:anInvocation];
}



//- (BOOL)swizzledRespondsToSelector:(SEL)aSelector
//{
//    return [self swizzledRespondsToSelector:aSelector];
////    return [self swizzledRespondsToSelector:aSelector];
////    if ( [self swizzledRespondsToSelector:aSelector] )
////        return YES;
////    else if ([self.auxDataSource respondsToSelector:aSelector]){
////        return YES;
////    }
////    return NO;
//}

@end
