//
//  QuoteCalendarModel.m
//  futures
//
//  Created by apple on 2020/6/6.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "QuoteCalendarModel.h"

@implementation QuoteCalendarModel


+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        NSStringFromSelector(@selector(affect)):@"affect",
        NSStringFromSelector(@selector(name)):@"name",
        NSStringFromSelector(@selector(previous)):@"previous",
        NSStringFromSelector(@selector(consensus)):@"consensus",
        NSStringFromSelector(@selector(star)):@"star",
        NSStringFromSelector(@selector(time)):@"time",
//        NSStringFromSelector(@selector(id)):@"id",
    };
}

@end
