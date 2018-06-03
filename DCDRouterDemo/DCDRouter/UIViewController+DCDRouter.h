//
//  UIViewController+DCDRouter.h
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "DCDActionRouter.h"
#import "DCDRoutingProtocol.h"
#import "NSObject+DCDRouter.h"
#import <UIKit/UIKit.h>

@interface UIViewController (DCDRouter)

- (id)performRoutingAction:(DCDRoutingAction *)action;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIViewController (DCDRoutingActionResponder)<DCDRoutingActionResponder>

@property (nonatomic, strong) DCDActionRouter *actionRouter;
@property (nonatomic, assign) BOOL forwardRoutingActionToParent;

- (BOOL)shouldHandleRoutingAction:(DCDRoutingAction *)route;
- (id)handleRoutingAction:(DCDRoutingAction *)route;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIViewController (DCDRoutingTargetController)<DCDRoutingTargetController>

@property (nonatomic, strong) DCDRoutingAction *recivedAction;
@property (nonatomic, strong, readonly) NSDictionary *routingParams;
@property (nonatomic, assign) DCDRoutingPageWay preferredRoutingPageWay;
@property (nonatomic, assign) DCDRoutingPageFrom preferredRoutingPageFrom;
@property (nonatomic, assign) BOOL preferredRoutingAutoNavigationWapper; // 是否自动加 NavigationController

@end

