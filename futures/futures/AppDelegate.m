//
//  AppDelegate.m
//  futures
//
//  Created by Francis on 2020/5/11.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "CommunityVC.h"
#import "ReleaseVC.h"
#import "QuotesVC.h"
#import "MineVC.h"

#import "CustomTBC.h"

#import "UIImage+OriginalImage.h"

@interface AppDelegate ()

@property(nonatomic, strong)CustomTBC *customTBC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor systemBackgroundColor];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    CustomTBC *customTBC = CustomTBC.new;
    self.customTBC = customTBC;
    
    HomeVC *homeVC = [[HomeVC alloc]init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [self addChildVC:homeNav title:@"首页" imgName:@"ic_home_tob" selectedImgName:@"ic_home_sstate"];
    
    CommunityVC *communityVC = [[CommunityVC alloc]init];
    UINavigationController *communityNav = [[UINavigationController alloc] initWithRootViewController:communityVC];
    [self addChildVC:communityNav title: @"社区" imgName:@"ic_community_tob" selectedImgName:@"ic_community_sstate_tob"];
    
    ReleaseVC *releaseVC = [[ReleaseVC alloc]init];
    UINavigationController *releaseNav = [[UINavigationController alloc] initWithRootViewController:releaseVC];
    releaseNav.tabBarItem.title = @"发布";
    releaseNav.tabBarItem.image = [UIImage originalImageWithName:@"ic_release"];
    [self.customTBC addChildViewController:releaseNav];
    
    QuotesVC *quoteVC = [[QuotesVC alloc]init];
    UINavigationController *quoteNav = [[UINavigationController alloc] initWithRootViewController:quoteVC];
    [self addChildVC:quoteNav title:@"行情" imgName:@"ic_quotes_tob" selectedImgName:@"ic_quotes_sstate_tob"];
    
    MineVC *mineVC = [[MineVC alloc]init];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    [self addChildVC:mineNav title:@"我的" imgName:@"ic_mine_tob" selectedImgName:@"ic_mine_sstate_tob"];
    
    self.window.rootViewController = customTBC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)addChildVC:(UINavigationController *)nav title:(NSString *)title imgName:(NSString *)imageName selectedImgName:(NSString *)selectedImgName
{
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    [self.customTBC addChildViewController:nav];
}

@end
