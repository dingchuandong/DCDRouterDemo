//
//  DCDBaseRouter.m
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "DCDBaseRouter.h"

@implementation DCDBaseRouter
{
    NSMutableDictionary *_routes;
    NSMutableDictionary *_schemas;
}

+ (instancetype)shared
{
    static DCDBaseRouter *router = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if ( !router ) {
            router = [[self alloc] init];
        }
    });
    return router;
}

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        _routes = [[NSMutableDictionary alloc] init];
        _schemas = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - Public

- (void)map:(NSString *)route toObject:(id)object withIdentifier:(NSString *)identifier
{
    NSMutableDictionary *subRoutes = [self subRoutesToRoute:route createIfNotExists:YES];
    
    if ([object conformsToProtocol:@protocol(NSCopying)]) {
        subRoutes[identifier] = [object copy];
    }
    else {
        subRoutes[identifier] = object;
    }
}

- (NSString *)extractSchema:(NSString *)route;
{
    NSRange range = [route rangeOfString:@"://"];
    if ( range.location != NSNotFound ) {
        return [route substringToIndex:range.location];
    }
    return nil;
}

- (void)mapSchema:(NSString *)schema toObject:(id)object withIdentifier:(NSString *)identifier
{
    schema = [self extractSchema:schema] ?: schema;
    NSMutableDictionary *subRoutes = [self subRoutesToSchema:schema createIfNotExists:YES];
    
    if ([object conformsToProtocol:@protocol(NSCopying)]) {
        subRoutes[identifier] = [object copy];
    }
    else {
        subRoutes[identifier] = object;
    }
}

- (id)objectForSchema:(NSString *)schema identifier:(NSString *)identifier
{
    NSMutableDictionary *subRoutes = [self subRoutesToSchema:schema createIfNotExists:NO];
    return subRoutes[identifier];
}

#pragma mark -

- (NSDictionary *)subRoutesForRoutingString:(NSString *)route
extractParams:(NSDictionary **)extractParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    route = [self stringFromFilterAppUrlScheme:route];
    params[@"route"] = route;
    
    NSMutableDictionary *subRoutes = self.routes;
    NSArray *pathComponents        = [self pathComponentsFromRoute:route];
    for ( NSString *pathComponent in pathComponents ) {
        BOOL found             = NO;
        NSArray *subRoutesKeys = subRoutes.allKeys;
        for ( NSString *key in subRoutesKeys ) {
            if ( [subRoutesKeys containsObject:pathComponent] ) {
                found     = YES;
                subRoutes = subRoutes[pathComponent];
                break;
            }
            else if ( [key hasPrefix:@":"] ) {
                found                              = YES;
                subRoutes                          = subRoutes[key];
                params[[key substringFromIndex:1]] = pathComponent;
                break;
            }
        }
        if ( !found ) {
            //            if ([self.routes count] > 0) {
            //                UIAlertView *alert = [[UIAlertView alloc]
            //                                      initWithTitle:@"提示"
            //                                      message:@"请升级到最新版本"
            //                                      delegate:nil
            //                                      cancelButtonTitle:@"知道了"
            //                                      otherButtonTitles:nil,nil];
            //                [alert show];
            //            }
            return nil;
        }
    }
    
    // Extract Params From Query.
    NSRange firstRange = [route rangeOfString:@"?"];
    if ( (firstRange.location != NSNotFound) && (route.length > firstRange.location + firstRange.length) ) {
        NSString *paramsString  = [route substringFromIndex:firstRange.location + firstRange.length];
        NSArray *paramStringArr = [paramsString componentsSeparatedByString:@"&"];
        for ( NSString *paramString in paramStringArr ) {
            NSArray *paramArr = [paramString componentsSeparatedByString:@"="];
            if ( paramArr.count > 1 ) {
                NSString *key   = [paramArr objectAtIndex:0];
                NSString *value = [paramArr objectAtIndex:1];
                params[key] = value;
            }
        }
    }
    
    *extractParams = [NSDictionary dictionaryWithDictionary:params];
    return subRoutes;
}

