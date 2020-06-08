//
//  QuoteNewModel.m
//  futures
//
//  Created by apple on 2020/6/8.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "QuoteNewModel.h"

@implementation QuoteNewModel

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        NSStringFromSelector(@selector(content)):@"content",
        NSStringFromSelector(@selector(time)):@"time",
        NSStringFromSelector(@selector(daytime)):@"daytime",
    };
}

@end
