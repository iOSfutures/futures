//
//  EIReachability.h
//  Fotor
//
//  Created by Seven on 8/20/15.
//  Copyright (c) 2015 Everimaging. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

typedef NS_ENUM(int, EICurrentNetworkStatus) {
    kEICurrentNetworkStatusUnknown = 0,
    kEICurrentNetworkStatus2G_3G_4G,
    kEICurrentNetworkStatusWiFi,
};

@interface LCPReachability : NSObject

@property (nonatomic, assign) EICurrentNetworkStatus networkStatus;


+(instancetype)shareReachability;
-(void)start;
-(void)stop;
-(void)addReachabilityObserver:(id)observer selector:(SEL)selector;
-(BOOL)isReachable;
- (NSInteger)getCurrentNetworkStatus;
@end
