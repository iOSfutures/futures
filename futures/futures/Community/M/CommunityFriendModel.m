//
//  CommunityFriendModel.m
//  futures
//
//  Created by Ssiswent on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityFriendModel.h"

@implementation CommunityFriendModel

+ (NSDictionary*) JSONKeyPathsByPropertyKey{
    return @{
             NSStringFromSelector(@selector(head)):@"head",
             NSStringFromSelector(@selector(nickName)):@"nickName",
             NSStringFromSelector(@selector(signature)):@"signature",
             };
}

@end
