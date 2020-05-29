//
//  ENDLCPNetWorkERROR.h
//  Lycam_ZSB_App
//
//  Created by zdh on 2019/06/25.
//  Copyright © 2018年 LycamPlus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroUrlHeader.h"

@interface ENDLCPNetWorkERROR : NSObject
/**
 http错误处理

 @param task NSURLSessionDataTask
 @param _userinfo
 @return
 */
+(NSError *) httpError:(NSURLSessionDataTask*)task withUserinfo:(NSDictionary*) _userinfo;
/**
 json error Code Deal

 @param json json
 @param CallBackBlock fanhui
 */
+(void)DealJsonDict:(id)json callBackBlock:(void(^)(id result,BOOL error))CallBackBlock;
/**
 请求返回的error处理

 @param error error信息
 @param task task
 @param completeBlcok 完成回调
 */
+(void)dealErrorInfo:(NSError *)error Task:(NSURLSessionDataTask *)task CompeleteBlcok:(void (^)(NSError *))completeBlcok;
/**
 请求成功服务器返回的失败信息

 @param json json信息
 @param errorCallBack 完成处理回调
 */
+(void)DealFailureTypeJson:(id)json CallBackBlcok:(void(^)(NSError *))errorCallBack;
@end
