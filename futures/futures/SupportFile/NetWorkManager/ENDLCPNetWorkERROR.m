//
//  ENDLCPNetWorkERROR.m
//  Lycam_ZSB_App
//
//  Created by zdh on 2019/06/25.//  Copyright © 2018年 LycamPlus. All rights reserved.
//

#import "ENDLCPNetWorkERROR.h"
#import "NSString+DealError.h"


@implementation ENDLCPNetWorkERROR

//错误处理
+(NSError *) httpError:(NSURLSessionDataTask*)task withUserinfo:(NSDictionary*) _userinfo{
    NSError * newError;
    if(task){
        NSHTTPURLResponse * responseError= (NSHTTPURLResponse *)task.response;
        //        [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        
        //        NSData *data = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        NSError *errorerror = nil;
        id jsonObject = nil;
        //        if (data) {
        //            jsonObject = [NSJSONSerialization JSONObjectWithData:data
        //                                                         options:NSJSONReadingAllowFragments
        //                                                           error:&errorerror];
        //        }
        
        if (jsonObject && [jsonObject isKindOfClass:[NSDictionary class]]) {
            jsonObject = (NSDictionary *)jsonObject;
            DLog(@"error jsonObject == %@",jsonObject);
            DLog(@"error[msg]= == %@",jsonObject[@"msg"]);
        }
        
        if(responseError){
            NSInteger code = responseError.statusCode;
            NSDictionary * userinfo ;
            if(_userinfo)
                userinfo = _userinfo;
            else{
                if ([[jsonObject allKeys] containsObject:@"error_output"]) {
                    userinfo = @{NSLocalizedDescriptionKey:[jsonObject objectForKey:@"error_output"]?:@"请求失败，请稍后再试!",NSLocalizedFailureReasonErrorKey:[jsonObject objectForKey:@"error"]};
                }else{
                    userinfo = @{NSLocalizedDescriptionKey:@"请求失败，请稍后再试!",NSLocalizedFailureReasonErrorKey:[NSString stringWithFormat:@"%ld",code]};
                }
            }
            newError = [NSError errorWithDomain:@"error" code:code userInfo:userinfo];
        }
    }
    return newError;
}
+(void)DealJsonDict:(id)json callBackBlock:(void(^)(id result,BOOL error))CallBackBlock{
    if ([json isKindOfClass:[NSDictionary class]]) {
        if ([[json allKeys] count] != 0) {
            if ([[json allKeys] containsObject:@"success"]&&[json[@"success"] isEqual:@1]) {
                CallBackBlock(json,NO);
            }else if([[json allKeys] count] == 1){
                CallBackBlock(json, NO);
            }else{
                [self DealFailureTypeJson:json CallBackBlcok:^(NSError *Error) {
                    if (Error) {
                        CallBackBlock(Error,YES);
                    }else{
                        CallBackBlock([NSError errorWithDomain:@"error" code:500 userInfo:@{NSLocalizedDescriptionKey:@"未知错误"}],YES);
                    }
                }];
            }
        }else{
            CallBackBlock([NSError errorWithDomain:@"error" code:500 userInfo:@{NSLocalizedDescriptionKey:@"数据解析错误"}],YES);
        }
    }else{
        CallBackBlock([NSError errorWithDomain:@"error" code:500 userInfo:@{NSLocalizedDescriptionKey:@"数据解析错误"}],YES);
    }
}
//#import "NSString+DealError.h"
+(void)dealErrorInfo:(NSError *)error Task:(NSURLSessionDataTask *)task CompeleteBlcok:(void (^)(NSError *))completeBlcok{
    NSError * newError = [self httpError:task withUserinfo:nil];
    DLog(@"--%@",[newError localizedDescription]);
    DLog(@"---%@",[[newError userInfo] objectForKey:@"NSLocalizedDescription"]);
    DLog(@"____****____%@",[[newError userInfo] objectForKey:@"NSErrorFailingURLKey"]);
    if(newError.code == 401){
//    [[NSNotificationCenter defaultCenter] postNotificationName:kLCPResponseInvalidCredentials object:nil];
    }else if (newError.code == -1009 && [newError.description rangeOfString:@"似乎已断开与互联网的连接"].location != NSNotFound) {
        newError = [NSError errorWithDomain:@"NSURLErrorDomain" code:-1009 userInfo:@{NSLocalizedDescriptionKey:@"网络异常,请检查网络设置!"}];
//        [Toast makeText:[LCPUIFactory getCurrentVC].view Message:@"网络异常,请检查网络设置!" afterHideTime:2];
    }
    completeBlcok(newError);
    
}
//api/payment/apple/productlist
/**
 错误码处理
 
 @param json json description
 @param errorCallBack 错误返回
 */
+(void)DealFailureTypeJson:(id)json CallBackBlcok:(void(^)(NSError *))errorCallBack{
    if ([[json allKeys] containsObject:@"success"]) {
        NSInteger code = [json[@"success"] integerValue];
        NSError *error;
        switch (code) {
                case 0:
                 error = [NSError errorWithDomain:@"error" code:0 userInfo:@{NSLocalizedDescriptionKey:json[@"msg"]}];
                errorCallBack(error);
                break;
            case 401:
//                [[NSNotificationCenter defaultCenter] postNotificationName:kLCPResponseInvalidCredentials object:nil];
                break;
            case 602:
                if ([json[@"msg"] isKindOfClass:[NSString class]]) {
                    if ([(NSString *)json[@"msg"] includeChinese]) {
                        error = [NSError errorWithDomain:@"error" code:602 userInfo:@{NSLocalizedDescriptionKey:json[@"msg"]}];
                    }else{
                        error = [NSError errorWithDomain:@"error" code:602 userInfo:@{NSLocalizedDescriptionKey:@"数据解析错误"}];
                    }
                }else{
                    error = [NSError errorWithDomain:@"error" code:602 userInfo:@{NSLocalizedDescriptionKey:@"数据解析错误"}];
                }
                errorCallBack(error);
                break;
            case 705:
                error = [NSError errorWithDomain:@"error" code:705 userInfo:@{NSLocalizedDescriptionKey:json[@"msg"]}];
                errorCallBack(error);
                break;
            default:
                if ([(NSString *)json[@"msg"] isChinese]) {
                    error = [NSError errorWithDomain:@"error" code:[json[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey:json[@"msg"]}];
                }else{
                    error = [NSError errorWithDomain:@"error" code:[json[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey:@"请求失败，请稍后再试"}];
                }
                errorCallBack(error);
                break;
        }
    }
}

@end
