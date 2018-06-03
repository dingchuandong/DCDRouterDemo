//
//  UIButton+DCDRouter.m
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "UIButton+DCDRouter.h"
#import "DCDRoutingAction.h"
#import "UIView+DCDRouter.h"
#import <objc/runtime.h>

@implementation UIButton (DCDRouter)

- (void)didSetRoutingString
{
    [self DCDhijackActionAndTargetIfNeeded];
}

- (void)DCDhijackActionAndTargetIfNeeded
{
    SEL hijackSelector = @selector(performDefaultRoutingAction);
    
    for ( NSString *selector in [self actionsForTarget:self forControlEvent:UIControlEventTouchUpInside] ) {
        if ( hijackSelector == NSSelectorFromString(selector) ) {
            return;
        }
    }
    
    [self addTarget:self action:hijackSelector forControlEvents:UIControlEventTouchUpInside];
}

- (void)setRoutingTapEnabled:(BOOL)routingTapEnabled
{
    self.enabled = routingTapEnabled;
}

- (BOOL)routingTapEnabled
{
    return self.enabled;
}

@end

