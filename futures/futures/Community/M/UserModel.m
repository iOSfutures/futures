//
//  UserModel.m
//  futures
//
//  Created by Ssiswent on 2020/5/28.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (NSDictionary*) JSONKeyPathsByPropertyKey{
    return @{
        NSStringFromSelector(@selector(phone)):@"phone",
        NSStringFromSelector(@selector(pwd)):@"password",
        
        NSStringFromSelector(@selector(head)):@"head",
        NSStringFromSelector(@selector(nickName)):@"nickName",
        NSStringFromSelector(@selector(followCount)):@"followCount",
        NSStringFromSelector(@selector(fansCount)):@"fansCount",
        NSStringFromSelector(@selector(signature)):@"signature",
        NSStringFromSelector(@selector(userId)):@"id",
    };
}

@end
