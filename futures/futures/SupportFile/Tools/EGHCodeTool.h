//
//  EGHCodeTool.h
//  SCRBProject1
//
//  Created by zdh on 2019/6/26.
//  Copyright © 2019 zdh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringAndLabelDealTool.h"
#import "EGHViewsTool.h"
#import "TimerTool.h"
NS_ASSUME_NONNULL_BEGIN

@interface EGHCodeTool : NSObject
+ (BOOL)isIPhoneXSeries;
+ (BOOL)isNumText:(NSString *)str;

/**
 归档 本地存储

 @param objc <#objc description#>
 @param key <#key description#>
 */
+(void)archiveOJBC:(nullable id)objc saveKey:(NSString *)key;
/**
 解档 拿取数据

 @param key <#key description#>
 @return <#return value description#>
 */
+(id)getOBJCWithSavekey:(NSString *)key;
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;

@end

NS_ASSUME_NONNULL_END
