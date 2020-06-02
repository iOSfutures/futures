//
//  ENDNetWorkManager.m
//  Lycam_ZSB_App
//
//  Created by zdh on 2019/06/25.
//  Copyright © 2018年 LycamPlus. All rights reserved.
//

#import "ENDNetWorkManager.h"
#import "NSString+DealError.h"
//#import "YYCache.h"
#import "LCPReachability.h"
#import "ENDLCPNetWorkERROR.h"
#import "ENDLCPNetWorkGET.h"
#import "ENDNetWorkPUT.h"
#import "ENDNetWorkPOST.h"
#import "ENDNetWorkDELETE.h"





@implementation ENDNetWorkManager


+ (AFHTTPSessionManager *)shareManager {
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [ENDNetWorkManager managerWithBaseURL:LCP_BASE_URL sessionConfiguration:YES];
    });
    
    return manager;
}

+(AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL sessionConfiguration:(BOOL)isconfiguration {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager =nil;
    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL] sessionConfiguration:configuration];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *response   = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    response.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"text/css",@"text/javascript", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];

    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Referer"];
    // 设置超时时间
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer = response;
    return manager;
}
// 设置请求头
+ (void)setHeaderWithManager:(AFHTTPSessionManager *)manager headers:(NSDictionary *)headers PathUrl:(NSString *)pathUrl{
    
    headers = [ENDNetWorkManager configHeaderWithHeaders:headers];
    for (NSString *key in [headers allKeys]) {
        NSString *value = headers[key];
                if (!IsEmptyStr(key) && !IsEmptyStr(value)) {
        [manager.requestSerializer setValue:value forHTTPHeaderField:key];
            }
    }
}
+ (NSDictionary *)configHeaderWithHeaders:(NSDictionary *)headerParams {
    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:headerParams];
        if (KgetUserValueByParaName(@"token")) {
            [headers setObject:KgetUserValueByParaName(@"token") forKey:@"Authorization"];
        }
    return headers;
}

// 拼接path
+ (NSString *)splitJointPathWithPath:(NSString *)path host:(NSString *)host queryParams:(NSDictionary *)queryParams {
    NSString *realPath = [NSString stringWithFormat:@"%@%@%@", @"", host, path];
    for (NSString *key in [queryParams allKeys]) {
        NSString *value = queryParams[key];
        NSString *query = [NSString stringWithFormat:@"%@=%@", key, value];
        if ([key isEqualToString:[[queryParams allKeys] firstObject]]) {
            realPath = [NSString stringWithFormat:@"%@?%@", realPath, query];
        } else {
            realPath = [NSString stringWithFormat:@"%@&%@", realPath, query];
        }
    }
    return realPath;
}
+ (void)requestWithPathUrl:(NSString *)pathUrl parameters:(NSDictionary *)parameters queryParams:(NSDictionary *)queryParams Header:(NSDictionary *)headerParams success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock requestMethod:(HttpRequestType)requestMethod{
    switch ([LCPReachability shareReachability].networkStatus) {
        case kEICurrentNetworkStatusWiFi:
            DLog(@"WiFi");
            break;
        case kEICurrentNetworkStatus2G_3G_4G:
            DLog(@"移动信号");
            break;
        case kEICurrentNetworkStatusUnknown:
            DLog(@"当前网络不可用");
            break;
    }
//    NSInteger netStatus = [LCPSystemFactory internetStatus];
//    if (netStatus == 0) {
//        [Toast makeText:[[LCPUIFactory getCurrentVC] view] Message:@"网络连接中断，请检查网络" afterHideTime:DelayTime];
////        return;
//    }
    NSMutableDictionary *headerParam = [NSMutableDictionary dictionary];
    if (headerParams == nil) {
        headerParam = [NSMutableDictionary dictionary];
    }
    headerParam = [NSMutableDictionary dictionaryWithDictionary:headerParams];
    
    
    AFHTTPSessionManager *manager = [ENDNetWorkManager shareManager];
    
    [ENDNetWorkManager setHeaderWithManager:manager headers:headerParam PathUrl:pathUrl];
    
    if ([[queryParams allKeys] count]>0) {
        NSInteger i = 0;
        for (NSString *key in queryParams.allKeys) {
            if (i==0) {
                pathUrl = [NSString stringWithFormat:@"%@?%@=%@",pathUrl,key,queryParams[key]];
            } else {
                pathUrl = [NSString stringWithFormat:@"%@&%@=%@",pathUrl,key,queryParams[key]];
            }
            i++;
        }
    }
    NSString *newPathURl = [pathUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
//    (NSString *)
//     CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                              (CFStringRef)pathUrl,
//                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
//                                                              NULL,
//                                                              kCFStringEncodingUTF8));
    switch (requestMethod) {
        case kHttpRequestTypeFormPost:{
            [ENDNetWorkPOST POSTFormDataWithParams:parameters pathurl:newPathURl success:successBlock failure:failureBlock manager:manager];
        }break;
        case kHttpRequestTypePost:{
            
            [ENDNetWorkPOST POSTDataWithParams:parameters pathurl:newPathURl success:successBlock failure:failureBlock manager:manager];
        }break;
        case kHttpRequestTypeGet:{
            [ENDLCPNetWorkGET GETWithParameter:parameters pathurl:newPathURl success:successBlock failure:failureBlock manager:manager];
            //            //数据缓存处理
        }break;
        case kHttpRequestTypeDelete: {
            [ENDNetWorkDELETE DELETEWithParams:parameters pathurl:newPathURl success:successBlock failure:failureBlock manager:manager];
        }break;
        case kHttpRequestTypePut: {
            [ENDNetWorkPUT PUTWithParams:parameters pathurl:newPathURl success:successBlock failure:failureBlock manager:manager];
            
        }
            break;
        case kHttpRequestTypePatch:
        {
            [ENDNetWorkPUT PATCHWithParams:parameters pathurl:newPathURl success:successBlock failure:failureBlock manager:manager];
        }
            break;
        case kHttpRequestTypeJSONPost:
        {
            [ENDNetWorkPOST POSTJSONWithParams:parameters pathurl:newPathURl success:successBlock failure:failureBlock manager:manager];
        }
            break;
        default:break;
    }
}


//+ (void)startMultiPartUploadTaskWithOSSURL:(NSString *)url
//                               imagesArray:(NSArray *)images
//                         parameterOfimages:(NSString *)parameter
//                            parametersDict:(NSDictionary *)parameters
//                          compressionRatio:(float)ratio
//                              succeedBlock:(void(^)(BOOL success, id responseObject))succeedBlock
//                               failedBlock:(void(^)(id operation, NSError *error))failedBlock
//                       uploadProgressBlock:(void(^)(float uploadPercent,long long totalBytesWritten,long long totalBytesExpectedToWrite))uploadProgressBlock {
//    if (images.count == 0) {
//        DLog(@"上传内容没有包含图片");
//        return;
//    }
//
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager manager] initWithBaseURL:[NSURL URLWithString:url]];
//    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
//
//    AFHTTPRequestOperation *operation = [manager POST:@"" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        for (UIImage *image in images) {
//            NSString *fileName = [NSString stringWithFormat:@"%@",[parameters objectForKey:kLCPOSSSaveName]];
//            NSData *imageData;
//            if (ratio > 0.0f && ratio < 1.0f) {
//                imageData = UIImageJPEGRepresentation(image, ratio);
//            }else{
//                imageData = UIImageJPEGRepresentation(image, 1.0f);
//            }
//
//            [formData appendPartWithFileData:imageData name:parameter fileName:fileName mimeType:@"image/jpg/png/jpeg"];
//        }
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary* dict = @{@"url": [NSString stringWithFormat:@"%@/%@",url,[parameters objectForKey:@"key"]]};
//        succeedBlock(YES, dict);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
//        failedBlock(operation,error);
//    }];
//
//    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        CGFloat percent = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
//        uploadProgressBlock(percent,totalBytesWritten,totalBytesExpectedToWrite);
//    }];
//}

