//
//  DCDBaseRouter.h
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCDBaseRouter : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary *routes;
@property (nonatomic, strong, readonly) NSMutableDictionary *schemas;

+ (instancetype)shared;

- (void)map:(NSString *)route toObject:(id)object withIdentifier:(NSString *)identifier;

- (NSDictionary *)subRoutesForRoutingString:(NSString *)route
                              extractParams:(NSDictionary **)extractParams;

// 参数解析，包括 route param 和 query param eg. /goods/:goodsId/?a=1&b=2
- (NSDictionary *)paramsInRoute:(NSString *)route;

// schema 映射，用于过滤处理特殊的 schema
- (void)mapSchema:(NSString *)schema toObject:(id)object withIdentifier:(NSString *)identifier;
- (NSString *)extractSchema:(NSString *)route;
- (id)objectForSchema:(NSString *)schema identifier:(NSString *)identifier;

@end
