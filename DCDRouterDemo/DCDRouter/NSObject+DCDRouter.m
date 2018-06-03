//
//  NSObject+DCDRouter.m
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "DCDActionRouter.h"
#import "NSObject+DCDRouter.h"
#import <objc/runtime.h>

@implementation NSObject (DCDRouter)

static char kAssociatedRoutingStringObjectKey;

- (id<DCDRoutingActionResponder>)routingResponder
{
    return [DCDActionRouter shared];
}

- (void)setRoutingString:(NSString *)routingString
{
    objc_setAssociatedObject(self, &kAssociatedRoutingStringObjectKey, routingString,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)routingString
{
    return objc_getAssociatedObject(self, &kAssociatedRoutingStringObjectKey);
}

- (id)performRoutingAction:(DCDRoutingAction *)action
{
    return [[self routingResponder] handleRoutingAction:action];
}

- (id)performRouting:(NSString *)routing
{
    return [self performRoutingAction:[DCDRoutingAction actionFor:routing sender:self]];
}

@end

