//
//  Toast.h
//  SaleHelper
//
//  Created by liusanchun on 13-11-12.
//  Copyright (c) 2013年 liusanchun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Toast : NSObject

+ (void)makeText:(UIView*)inView
         Message:(NSString*)message
   afterHideTime:(float)hideTime;

+ (void)makeDetialText:(UIView*)inView
               Message:(NSString*)message
         afterHideTime:(float)hideTime;

+ (void)makeText:(UIView*)inView
         Message:(NSString*)message
   afterHideTime:(float)hideTime
         offSetY:(float)offSet;

+ (void)makeText:(UIView*)inView
         Message:(NSString*)message
   afterHideTime:(float)hideTime offSet:(float)offset completionBlock:(void (^)())completion;
@end
