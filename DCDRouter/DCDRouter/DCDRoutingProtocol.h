//
//  DCDRoutingProtocol.h
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//
#import "DCDRoutingAction.h"

#ifndef DCDRoutingProtocol_h
#define DCDRoutingProtocol_h

@protocol DCDRoutingActionResponder<NSObject>

- (BOOL)shouldHandleRoutingAction:(DCDRoutingAction *)route;
- (id)handleRoutingAction:(DCDRoutingAction *)route;

@end

@protocol DCDRoutingTargetController <NSObject>

@property (nonatomic, strong, readonly) NSDictionary *routingParams;
@property (nonatomic, strong, readonly) DCDRoutingAction *recivedAction;

- (DCDRoutingPageWay)preferredRoutingPageWay;
- (DCDRoutingPageFrom)preferredRoutingPageFrom;

@end
#endif /* DCDRoutingProtocol_h */
