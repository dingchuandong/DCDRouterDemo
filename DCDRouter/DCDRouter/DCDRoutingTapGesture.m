//
//  DCDRoutingTapGesture.m
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "DCDRoutingTapGesture.h"

@implementation DCDRoutingTapGesture

- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    self = [super initWithTarget:target action:action];
    if ( self ) {
        self.numberOfTapsRequired = 1;
        self.numberOfTouchesRequired = 1;
        self.cancelsTouchesInView = YES;
        self.delaysTouchesBegan = YES;
        self.delaysTouchesEnded = YES;
    }
    return self;
}

@end
