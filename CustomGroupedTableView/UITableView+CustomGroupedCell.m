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

+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)otherSelector
{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
	Method otherMethod = class_getInstanceMethod(self, otherSelector);
    
	class_addMethod(self, originalSelector, class_getMethodImplementation(self, originalSelector), method_getTypeEncoding(originalMethod));
	class_addMethod(self, otherSelector, class_getMethodImplementation(self, otherSelector), method_getTypeEncoding(otherMethod));
    
	method_exchangeImplementations(class_getInstanceMethod(self, originalSelector), class_getInstanceMethod(self, otherSelector));
}

+ (void)load
{
    [self swizzleSelector:@selector(dataSource) withSelector:@selector(swizzledDataSource)];
    [self swizzleSelector:@selector(setDataSource:) withSelector:@selector(swizzledSetDataSource:)];
    [self swizzleSelector:@selector(respondsToSelector:) withSelector:@selector(swizzledRespondsToSelector:)];
    [self swizzleSelector:@selector(forwardInvocation:) withSelector:@selector(swizzledForwardInvocation:)];    
}

- (id <UITableViewDataSource>)swizzledDataSource
{
    return self.auxDataSource;
}

- (void)swizzledSetDataSource:(id <UITableViewDataSource>)dataSource
{
    self.auxDataSource = dataSource;
    [self swizzledSetDataSource:self];
}


#pragma mark - auxDataSource Getter/Setter

- (id <UITableViewDataSource>)auxDataSource
{
    id  <UITableViewDataSource> auxDataSource = objc_getAssociatedObject(self, kAuxDataSourceKey);
    return auxDataSource;
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

- (BOOL)swizzledRespondsToSelector:(SEL)aSelector
{
    if ( [self swizzledRespondsToSelector:aSelector] )
        return YES;
    else if ([self.auxDataSource respondsToSelector:aSelector]){
        return YES;
    }
    return NO;
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        signature = [(id)self.auxDataSource methodSignatureForSelector:selector];
    }
    return signature;
}

- (void)swizzledForwardInvocation:(NSInvocation *)anInvocation
{
    if ([self.auxDataSource respondsToSelector:[anInvocation selector]])
        [anInvocation invokeWithTarget:self.auxDataSource];
    else
        [self swizzledForwardInvocation:anInvocation];
}

@end
