//
//  MacroNetWorkHeader.h
//  SCRBProject1
//
//  Created by zdh on 2019/6/25.
//  Copyright © 2019 zdh. All rights reserved.
//

#ifndef MacroNetWorkHeader_h
#define MacroNetWorkHeader_h


#ifdef DEBUG //开发
#define LCP_BASE_URL @"http://api.yysc.online"

#else  //生产

#define LCP_BASE_URL @"http://api.yysc.online"

#endif


#import "ENDLCPNetWorkERROR.h"

typedef void(^HTTPSuccessBlock)(BOOL success,id result);

typedef void(^HTTPFailureBlock)(BOOL failuer,NSError *error);

typedef NS_ENUM(NSInteger, HttpRequestType) {
    kHttpRequestTypePost = 1,
    kHttpRequestTypeGet = 2,
    kHttpRequestTypeDelete = 3,
    kHttpRequestTypePut = 4,
    kHttpRequestTypePatch,
    kHttpRequestTypeJSONPost,
    kHttpRequestTypeFormPost,
};

#import "ENDNetWorkManager.h"


#endif /* MacroNetWorkHeader_h */
