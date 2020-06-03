//
//  LXBaseViewController.m
//  QiHuoDemoA
//
//  Created by ox Ho on 2019/6/28.
//  Copyright © 2019 ShuoChao. All rights reserved.
//
//屏幕宽
#define SW [UIScreen mainScreen].bounds.size.width
//屏幕高
#define SH [UIScreen mainScreen].bounds.size.height
//屏幕frame
#define SF [UIScreen mainScreen].bounds
#import "ZCBaseViewController.h"

@interface ZCBaseViewController ()
{
    UITabBarController *_tabbarVc;
    
}
@end

@implementation ZCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - 传送控制器在导航条中的位置
-(void)setTabbarVc:(UITabBarController *)tabbar{
    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
    _tabbarVc = tabbar;
}

#pragma mark - 使用LXNavigationController需要调用此方法
-(void)backNavigationStyle:(UIColor *)navColor{
    
    int backH = (([[UIApplication sharedApplication] statusBarFrame].size.height == 44.0f) ? 88:64);
    
    UIView *backNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, backH)];
    
    backNav.backgroundColor = navColor;
    
    [self.view addSubview:backNav];
    
}

#pragma mark - 设置导航条样式
-(void)setTitle:(NSString *)titleName titleColor:(UIColor *)titleColor{
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleL.text = titleName;
    titleL.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    titleL.textColor = titleColor;
    titleL.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleL;
    
}//添加标题

-(void)setNavigationStyle:(UIColor *)NavColor{
    self.navigationController.navigationBar.barTintColor = NavColor;
}//改变颜色

-(void)setNavigationStyleImage:(NSString *)imageStr{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:imageStr] forBarMetrics:UIBarMetricsDefault];
}//添加图片

//自定义导航条按钮
-(void)setNavigationLeftBtn:(UIView *)leftBtn{
    UIBarButtonItem *barLeft = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barLeft;
}//左
-(void)setNavigationrightBtn:(UIView *)rightBtn{
    UIBarButtonItem *barRight = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = barRight;
}//右

//通用返回按钮
-(void)addBackBotton:(NSInteger)type{
    
    UIButton *backB = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [backB addTarget:self action:@selector(backVC:) forControlEvents:UIControlEventTouchUpInside];
    
    backB.tag = type;
    
    [backB setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc]initWithCustomView:backB];
    
    self.navigationItem.leftBarButtonItem = backBar;
    
}

-(void)backVC:(UIButton *)send{
    
    switch (send.tag) {
        case 0:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        case 1:{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - 控件边线设置
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width{
    
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    
}

#pragma mark - 无网络处理
-(void)netNone{
    
    // 初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查网络状态后刷新" preferredStyle:UIAlertControllerStyleAlert];
    // 确定注销
    UIAlertAction *setUp = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL        success) {
            }];
        }
        
    }];
    
    UIAlertAction *cancelB =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancelB];
    [alert addAction:setUp];
    
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
    
}


@end
