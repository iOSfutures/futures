//
//  ENDLCPNetWorkGET.m
//  Lycam_ZSB_App
//
//  Created by fengshicao on 2018/8/3.
//  Copyright © 2018年 LycamPlus. All rights reserved.
//

#import "ENDLCPNetWorkGET.h"
//#import "YYCache.h"
#import "LCPReachability.h"
//#import "LCPOSSImageModel.h"


static const NSString *cacheDataKey = @"cacheDataKey";
static const NSString *cacheTimeKey = @"cacheTimeKey";

@implementation ENDLCPNetWorkGET
#pragma mark -- get请求
+ (void)GETWithParameter:(NSDictionary *)parameters pathurl:(NSString *)pathUrl success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock manager:(AFHTTPSessionManager *)manager
{
//    //数据缓存处理
//    NSString *paraStr = parameters?[LCPUIFactory dictionaryToJson:parameters]:@"parastr";
//    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:pathUrl];
//    YYCache *cache = [YYCache cacheWithPath:cachePath];
//    NSString *cacheKey = [LCPUIFactory encrypt_MD5:[NSString stringWithFormat:@"%@%@",pathUrl,paraStr]];
//    //    BOOL updateCache = [[NSUserDefaults standardUserDefaults]boolForKey:@"updateCache"];
//    id responseObject = [cache objectForKey:cacheKey];
//    id cacheData;
//    int seconds = 0;
//    int page = [parameters[@"hotPage"] intValue]?[parameters[@"hotPage"] intValue]:[parameters[@"page"] intValue];
//    if (responseObject) {
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        cacheData = responseObject[cacheDataKey];
//        //获取到更新文件的时间
//        NSString *curDatestr = [LCPUIFactory getsecondLocalDateFormateUTCDate:responseObject[cacheTimeKey]];
//        //        DLog(@"数据存储最新时间：%@",curDatestr);
//        seconds = [LCPUIFactory timeIntervalWithDateStr:curDatestr];
//        //        DLog(@"数据存储时间与当前时间间隔：%d",seconds);
//    }
//    NSInteger netStatus = [LCPSystemFactory internetStatus];
//    //    EICurrentNetworkStatus netStatus = (int)[[LCPReachability shareReachability] getCurrentNetworkStatus];
//    if (cacheData&&(page==1||page==0)&&((seconds>2&&(netStatus==kEICurrentNetworkStatusUnknown ||netStatus== -1))|| netStatus == kEICurrentNetworkStatusUnknown || netStatus == -1)) {
//        successBlock(YES,cacheData);
//        if (netStatus==kEICurrentNetworkStatusUnknown) {
//            DLog(@"额，没有网哦~");
//        }
//    }else{
        [manager GET:pathUrl parameters:parameters success:^(NSURLSessionDataTask *task, id ResponseObject) {
            NSDictionary* json;
            if ([ResponseObject isKindOfClass:[NSDictionary class]]) {
                json=ResponseObject;
            }else{
                json=[NSJSONSerialization JSONObjectWithData:ResponseObject options:NSUTF8StringEncoding error:nil];
            }
            DLog(@"**********=======**********");
            DLog(@"url == %@",pathUrl);
            DLog(@"**********=======**********");
            if ([json isKindOfClass:[NSDictionary class]] && [json.allKeys containsObject:@"success"] && ![json[@"success"]  isEqual:@1]) {
                DLog(@"%@",json[@"msg"]);
            }
            [ENDLCPNetWorkERROR DealJsonDict:json callBackBlock:^(id result, BOOL error) {
                if (!error) {
                    successBlock(YES,json);
                }else{
                    failureBlock(NO,result);
                }
            }];
            if (ResponseObject&&([pathUrl isEqualToString:@""])) {
                
                NSDictionary *caches = @{cacheDataKey:ResponseObject,cacheTimeKey:[NSDate date]};
//                [cache setObject:caches forKey:cacheKey];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [ENDLCPNetWorkERROR dealErrorInfo:error Task:task CompeleteBlcok:^(NSError *newError) {
                failureBlock(YES,newError);
            }];
        }];
