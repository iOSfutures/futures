//
//  LCPNetWorkDELETE.m
//  Lycam_ZSB_App
//
//  Created by fengshicao on 2018/8/3.
//  Copyright © 2018年 LycamPlus. All rights reserved.
//

#import "LCPNetWorkDELETE.h"

@implementation LCPNetWorkDELETE


+ (void)DELETEWithParams:(NSDictionary *)params pathurl:(NSString *)pathUrl success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock manager:(AFHTTPSessionManager *)manager{
    if ([params.allKeys count] != 0) {
   manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    }
    [manager DELETE:pathUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary* json;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            json=responseObject;
        }else{
            json=[NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:nil];
        }
        [LCPNetWorkERROR DealJsonDict:json callBackBlock:^(id result, BOOL error) {
            if (!error) {
                successBlock(YES,json);
            }else{
                failureBlock(NO,result);
            }
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LCPNetWorkERROR dealErrorInfo:error Task:task CompeleteBlcok:^(NSError *newError) {
            failureBlock(YES,newError);
        }];
    }];
}



@end
