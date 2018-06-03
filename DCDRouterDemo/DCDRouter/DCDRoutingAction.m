//
//  DCDRoutingAction.m
//  RouterDemo
//
//  Created by boohee on 2018/5/10.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "DCDRoutingAction.h"

@interface DCDRoutingAction ()

@end

@implementation DCDRoutingAction

+ (instancetype)actionFor:(NSString *)route
{
    return [self actionFor:route sender:nil];
}

+ (instancetype)actionFor:(NSString *)route sender:(id)sender
{
    DCDRoutingAction *action = [DCDRoutingAction new];
    
    action.routingString = route;
    action.sender        = sender;
    action.state         = DCDRoutingStateInited;
    return action;
}

- (void)resetState;
{
    _state                = DCDRoutingStateInited;
    self.stateChangeBlock = NULL;
}

- (void)setState:(DCDRoutingState)state
{
    if ( _state != state ) {
        _state = state;
        if ( self.stateChangeBlock ) {
            self.stateChangeBlock(self);
        }
    }
}

- (void)setInput:(NSDictionary *)input
{
    if ( _input != input ) {
        _input = input;
        [self parseInput];
    }
}

- (void)parseInput
{
    if ( [_input[@"title"] length] ) {
        _title = _input[@"title"];
    }
    
    NSDictionary *wayMap = \
    @{
      @"push": @(DCDRoutingPageWayPush),
      @"present": @(DCDRoutingPageWayPresent)
      };
    
    NSString *way = _input[@"way"];
    if ( way ) {
        _pageWay = [wayMap[way] integerValue];
    }
    
    NSDictionary *fromMap = \
    @{
      @"root": @(DCDRoutingPageFromRoot),
      @"context": @(DCDRoutingPageFromContext)
      };
    NSString *from = _input[@"from"];
    if ( from ) {
        _pageFrom = [fromMap[from] integerValue];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"<%@"
            @" route: %@"
            @", sender: %@"
            @", state: %ld"
            @", input: %@"
            @", output: %@"
            @">",
            [super description], self.routingString, self.sender, (long)self.state, self.input, self.output];
}

@end
