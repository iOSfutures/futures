//
//  NetWork.m
//  STOCKS
//
//  Created by apple on 2019/4/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork

//针对Request的
+(void)requestGet:(NSString *)path Success:(HttpSuccess)allData ERROR:(HttpFailure)errorL{
    //GET请求，直接把请求参数跟在URL的后面以?隔开 , 多个参数之间以&符号拼接
//    举例:http://www.dronghui.com/drhxx?m=xxx&b=xxxx&n=xxx
    
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:path];
    
    //2.创建请求对象
    //请求对象内部默认已经包含了请求头和请求方法(GET)
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.根据会话对象创建一个Task ( 发送请求 ）
    /*
     第一个参数 : 请求对象
     第二个参数 : completionHandler回调 ( 请求完成 ["成功"or"失败"] 的回调 )
     data : 响应体信息(期望的数据)
     response : 响应头信息,主要是对服务器端的描述
     error : 错误信息 , 如果请求失败 , 则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
                //6.解析服务器返回的数据
                //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                allData(dict);
            }else{
                errorL(error);
            }
        });
        
    }];
    
    //5.执行任务
    [dataTask resume];
}


@end