//    }
}
//+ (void)getUploadPolicyWithSuccessBlock:(HTTPSuccessBlock)successBlock
//                           withFailureBlock:(HTTPFailureBlock)failureBlock {
//        [RHDJNetWorkManager getWithPathUrl:LCP_UPLOADFILE parameters:nil queryParams:nil Header:nil success:^(BOOL success, id JSON) {
//            if (success && [JSON isKindOfClass:[NSDictionary class]]) {
//                NSError* error;
//                LCPOSSImageModel* imageModel = [MTLJSONAdapter modelOfClass:[LCPOSSImageModel class] fromJSONDictionary:JSON[@"data"] error:&error];
//                if (imageModel) {
//                    successBlock(YES, imageModel);
//                }else {
//                    failureBlock(YES, error);
//                }
//            }else{
//                failureBlock(YES,nil);
//            }
//        } failure:^(BOOL failuer, NSError *error) {
//            failureBlock(YES, error);
//        }];
//    }
//


//+ (void)GETDownLoadParameter:(NSDictionary *)parameters pathurl:(NSString *)pathUrl success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock manager:(AFHTTPSessionManager *)manager
//{
//    NSString *paraStr = parameters?[LCPUIFactory dictionaryToJson:parameters]:@"parastr";
//    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:pathUrl];
//    YYCache *cache = [YYCache cacheWithPath:cachePath];
//    NSString *cacheKey = [LCPUIFactory encrypt_MD5:[NSString stringWithFormat:@"%@%@",pathUrl,paraStr]];
//    //    BOOL updateCache = [[NSUserDefaults standardUserDefaults]boolForKey:@"updateCache"];
//    id responseObject = [cache objectForKey:cacheKey];
//    id cacheData;
//    int seconds = 0;
//    int page = [parameters[@"hotPage"] intValue]?[parameters[@"hotPage"] intValue]:[parameters[@"page"] intValue];
//    if (responseObject) {
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        cacheData = responseObject[cacheDataKey];
//        //获取到更新文件的时间
//        NSString *curDatestr = [LCPUIFactory getsecondLocalDateFormateUTCDate:responseObject[cacheTimeKey]];
//        //        DLog(@"数据存储最新时间：%@",curDatestr);
//        seconds = [LCPUIFactory timeIntervalWithDateStr:curDatestr];
//        //        DLog(@"数据存储时间与当前时间间隔：%d",seconds);
//    }
//    NSInteger netStatus = [LCPSystemFactory internetStatus];
//    //    EICurrentNetworkStatus netStatus = (int)[[LCPReachability shareReachability] getCurrentNetworkStatus];
//    if (cacheData&&(page==1||page==0)&&((seconds>2&&(netStatus==kEICurrentNetworkStatusUnknown ||netStatus== -1))|| netStatus == kEICurrentNetworkStatusUnknown || netStatus == -1)) {
//        successBlock(YES,cacheData);
//        if (netStatus==kEICurrentNetworkStatusUnknown) {
//            DLog(@"额，没有网哦~");
//        }
//    }else{
//        /* 下载路径 */
////        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
////        NSString *filePath = [path stringByAppendingPathComponent:pathUrl.lastPathComponent];
//
//        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        AFURLSessionManager *managers = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//        managers.responseSerializer = [AFHTTPResponseSerializer serializer];
//       /* 开始请求下载 */
//        NSString *urlStr = [NSString stringWithFormat:@"%@%@",LCP_BASE_URL,pathUrl];
////        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlStr parameters:parameters error:nil];
//        [request setValue:[LCPAccountManager defaultManager].user.token forHTTPHeaderField:@"Authorization"];
//        [request setValue:@"ios" forHTTPHeaderField:@"Referer"];
////        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
////        [request setValue:@"text/html;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//                [request setValue:@"zh-CN" forHTTPHeaderField:@"Accept-Language"];
//
//
//        NSURLSessionDownloadTask *downloadTask = [managers downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
////            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
////            NSString *path = [paths objectAtIndex:0];
////            NSString *filePath = [path stringByAppendingPathComponent:[response suggestedFilename]];
////            NSFileManager *fileManager = [NSFileManager defaultManager];
////            BOOL result = [fileManager fileExistsAtPath:filePath];
//                NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//                //        [response suggestedFilename]为文件名
//                NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//                return url;
//        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
//            NSString *strCode = [NSString stringWithFormat:@"%ld",(long)httpResponse.statusCode];
//            if ([strCode intValue] == 200) {
//                successBlock(YES,filePath);
//            }
//        }];
//        [downloadTask resume];
//    }
//}

@end
