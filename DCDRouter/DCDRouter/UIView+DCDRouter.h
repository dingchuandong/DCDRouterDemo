//
//  UIView+DCDRouter.h
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "NSObject+DCDRouter.h"
#import <UIKit/UIKit.h>
#import "DCDRoutingTapGesture.h"

@class DCDRoutingAction;

@interface UIView (DCDRouter)

@property (nonatomic, strong) NSString *routingString;
@property (nonatomic, copy) NSString *routingTargetTitle;
@property (nonatomic, weak) id routingProxy;  // User For UITableViewCell
@property (nonatomic, strong, readonly) DCDRoutingTapGesture *routingTapGesture;
@property (nonatomic, assign) BOOL routingTapEnabled;

- (UIViewController *)findViewController;

// override piont
- (void)didSetRoutingString;

- (void)performDefaultRoutingAction;

@end
