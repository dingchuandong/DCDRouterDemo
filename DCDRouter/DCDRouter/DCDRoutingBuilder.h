//
//  DCDRoutingBuilder.h
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCDRoutingAction.h"

#define ROUTING(pattern) [[DCDRoutingBuilder alloc] initWithPattern:pattern]
#define AS_RoutingPattern(__key) @property (nonatomic, readonly) DCDRoutingBuilder *__key; \
+ (NSString *)__key

#define DEF_RoutingPattern(__name, __value) \
- (DCDRoutingBuilder *)__name \
{ \
return ROUTING( __value ); \
} \
+ (NSString *)__name \
{ \
return __value; \
} \

@class DCDRoutingBuilder;
typedef DCDRoutingBuilder *(^DCDRoutingKeyValueParamBlock)(NSString *key, id format, ...);
typedef DCDRoutingBuilder *(^DCDRoutingOrderedParamBlock)(id first, ...);

@interface DCDRoutingBuilder : NSObject

@property (nonatomic, readonly, copy) DCDRoutingKeyValueParamBlock PARAM;

// TODO:
//@property (nonatomic, readonly, copy) DCDRoutingOrderedParamBlock PARAMS;

@property (nonatomic, readonly) NSString *ROUTING;

// TODO:
//@property (nonatomic, readonly) DCDRoutingAction *ACTION;

@property (nonatomic, readonly, strong) NSString *pattern;

- (instancetype)initWithPattern:(NSString *)pattern;

@end
