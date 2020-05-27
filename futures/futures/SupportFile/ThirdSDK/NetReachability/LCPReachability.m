//
//  EIReachability.m
//  Fotor
//
//  Created by Seven on 8/20/15.
//  Copyright (c) 2015 Everimaging. All rights reserved.
//

#import "LCPReachability.h"
#import "AFNetworkReachabilityManager.h"

@interface LCPReachability()

@property (nonatomic,strong) Reachability * reachability;
@property (nonatomic ,strong) NSMutableArray * observers;
@property (nonatomic ,strong) NSMutableArray * selectors;
@end

@implementation LCPReachability

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+(instancetype)shareReachability
{
    static LCPReachability * _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
        [self start];
    }
    return self;
}

-(NSMutableArray *)observers
{
    if (!_observers) {
        _observers = [NSMutableArray array];
    }
    return _observers;
}

-(NSMutableArray *)selectors
{
    if (!_selectors) {
        _selectors = [NSMutableArray array];
    }
    return _selectors;
}

-(Reachability *)reachability
{
    if (!_reachability) {
        _reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    }
    return _reachability;
}

-(void)start
{
    [self.reachability startNotifier];
}

-(void)stop
{
    [self.reachability stopNotifier];
}

-(void)addReachabilityObserver:(id)observer selector:(SEL)selector
{
    [self.observers addObject:observer];;
    [self.selectors addObject:NSStringFromSelector(selector)];
}

-(void)reachabilityChanged:(NSNotification *)noti
{
    
//    重新解析域名
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    });
    
    Reachability* curReach = [noti object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    if (!curReach.isReachable) {
        DLog(@"当前网络不可用");
        self.networkStatus = kEICurrentNetworkStatusUnknown;
        int index = 0;
        for (id observer in self.observers) {
            SEL curSelector = NSSelectorFromString(self.selectors[index]);
            if ([observer respondsToSelector:curSelector]) {
                [observer performSelector:curSelector withObject:@0 afterDelay:0];
            }
            index++;
        }
        index = 0;
        return;
    }
    if (curReach.isReachableViaWWAN){
        self.networkStatus = kEICurrentNetworkStatus2G_3G_4G;
        int index = 0;
        for (id observer in self.observers) {
            SEL curSelector = NSSelectorFromString(self.selectors[index]);
            if ([observer respondsToSelector:curSelector]) {
                [observer performSelector:curSelector withObject:@1 afterDelay:0];
            }
            index++;
        }
        index = 0;
        DLog(@"当前网络为2G 或者 3G");
    }else if(curReach.isReachableViaWiFi){
        self.networkStatus = kEICurrentNetworkStatusWiFi;
        int index = 0;
        for (id observer in self.observers) {
            SEL curSelector = NSSelectorFromString(self.selectors[index]);
            if ([observer respondsToSelector:curSelector]) {
                [observer performSelector:curSelector withObject:@2 afterDelay:0];
            }
            index++;
        }
        index = 0;
        DLog(@"当前网络为WIFI");
    }
    
}

-(BOOL)isReachable
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}
- (NSInteger)getCurrentNetworkStatus {
    return self.networkStatus;
}

@end
