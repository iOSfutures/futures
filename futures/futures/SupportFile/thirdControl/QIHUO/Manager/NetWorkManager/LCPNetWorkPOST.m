//
//  LCPNetWorkPOST.m
//  
//
//  Created by zdh on 2019/06/25.//  Copyright © 2018年 LycamPlus. All rights reserved.
//

#import "LCPNetWorkPOST.h"

@implementation LCPNetWorkPOST
+ (void)POSTFormDataWithParams:(NSDictionary *)params pathurl:(NSString *)pathUrl success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock manager:(AFHTTPSessionManager *)manager
{
    [manager POST:pathUrl  parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSData *data;
            if ([obj isKindOfClass:[NSNumber class]]) {
             data =  [[(NSNumber *)obj stringValue] dataUsingEncoding:NSUTF8StringEncoding];
            }else{
                data = [obj dataUsingEncoding:NSUTF8StringEncoding];
            }
            [formData appendPartWithFormData:data name:key];
//            [formData appendPartWithFileData:[obj dataUsingEncoding:NSUTF8StringEncoding] name:key fileName:@"" mimeType:@""];
        }];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary* json;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            json=responseObject;
        }else{
            json=[NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:nil];
        }
        if ([json valueForKey:@"error"]) {
            NSError *error = [[NSError alloc] initWithDomain:@"server error" code:500 userInfo:nil];
            failureBlock(NO,error);
            return ;
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

+ (void)POSTDataWithParams:(NSDictionary *)params pathurl:(NSString *)pathUrl success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock manager:(AFHTTPSessionManager *)manager{
    [manager POST:pathUrl parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary* json;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            json=responseObject;
        }else{
            json=[NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:nil];
        }
        if ([json valueForKey:@"error"]) {
            NSError *error = [[NSError alloc] initWithDomain:@"server error" code:500 userInfo:nil];
            failureBlock(NO,error);
            return ;
        }
        [LCPNetWorkERROR DealJsonDict:json callBackBlock:^(id result, BOOL error) {
            if (!error) {
                successBlock(YES,json);
            }else{
                failureBlock(NO,result);
            }
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [LCPNetWorkERROR dealErrorInfo:error Task:task CompeleteBlcok:^(NSError *newError) {
            failureBlock(YES,newError);
        }];
    }];
}

+ (void)POSTJSONWithParams:(NSDictionary *)params pathurl:(NSString *)pathUrl success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock manager:(AFHTTPSessionManager *)manager{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:pathUrl parameters:nil error:nil];
    request.timeoutInterval = 10;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSDictionary* json;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            json=responseObject;
        }else{
            json=[NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:nil];
        }
        if (!error) {
            NSLog(@"Reply JSON: %@", json);
            [LCPNetWorkERROR DealJsonDict:json callBackBlock:^(id result, BOOL error) {
                if (!error) {
                    successBlock(YES,json);
                }else{
                    failureBlock(NO,result);
                }
            }];
            
        } else {
            failureBlock(NO,error);
        }
    }] resume];
}
@end
