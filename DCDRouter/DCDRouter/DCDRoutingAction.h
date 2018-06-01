//
//  DCDRoutingAction.h
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 展示页面的位置
typedef NS_ENUM (NSInteger, DCDRoutingPageFrom) {
    DCDRoutingPageFromAuto    = 0, // 无所谓
    DCDRoutingPageFromRoot    = 1, // 只在 RootViewController
    DCDRoutingPageFromContext = 2  // 在收到 Route 请求的地方
};

// 展示页面的方式
typedef NS_ENUM (NSInteger, DCDRoutingPageWay) {
    DCDRoutingPageWayAuto    = 0, // 无所谓
    DCDRoutingPageWayPush    = 1, // Push
    DCDRoutingPageWayPresent = 2  // Present
};

typedef NS_ENUM (NSInteger, DCDRoutingState) {
    DCDRoutingStateInited = 0,
    DCDRoutingStateSending,
    DCDRoutingStateArrived,
    DCDRoutingStateSucceed,
    DCDRoutingStateFailed,
    DCDRoutingStateCancelled
};

// 一些参数规则：
// 如果参数中含有 way=push 则等同于 DCDRoutingPageWayPush， way=present 等同于 DCDRoutingPageWayPresent
// from=root, from=context 同上
// 如果参数中含有 title='' 则会对 title 赋值

@class DCDRoutingAction;

typedef void (^DCDRoutingActionStateChangeBlock)(DCDRoutingAction *action);

@interface DCDRoutingAction : NSObject

@property (nonatomic, strong) NSString *routingString;
@property (nonatomic, strong) NSDictionary *options;
@property (nonatomic, strong) NSDictionary *input;
@property (nonatomic, strong) NSDictionary *output;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, weak) id sender;  // 发出者
@property (nonatomic, weak) UIViewController *context; // 处理的上下文
@property (nonatomic, weak) UIViewController *target;  // 目标

@property (nonatomic, assign) DCDRoutingPageFrom pageFrom;
@property (nonatomic, assign) DCDRoutingPageWay pageWay;

@property (nonatomic, assign) DCDRoutingState state;
@property (nonatomic, copy) DCDRoutingActionStateChangeBlock stateChangeBlock;

- (void)resetState;

+ (instancetype)actionFor:(NSString *)route;
+ (instancetype)actionFor:(NSString *)route sender:(id)sender;


@end
