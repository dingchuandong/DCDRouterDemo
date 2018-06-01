//
//  DCDActionRouter.h
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCDBaseRouter.h"
#import "DCDRoutingProtocol.h"
#import "DCDRoutingAction.h"

typedef NS_ENUM (NSInteger, DCDRouteType) {
    DCDRouteTypeNone           = 0,
    DCDRouteTypeViewController = 1,
    DCDRouteTypeBlock          = 2
};

typedef BOOL (^DCDRoutingTransitioningBlock)(UIViewController *from, UIViewController *to, DCDRoutingAction *action);
typedef id (^DCDRouterActionBlock)(DCDRoutingAction *action);

@interface DCDActionRouter :  DCDBaseRouter<DCDRoutingActionResponder>

@property (nonatomic, copy) Class globalNavigationClass;

- (BOOL)shouldHandleRoutingAction:(DCDRoutingAction *)route;
- (id)handleRoutingAction:(DCDRoutingAction *)route;

// block 可以返回一个 UIViewController, 此时 Router 会自行处理相关跳转工作
// block 可以返回一个 RoutingAction, 此时 Router 会自动 handle 这个RoutingAction
- (void)map:(NSString *)route toBlock:(DCDRouterActionBlock)block;
- (void)map:(NSString *)schema toControllerClass:(Class)controllerClass;

- (void)mapSchema:(NSString *)schema toBlock:(DCDRouterActionBlock)block;
- (void)mapSchema:(NSString *)schema toControllerClass:(Class)controllerClass;

@property (nonatomic, copy) DCDRoutingTransitioningBlock transitioningBlock;

@end
