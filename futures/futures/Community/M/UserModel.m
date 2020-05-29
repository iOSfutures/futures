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
             NSStringFromSelector(@selector(head)):@"head",
             NSStringFromSelector(@selector(nickName)):@"nickName",
             };
}

@end
