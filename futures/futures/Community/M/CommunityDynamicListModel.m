//
//  CommunityTopicListModel.m
//  futures
//
//  Created by Ssiswent on 2020/6/8.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityDynamicListModel.h"

#import "CommunityDynamicModel.h"

@implementation CommunityDynamicListModel

+ (NSDictionary*) JSONKeyPathsByPropertyKey{
    return @{
             NSStringFromSelector(@selector(dynamicsArray)):@"list",
             NSStringFromSelector(@selector(hasMore)):@"hasMore",
             };
}

+(NSValueTransformer *)dynamicsArrayJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSError *newError;
        NSArray *dynamicsArray = [MTLJSONAdapter modelsOfClass:[CommunityDynamicModel class] fromJSONArray:value error:&newError];
        return dynamicsArray;
    }];
}

@end
