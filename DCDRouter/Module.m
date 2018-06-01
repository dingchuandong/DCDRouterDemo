//
//  Module.m
//  RouterDemo
//
//  Created by boohee on 2018/4/28.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "Module.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@implementation Module

+(void)load
{
    [[DCDRouter shared] map:@"/First"
         toControllerClass:[FirstViewController class]];
    [[DCDRouter shared] map:@"/Second"
         toControllerClass:[SecondViewController class]];
    [[DCDRouter shared] map:@"/Third"
         toControllerClass:[ThirdViewController class]];
}

@end
