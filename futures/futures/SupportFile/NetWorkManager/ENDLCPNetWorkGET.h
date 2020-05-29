//
//  ENDLCPNetWorkGET.h
//  Lycam_ZSB_App
//
//  Created by fengshicao on 2018/8/3.
//  Copyright © 2018年 LycamPlus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroUrlHeader.h"

@interface ENDLCPNetWorkGET : NSObject
/**
 get请求

 @param parameters 参数
 @param pathUrl url 地址
 @param successBlock 成功
 @param failureBlock 失败
 @param manager 管理者
 */
+ (void)GETWithParameter:(NSDictionary *)parameters pathurl:(NSString *)pathUrl success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock manager:(AFHTTPSessionManager *)manager;
/**
 图片上传接口

 @param successBlock 成功
 @param failureBlock 失败
 */
+ (void)getUploadPolicyWithSuccessBlock:(HTTPSuccessBlock)successBlock
                           withFailureBlock:(HTTPFailureBlock)failureBlock;


+ (void)GETDownLoadParameter:(NSDictionary *)parameters pathurl:(NSString *)pathUrl success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock manager:(AFHTTPSessionManager *)manager;


@end
