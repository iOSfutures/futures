//
//  LCPNetWorkPUT.h
//  Lycam_ZSB_App
//
//  Created by fengshicao on 2018/8/3.
//  Copyright © 2018年 LycamPlus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroUrlHeader.h"

@interface ENDNetWorkPUT : NSObject
/**
 put请求

 @param params 参数
 @param pathUrl url
 @param successBlock 成功回调
 @param failureBlock 失败回到
 @param manager 管理者对象
 */
+ (void)PUTWithParams:(NSDictionary *)params pathurl:(NSString *)pathUrl success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock manager:(AFHTTPSessionManager *)manager;
/**
 patch

 @param params 参数
 @param pathUrl 地址
 @param successBlock 成功回调
 @param failureBlock 失败回调
 @param manager 管理者
 */
+ (void)PATCHWithParams:(NSDictionary *)params pathurl:(NSString *)pathUrl success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock manager:(AFHTTPSessionManager *)manager;
@end
