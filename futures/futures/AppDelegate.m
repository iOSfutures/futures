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

#import "UIImage+OriginalImage.h"

@interface AppDelegate ()

@property(nonatomic, strong)UITabBarController *tabBarC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController *tabBarC = [[UITabBarController alloc] init];
    tabBarC.tabBar.unselectedItemTintColor = [UIColor blackColor];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:254/255.0 green:114/255.0 blue:34/255.0 alpha:1.0]} forState:UIControlStateSelected];
    UIView *tabBarBgColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tabBarC.tabBar.bounds.size.width, tabBarC.tabBar.bounds.size.height)];
    tabBarBgColorView.backgroundColor =[UIColor systemBackgroundColor];
    [tabBarC.tabBar insertSubview:tabBarBgColorView atIndex:0];
    tabBarC.tabBar.opaque = YES;
//    [tabBarC.tabBarItem setImageInsets:UIEdgeInsetsMake(-40, 0, 0, 0)];
    self.tabBarC = tabBarC;
    
    HomeVC *homeVC = [[HomeVC alloc]init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [self addChildVC:homeNav title:@"首页" imgName:@"ic_home_tob" selectedImgName:@"ic_home_sstate"];
    [tabBarC addChildViewController:homeNav];
    
    CommunityVC *communityVC = [[CommunityVC alloc]init];
    UINavigationController *communityNav = [[UINavigationController alloc] initWithRootViewController:communityVC];
    [self addChildVC:communityNav title: @"社区" imgName:@"ic_community_tob" selectedImgName:@"ic_community_sstate_tob"];
    [tabBarC addChildViewController:communityNav];
    
    ReleaseVC *releaseVC = [[ReleaseVC alloc]init];
    UINavigationController *releaseNav = [[UINavigationController alloc] initWithRootViewController:releaseVC];
    [self addChildVC:releaseNav title:@"发布" imgName:@"ic_release" selectedImgName:@"ic_release"];
    [tabBarC addChildViewController:releaseNav];
    
    QuotesVC *quoteVC = [[QuotesVC alloc]init];
    UINavigationController *quoteNav = [[UINavigationController alloc] initWithRootViewController:quoteVC];
    [self addChildVC:quoteNav title:@"行情" imgName:@"ic_quotes_tob" selectedImgName:@"ic_quotes_tob"];
    [tabBarC addChildViewController:quoteNav];
    
    MineVC *mineVC = [[MineVC alloc]init];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    [self addChildVC:mineNav title:@"我的" imgName:@"ic_mine_tob" selectedImgName:@"ic_mine_sstate_tob"];
 
    self.window.rootViewController = tabBarC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)addChildVC:(UINavigationController *)nav title:(NSString *)title imgName:(NSString *)imageName selectedImgName:(NSString *)selectedImgName
{
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage originalImageWithName:imageName];
    nav.tabBarItem.selectedImage = [UIImage originalImageWithName:selectedImgName];
    [self.tabBarC addChildViewController:nav];
}


@end
