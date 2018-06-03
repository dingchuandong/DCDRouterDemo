//
//  NSObject+DCDRouter.h
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "DCDRoutingAction.h"
#import <Foundation/Foundation.h>
#import "DCDRoutingProtocol.h"

@interface NSObject (DCDRouter)

- (id<DCDRoutingActionResponder>)routingResponder;
- (id)performRoutingAction:(DCDRoutingAction *)action;
- (id)performRouting:(NSString *)routing;

@end
