//
//  AppDelegate.m
//  futures
//
//  Created by Francis on 2020/5/11.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "AppDelegate.h"
#import "MXZHomeVC.h"
#import "CommunityVC.h"
#import "PublishVC.h"
#import "ZZHQuotesVC.h"
#import "MineVC.h"

#import "UIColor+Hex.h"

#import "CustomTBC.h"

#import "UIImage+OriginalImage.h"

@interface AppDelegate ()

@property(nonatomic, strong)CustomTBC *customTBC;

@property (nonatomic, strong) UIView *customizedStatusBar;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor systemBackgroundColor];
    
    [[UITextField appearance] setTintColor:[UIColor colorWithHexString:@"#FEA307"]];
    
    CustomTBC *customTBC = CustomTBC.new;
    self.customTBC = customTBC;
    
    MXZHomeVC *homeVC = [[MXZHomeVC alloc]init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [self addChildVC:homeNav title:@"首页" imgName:@"ic_home_tob" selectedImgName:@"ic_home_sstate"];
    
    CommunityVC *communityVC = [[CommunityVC alloc]init];
    UINavigationController *communityNav = [[UINavigationController alloc] initWithRootViewController:communityVC];
    [self addChildVC:communityNav title: @"社区" imgName:@"ic_community_tob" selectedImgName:@"ic_community_sstate_tob"];
    
    PublishVC *releaseVC = [[PublishVC alloc]init];
    UINavigationController *releaseNav = [[UINavigationController alloc] initWithRootViewController:releaseVC];
    releaseNav.tabBarItem.title = @"发布";
    releaseNav.tabBarItem.image = [UIImage originalImageWithName:@"ic_release"];
    [self.customTBC addChildViewController:releaseNav];
    
    ZZHQuotesVC *quoteVC = [[ZZHQuotesVC alloc]init];
    UINavigationController *quoteNav = [[UINavigationController alloc] initWithRootViewController:quoteVC];
    [self addChildVC:quoteNav title:@"行情" imgName:@"ic_quotes_tob" selectedImgName:@"ic_quotes_sstate_tob"];
    
    MineVC *mineVC = [[MineVC alloc]init];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    [self addChildVC:mineNav title:@"我的" imgName:@"ic_mine_tob" selectedImgName:@"ic_mine_sstate_tob"];
    
    self.window.rootViewController = customTBC;
    [self.window makeKeyAndVisible];
    
    [self setStatusBar];
    
    return YES;
}

- (void)setStatusBar
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    if (@available(iOS 13.0, *)) {// iOS 13 不能直接获取到statusbar 手动添加个view到window上当做statusbar背景
        if (!self.customizedStatusBar) {
            //获取最底层Window
            NSArray *array = [UIApplication sharedApplication].windows;
            UIWindow *keyWindow = [array objectAtIndex:0];
            self.customizedStatusBar = [[UIView alloc] initWithFrame:keyWindow.windowScene.statusBarManager.statusBarFrame];
            [keyWindow addSubview:self.customizedStatusBar];
        }
    }
    else {
        self.customizedStatusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    }
    
    if ([self.customizedStatusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        self.customizedStatusBar.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    }
}

- (void)addChildVC:(UINavigationController *)nav title:(NSString *)title imgName:(NSString *)imageName selectedImgName:(NSString *)selectedImgName
{
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    [self.customTBC addChildViewController:nav];
}

@end
