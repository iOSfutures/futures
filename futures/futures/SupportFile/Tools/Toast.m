//
//  Toast.m
//  SaleHelper
//
//  Created by liusanchun on 13-11-12.
//  Copyright (c) 2013年 liusanchun. All rights reserved.
//

#import "Toast.h"
#import <MBProgressHUD.h>

@interface Toast ()

@property (nonatomic, assign) NSInteger count;

@end

@implementation Toast
static Toast *_instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[super allocWithZone:NULL] init] ;
        }
    });
    return _instance;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [Toast shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [Toast shareInstance] ;
}

+ (void)makeText:(UIView*)inView
         Message:(NSString*)message
   afterHideTime:(float)hideTime
{
    if (inView == nil) {
        return;
    }
    Toast *toast = [Toast shareInstance];
    if (toast.count) {
        return;
    }
    toast.count = 1;
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:inView];
    progressHud.layer.zPosition = 15.0f;
    progressHud.labelText = message;
    progressHud.center = inView.center;
    progressHud.alpha = 0.5f;
    progressHud.mode = MBProgressHUDModeText;
    [inView addSubview:progressHud];
    [progressHud showAnimated:YES
          whileExecutingBlock:^{
              sleep(hideTime);
          }
              completionBlock:^{
                  [progressHud removeFromSuperview];
                  toast.count = 0;
              }];
}

+ (void)makeDetialText:(UIView*)inView
               Message:(NSString*)message
         afterHideTime:(float)hideTime
{
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:inView];
    progressHud.layer.zPosition = 15.0f;
    progressHud.detailsLabelText = message;
    progressHud.center = inView.center;
    progressHud.alpha = 0.5f;
    progressHud.mode = MBProgressHUDModeText;
    [inView addSubview:progressHud];
    [progressHud showAnimated:YES
          whileExecutingBlock:^{
              sleep(hideTime);
          }
              completionBlock:^{
                  [progressHud removeFromSuperview];
              }];
}

+ (void)makeText:(UIView*)inView
         Message:(NSString*)message
   afterHideTime:(float)hideTime offSet:(float)offset  completionBlock:(void (^)())completion{
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:inView];
    if (offset==0) {
        progressHud.layer.zPosition = 15.0f;
        progressHud.center = inView.center;
    }
    else{
        progressHud.yOffset=offset;
    }
    
    progressHud.labelText = message;
    progressHud.alpha = 0.5f;
    progressHud.mode = MBProgressHUDModeText;
    [inView addSubview:progressHud];
    [progressHud showAnimated:YES
          whileExecutingBlock:^{
              sleep(hideTime);
          }
              completionBlock:^{
                  [progressHud removeFromSuperview];
                  if (completion) {
                      completion();
                  }
              }];
}

+(void)makeText:(UIView *)inView Message:(NSString *)message afterHideTime:(float)hideTime offSetY:(float)offSet{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:window];
    // progressHud.layer.zPosition = 15.0f;
    progressHud.labelText = message;
    // progressHud.center = inView.center;
    progressHud.yOffset=offSet;
    progressHud.alpha = 0.5f;
    progressHud.mode = MBProgressHUDModeText;
    [inView addSubview:progressHud];
    [progressHud showAnimated:YES
          whileExecutingBlock:^{
              sleep(hideTime);
          }
              completionBlock:^{
                  [progressHud removeFromSuperview];
              }];
}
@end