- (NSDictionary *)paramsInRoute:(NSString *)route
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"route"] = [self stringFromFilterAppUrlScheme:route];
    
    NSMutableDictionary *subRoutes = self.routes;
    NSArray *pathComponents        = [self pathComponentsFromRoute:[self stringFromFilterAppUrlScheme:route]];
    for ( NSString *pathComponent in pathComponents ) {
        BOOL found             = NO;
        NSArray *subRoutesKeys = subRoutes.allKeys;
        for ( NSString *key in subRoutesKeys ) {
            if ( [subRoutesKeys containsObject:pathComponent] ) {
                found     = YES;
                subRoutes = subRoutes[pathComponent];
                break;
            }
            else if ( [key hasPrefix:@":"] ) {
                found                              = YES;
                subRoutes                          = subRoutes[key];
                params[[key substringFromIndex:1]] = pathComponent;
                break;
            }
        }
        if ( !found ) {
            return nil;
        }
    }
    
    // Extract Params From Query.
    NSRange firstRange = [route rangeOfString:@"?"];
    if ( (firstRange.location != NSNotFound) && (route.length > firstRange.location + firstRange.length) ) {
        NSString *paramsString  = [route substringFromIndex:firstRange.location + firstRange.length];
        NSArray *paramStringArr = [paramsString componentsSeparatedByString:@"&"];
        for ( NSString *paramString in paramStringArr ) {
            NSArray *paramArr = [paramString componentsSeparatedByString:@"="];
            if ( paramArr.count > 1 ) {
                NSString *key   = [paramArr objectAtIndex:0];
                NSString *value = [paramArr objectAtIndex:1];
                params[key] = value;
            }
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:params];
}

- (NSMutableDictionary *)routes
{
    if ( !_routes ) {
        _routes = [[NSMutableDictionary alloc] init];
    }
    
    return _routes;
}

- (NSMutableDictionary *)schemas
{
    if ( !_schemas ) {
        _schemas = [[NSMutableDictionary alloc] init];
    }
    return _schemas;
}

- (NSArray *)pathComponentsFromRoute:(NSString *)route
{
    NSMutableArray *pathComponents = [NSMutableArray array];
    
    for ( NSString *pathComponent in route.pathComponents ) {
        if ( [pathComponent isEqualToString:@"/"] ) {
            continue;
        }
        if ( [[pathComponent substringToIndex:1] isEqualToString:@"?"] ) {
            break;
        }
        [pathComponents addObject:pathComponent];
    }
    
    return [pathComponents copy];
}

- (NSString *)stringFromFilterAppUrlScheme:(NSString *)string
{
    // filter out the app URL compontents.
    for ( NSString *appUrlScheme in [self appUrlSchemes] ) {
        if ( [string hasPrefix:[NSString stringWithFormat:@"%@:", appUrlScheme]] ) {
            return [string substringFromIndex:appUrlScheme.length + 2];
        }
    }
    
    return string;
}

- (NSArray *)appUrlSchemes
{
    static NSMutableArray *s_appUrlSchemes = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_appUrlSchemes = [NSMutableArray array];
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        for ( NSDictionary *dic in infoDictionary[@"CFBundleURLTypes"] ) {
            NSString *appUrlScheme = dic[@"CFBundleURLSchemes"][0];
            [s_appUrlSchemes addObject:appUrlScheme];
        }
    });
    
    return [s_appUrlSchemes copy];
}

- (NSMutableDictionary *)subRoutesToSchema:(NSString *)schema createIfNotExists:(BOOL)flag
{
    NSMutableDictionary *subRoutes = self.schemas[schema];
    if ( flag && !subRoutes ) {
        subRoutes = [[NSMutableDictionary alloc] init];
        self.schemas[schema] = subRoutes;
    }
    return subRoutes;
}

- (NSMutableDictionary *)subRoutesToRoute:(NSString *)route createIfNotExists:(BOOL)flag
{
    NSArray *pathComponents = [self pathComponentsFromRoute:route];
    
    NSInteger index                = 0;
    NSMutableDictionary *subRoutes = self.routes;
    
    while ( index < pathComponents.count ) {
        NSString *pathComponent = pathComponents[index];
        if ( flag ) {
            if ( ![subRoutes objectForKey:pathComponent] ) {
                subRoutes[pathComponent] = [[NSMutableDictionary alloc] init];
            }
            else {
                break;
            }
        }
        
        subRoutes = subRoutes[pathComponent];
        index++;
    }
    
    return subRoutes;
}

@end

