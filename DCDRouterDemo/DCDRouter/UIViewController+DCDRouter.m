//
//  UIViewController+DCDRouter.m
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "UIViewController+DCDRouter.h"
#import <objc/runtime.h>

@implementation UIViewController (DCDRouter)

- (id)performRoutingAction:(DCDRoutingAction *)action
{
    return [self handleRoutingAction:action];
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation UIViewController (DCDRoutingActionResponder)

- (void)setActionRouter:(DCDActionRouter *)actionRouter
{
    objc_setAssociatedObject(self, @selector(actionRouter), actionRouter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DCDActionRouter *)actionRouter
{
    DCDActionRouter *router = objc_getAssociatedObject(self, _cmd);
    
    if ( !router ) {
        router = [[DCDActionRouter alloc] init];
        [self setActionRouter:router];
    }
    return router;
}

- (BOOL)forwardRoutingActionToParent
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setForwardRoutingActionToParent:(BOOL)forwardRoutingActionToParent
{
    objc_setAssociatedObject(self, @selector(forwardRoutingActionToParent), @(forwardRoutingActionToParent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)shouldHandleRoutingAction:(DCDRoutingAction *)route
{
    return YES;
}

- (id)handleRoutingAction:(DCDRoutingAction *)route
{
    if ( self.forwardRoutingActionToParent ) {
        [self.parentViewController handleRoutingAction:route];
    }
    
    // 如果是 NavigationController 则转交给 RootViewController 处理
    if ( [self isKindOfClass:[UINavigationController class]] ) {
        return [[(UINavigationController *)self topViewController] handleRoutingAction:route];
    }
    else {
        if ( [self shouldHandleRoutingAction:route] ) {
            route.context = self;
            [self.actionRouter handleRoutingAction:route];
            // controller 的 router 无法处理此路由，交给全局路由处理
            if ( route.state < DCDRoutingStateSending ) {
                return [[DCDActionRouter shared] handleRoutingAction:route];
            }
        }
        
        return nil;
    }
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation UIViewController (DCDRoutingTargetController)

- (NSDictionary *)routingParams
{
    return self.recivedAction.input;
}

- (void)setRecivedAction:(DCDRoutingAction *)recivedAction
{
    objc_setAssociatedObject(self, @selector(recivedAction), recivedAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DCDRoutingAction *)recivedAction
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setPreferredRoutingPageFrom:(DCDRoutingPageFrom)preferredRoutingPageFrom
{
    objc_setAssociatedObject(self, @selector(preferredRoutingPageFrom), @(preferredRoutingPageFrom), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPreferredRoutingPageWay:(DCDRoutingPageWay)preferredRoutingPageWay
{
    objc_setAssociatedObject(self, @selector(preferredRoutingPageWay), @(preferredRoutingPageWay), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPreferredRoutingAutoNavigationWapper:(BOOL)flag
{
    objc_setAssociatedObject(self, @selector(preferredRoutingAutoNavigationWapper), @(flag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DCDRoutingPageWay)preferredRoutingPageWay
{
    if ( objc_getAssociatedObject(self, _cmd) ) {
        return [objc_getAssociatedObject(self, _cmd) integerValue];
    }
    
    return DCDRoutingPageWayAuto;
}

- (DCDRoutingPageFrom)preferredRoutingPageFrom
{
    if ( objc_getAssociatedObject(self, _cmd) ) {
        return [objc_getAssociatedObject(self, _cmd) integerValue];
    }
    
    return DCDRoutingPageFromAuto;
}

- (BOOL)preferredRoutingAutoNavigationWapper
{
    if ( objc_getAssociatedObject(self, _cmd) ) {
        return [objc_getAssociatedObject(self, _cmd) integerValue];
    }
    return YES;
}

@end


