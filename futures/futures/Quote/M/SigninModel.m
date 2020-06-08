//
//  SigninModel.m
//  SCRBProject1
//
//  Created by zdh on 2019/7/3.
//  Copyright © 2019 zdh. All rights reserved.
//

#import "SigninModel.h"

@implementation SigninModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             NSStringFromSelector(@selector(dataList)):@"data",
             };
}

+(NSValueTransformer *)dataListJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSError *newError;
        NSArray *arr = [MTLJSONAdapter modelsOfClass:[signinLittleModel class] fromJSONArray:value error:&newError];
        if (newError) {
            DLog(@"error == %@",newError);
        }
        return arr;
    }];
}

@end

//#import "CalendarDateDataModel.m"

@implementation signinLittleModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             NSStringFromSelector(@selector(modelId)):@"id",
             NSStringFromSelector(@selector(continueTimes)):@"continueTimes",

             NSStringFromSelector(@selector(userId)):@"userId",

             NSStringFromSelector(@selector(timeStamp)):@"time",

             };
}

//-(DateModel *)date{
//    if (_timeStamp) {
//        _date = [DateModel new];
//        [_date otherTimeString:[TimerTool getTimeStringWithTimeStampString:_timeStamp.stringValue]];
//    }
//    return _date;
//}

@end
