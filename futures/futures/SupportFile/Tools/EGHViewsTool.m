//
//  EGHViewsTool.m
//  SCRBProject1
//
//  Created by zdh on 2019/6/27.
//  Copyright © 2019 zdh. All rights reserved.
//

#import "EGHViewsTool.h"
#import <MBProgressHUD.h>

@implementation EGHViewsTool
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+(UIFont *)setLabelFont:(CGFloat)font Weight:(UIFontWeight)weight{
    UIFont *labelFont;
    if (@available(iOS 8.2, *)) {
        labelFont = [UIFont systemFontOfSize:font weight:weight];
    } else {
        // Fallback on earlier versions
        labelFont = [UIFont systemFontOfSize:font];
    }
    return labelFont;
}
//画一个什么颜色的图
+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

//隐藏navigationbar上面的_UIVisualEffectSubview的superView
+(void)getBackView:(UIView*)superView getViewBlock:(void(^)(UIView *view))Blcok

{
    if (Blcok) {
        Blcok(superView);
    }
    
    for (UIView *view in superView.subviews)
    {
        [self getBackView:view getViewBlock:Blcok];
    }
    
}
+ (UIViewController *)jsd_getRootViewController{
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

+ (UIViewController *)jsd_getCurrentViewController{
    
    UIViewController* currentViewController = [self jsd_getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}

+ (UIImage *)viewImageFromColor:(UIColor *)color rect:(CGRect)rect{
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(void)showHud{
    __block BOOL hasHud;
    dispatch_queue_t currentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(currentQueue, ^{
        dispatch_barrier_async(currentQueue, ^{
            DLog(@"111!!!!!");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getBackView:[[self getCurrentVC] view] getViewBlock:^(UIView * _Nonnull view) {
                    if ([view isKindOfClass:NSClassFromString(@"MBProgressHUD")]) {
                        hasHud = YES;
                    }
                }];
            });
        });
        dispatch_barrier_async(currentQueue, ^{
            DLog(@"22222!!!!!");
            if (!hasHud) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIViewController *VC = [self getCurrentVC];
                      DLog(@"%@ !!!",VC);
                    [MBProgressHUD showHUDAddedTo:VC.view animated:YES];
                });
            }
        });
    });
}
+(void)hideHud{
    [MBProgressHUD hideHUDForView:[[self getCurrentVC] view] animated:YES];
}



/*
 view 是要设置渐变字体的控件   bgVIew是view的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+(void)TextGradientview:(UIView *)view bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer* gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = view.frame;
    gradientLayer1.colors = colors;
    gradientLayer1.startPoint =startPoint;
    gradientLayer1.endPoint = endPoint;
    [bgVIew.layer addSublayer:gradientLayer1];
    gradientLayer1.mask = view.layer;
    view.frame = gradientLayer1.bounds;
}


@end
