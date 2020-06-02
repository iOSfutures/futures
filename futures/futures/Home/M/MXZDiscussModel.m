//
//  MXZDiscussModel.m
//  futures
//
//  Created by Francis on 2020/6/2.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZDiscussModel.h"
#import "UserModel.h"

@implementation MXZDiscussModel
+ (NSDictionary*) JSONKeyPathsByPropertyKey{
    return @{
             NSStringFromSelector(@selector(content)):@"content",
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
