//
//  UITableViewCell+DCDRouter.m
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "UITableViewCell+DCDRouter.h"
#import "UIView+DCDRouter.h"
#import <objc/runtime.h>

@implementation UITableViewCell (DCDRouter)

- (void)setRoutingString:(NSString *)routingString
{
    self.contentView.routingString = routingString;
    self.contentView.routingProxy = self;
    self.contentView.routingTapGesture.delaysTouchesBegan = NO;
    self.contentView.routingTapGesture.delaysTouchesEnded = NO;
}

- (void)setRoutingTapEnabled:(BOOL)routingTapEnabled
{
    self.contentView.routingTapEnabled = routingTapEnabled;
}

- (NSString *)routingTargetTitle
{
    return self.contentView.routingTargetTitle;
}

- (void)setRoutingTargetTitle:(NSString *)routingTargetTitle
{
    self.contentView.routingTargetTitle = routingTargetTitle;
}

- (BOOL)routingTapEnabled
{
    return self.contentView.routingTapEnabled;
}

@end
