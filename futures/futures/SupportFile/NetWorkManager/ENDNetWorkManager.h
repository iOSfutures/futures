//
//  ENDNetWorkManager.h
//  Lycam_ZSB_App
//
//  Created by zdh on 2019/06/25.
//  Copyright © 2018年 LycamPlus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
@interface ENDNetWorkManager : AFHTTPSessionManager


/**
 get 请求
 
 @param pathUrl 地址
 @param parameters 参数
 @param header 请求头
 @param successBlock 成功
 @param failureBlock 失败
 */
+ (void)getWithPathUrl:(NSString *)pathUrl parameters:(NSDictionary *)parameters queryParams:(NSDictionary *)queryParam Header:(NSDictionary *)header success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock;
/**
 post 请求
 
 @param pathUrl  地址
 @param parameters 参数
 @param header 请求头
 @param successBlock 成功
 @param failureBlock 失败
 */
+ (void)postWithPathUrl:(NSString *)pathUrl parameters:(NSDictionary *)parameters queryParams:(NSDictionary *)queryParam Header:(NSDictionary *)header success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock;
/**
 put 请求
 
 @param pathUrl 请求地址
 @param parameters 参数
 @param header 请求头参数
 @param successBlock 成功
 @param failureBlock 失败
 */

+ (void)putWithPathUrl:(NSString *)pathUrl parameters:(NSDictionary *)parameters queryParams:(NSDictionary *)queryParam Header:(NSDictionary *)header success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock;
/**
 delete 请求
 
 @param pathUrl 请求地址
 @param parameters 参数
 @param header 请求头参数
 @param successBlock 成功
 @param failureBlock 失败
 */


+ (void)deleteWithPathUrl:(NSString *)pathUrl parameters:(NSDictionary *)parameters queryParams:(NSDictionary *)queryParam Header:(NSDictionary *)header success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock;

/**
 post表单请求
 
 @param pathUrl 地址
 @param parameters 参数
 @param queryParam 拼接
 @param header 头
 @param successBlock <#successBlock description#>
 @param failureBlock <#failureBlock description#>
 */
+ (void)postFormWithPathUrl:(NSString *)pathUrl parameters:(NSDictionary *)parameters queryParams:(NSDictionary *)queryParam Header:(NSDictionary *)header success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock;

/**
 上传图片请求
 
 @param url 存储地址
 @param images 图片
 @param parameter 参数
 @param parameters 参数字典
 @param ratio <#ratio description#>
 @param succeedBlock <#succeedBlock description#>
 @param failedBlock <#failedBlock description#>
 @param uploadProgressBlock <#uploadProgressBlock description#>
 */
+ (void)startMultiPartUploadTaskWithOSSURL:(NSString *)url
                               imagesArray:(NSArray *)images
                         parameterOfimages:(NSString *)parameter
                            parametersDict:(NSDictionary *)parameters
                          compressionRatio:(float)ratio
                              succeedBlock:(void(^)(BOOL success, id responseObject))succeedBlock
                               failedBlock:(void(^)(id operation, NSError *error))failedBlock
                       uploadProgressBlock:(void(^)(float uploadPercent,long long totalBytesWritten,long long totalBytesExpectedToWrite))uploadProgressBlock;

#pragma mark - 文件下载

+ (void)getDownLoadWithPathUrl:(NSString *)pathUrl parameters:(NSDictionary *)parameters success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock;

/**
 初始化

 @return 返回
 */
+ (AFHTTPSessionManager *)shareManager;
/**
 请求头设置

 @param manager 管理
 @param headers 参数
 @param pathUrl url
 */
+ (void)setHeaderWithManager:(AFHTTPSessionManager *)manager headers:(NSDictionary *)headers PathUrl:(NSString *)pathUrl;
@end
