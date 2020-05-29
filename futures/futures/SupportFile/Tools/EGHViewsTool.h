//
//  EGHViewsTool.h
//  SCRBProject1
//
//  Created by zdh on 2019/6/27.
//  Copyright © 2019 zdh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EGHViewsTool : NSObject
+ (UIViewController *)getCurrentVC;
/**
 设置字体粗细

 @param font <#font description#>
 @param weight <#weight description#>
 @return <#return value description#>
 */
+(UIFont *)setLabelFont:(CGFloat)font Weight:(UIFontWeight)weight;
/**
 画个图出来

 @param color 颜色
 @param height 高度
 @return 返回值
 */
+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

/**
 获取某一父视图的所有子视图

 @param superView 父视图
 @param Blcok 返回子视图
 */
+(void)getBackView:(UIView*)superView getViewBlock:(void(^)(UIView *view))Blcok;

/**
 获取根控制器

 @return 返回
 */
+ (UIViewController *)jsd_getRootViewController;
/**
 获取当前页面控制器

 @return 获取当前页面控制器
 */
+ (UIViewController *)jsd_getCurrentViewController;
/**
 画张图片

 @param color 颜色
 @param rect 大小
 @return 返回
 */
+ (UIImage *)viewImageFromColor:(UIColor *)color rect:(CGRect)rect;

+(void)showHud;
+(void)hideHud;

/**
 设置渐变字

 @param view 渐变的控件
 @param bgVIew 背景图
 @param colors 颜色
 @param startPoint 起始点
 @param endPoint 终点
 */
+(void)TextGradientview:(UIView *)view bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
@end

NS_ASSUME_NONNULL_END
