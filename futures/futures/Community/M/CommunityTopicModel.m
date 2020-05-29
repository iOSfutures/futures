//
//  CommunityTopicModel.m
//  futures
//
//  Created by Ssiswent on 2020/5/19.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityTopicModel.h"

@implementation CommunityTopicModel

+ (NSDictionary*) JSONKeyPathsByPropertyKey{
    return @{
             NSStringFromSelector(@selector(content)):@"content",
             };
}

@end
