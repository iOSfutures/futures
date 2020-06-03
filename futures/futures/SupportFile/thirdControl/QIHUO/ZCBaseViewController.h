//
//  ZCBaseViewController.h
//  QiHuoDemoA
//
//  Created by ox Ho on 2019/6/28.
//  Copyright © 2019 ShuoChao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCBaseViewController : UIViewController
#pragma mark - 传送控制器在导航条中的位置
-(void)setTabbarVc:(UITabBarController *)tabbar;//设置底部tabbar

#pragma mark - 使用LXNavigationController需要调用此方法
-(void)backNavigationStyle:(UIColor *)navColor;

#pragma mark - 设置导航条样式
-(void)setTitle:(NSString *)titleName titleColor:(UIColor *)titleColor;//设置标题

-(void)setNavigationStyle:(UIColor *)NavColor;//导航条颜色

-(void)setNavigationStyleImage:(NSString *)imageStr;//导航背景图片

-(void)setNavigationLeftBtn:(UIView *)leftBtn;

-(void)setNavigationrightBtn:(UIView *)rightBtn;//自定义按钮

-(void)addBackBotton:(NSInteger)type;//通用返回按钮

#pragma mark - 控件边线设置
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;

#pragma mark - 无网络处理
-(void)netNone;
@end

NS_ASSUME_NONNULL_END
