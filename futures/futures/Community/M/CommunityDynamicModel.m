//
//  CommunityDynamicModel.m
//  futures
//
//  Created by Ssiswent on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityDynamicModel.h"
#import "UserModel.h"

@implementation CommunityDynamicModel

+ (NSDictionary*) JSONKeyPathsByPropertyKey{
    return @{
             NSStringFromSelector(@selector(content)):@"content",
             NSStringFromSelector(@selector(picture1)):@"picture",
             NSStringFromSelector(@selector(picture2)):@"picture2",
             NSStringFromSelector(@selector(user)):@"user",
             };
}

+(NSValueTransformer *)userJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSError *newError;
        UserModel *model = [MTLJSONAdapter modelOfClass:[UserModel class] fromJSONDictionary:value error:&newError];
        return model;
    }];
}


@end