+ (void)getWithPathUrl:(NSString *)pathUrl parameters:(NSDictionary *)parameters queryParams:(NSDictionary *)queryParam Header:(NSDictionary *)header success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock{
    [self requestWithPathUrl:pathUrl parameters:parameters queryParams:queryParam Header:header success:successBlock failure:failureBlock requestMethod:kHttpRequestTypeGet];
}
+ (void)postWithPathUrl:(NSString *)pathUrl parameters:(NSDictionary *)parameters queryParams:(NSDictionary *)queryParam Header:(NSDictionary *)header success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock{
    [self requestWithPathUrl:pathUrl parameters:parameters queryParams:queryParam Header:header success:successBlock failure:failureBlock requestMethod:kHttpRequestTypePost];
}

+ (void)putWithPathUrl:(NSString *)pathUrl parameters:(NSDictionary *)parameters queryParams:(NSDictionary *)queryParam Header:(NSDictionary *)header success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock{
    [self requestWithPathUrl:pathUrl parameters:parameters queryParams:queryParam Header:header success:successBlock failure:failureBlock requestMethod:kHttpRequestTypePut];
}
+ (void)deleteWithPathUrl:(NSString *)pathUrl parameters:(NSDictionary *)parameters queryParams:(NSDictionary *)queryParam Header:(NSDictionary *)header success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock{
     [self requestWithPathUrl:pathUrl parameters:parameters queryParams:queryParam Header:header success:successBlock failure:failureBlock requestMethod:kHttpRequestTypeDelete];
}
+ (void)postFormWithPathUrl:(NSString *)pathUrl parameters:(NSDictionary *)parameters queryParams:(NSDictionary *)queryParam Header:(NSDictionary *)header success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock{
    [self requestWithPathUrl:pathUrl parameters:parameters queryParams:queryParam Header:header success:successBlock failure:failureBlock requestMethod:kHttpRequestTypeFormPost];
}
+ (void)getDownLoadWithPathUrl:(NSString *)pathUrl parameters:(NSDictionary *)parameters success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock
{
     AFHTTPSessionManager *manager = [ENDNetWorkManager shareManager];
    NSString *newPathURl = (NSString *)
    
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)pathUrl,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    [ENDLCPNetWorkGET GETDownLoadParameter:parameters pathurl:pathUrl success:successBlock failure:failureBlock manager:manager];
    
}
@end
