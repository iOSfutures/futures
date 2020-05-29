//
//  ENDNetWorkPOST.h
//  Lycam_ZSB_App
//
//  Created by fengshicao on 2018/8/3.
//  Copyright © 2018年 LycamPlus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroUrlHeader.h"

@interface ENDNetWorkPOST : NSObject
/**
 表单上传

 @param params 参数
 @param pathUrl 地址
 @param successBlock 成功
 @param failureBlock 失败
 @param manager 管理者
 */
+ (void)POSTFormDataWithParams:(NSDictionary *)params pathurl:(NSString *)pathUrl success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock manager:(AFHTTPSessionManager *)manager;

/**
 post请求

 @param params 参数
 @param pathUrl 地址
 @param successBlock 成功
 @param failureBlock 失败
 @param manager 管理者
 */
+ (void)POSTDataWithParams:(NSDictionary *)params pathurl:(NSString *)pathUrl success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock manager:(AFHTTPSessionManager *)manager;

/**
 post JSON

 @param params 参数
 @param pathUrl 地址
 @param successBlock 成功
 @param failureBlock 失败
 @param manager 管理者
 */
+ (void)POSTJSONWithParams:(NSDictionary *)params pathurl:(NSString *)pathUrl success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock manager:(AFHTTPSessionManager *)manager;

@end
