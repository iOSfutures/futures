//
//  CustomTBC.m
//  futures
//
//  Created by Ssiswent on 2020/5/12.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CustomTBC.h"

@interface CustomTBC ()

@end

@implementation CustomTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取用户偏好
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //初始化userId
//    if([userDefault objectForKey:@"userId"] == nil)
//    {
        [userDefault setObject:nil forKey:@"userId"];
//    }
    
    //去掉原生tabbar分割线
    [self.tabBar setShadowImage:[UIImage new]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    
    self.tabBar.tintColor = UIColorWithRGBA(254, 162, 3, 1);
    self.tabBar.unselectedItemTintColor = [UIColor blackColor];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect frame = self.tabBar.frame;
    if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667)
    {
        frame.size.height = 74;
    }
    else if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812)
    {
        frame.size.height = 70;
    }
    else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 736)
    {
        frame.size.height = 74;
    }
    else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 896)
    {
        frame.size.height = 80;
    }
    frame.origin.y = self.view.frame.size.height - frame.size.height;
    self.tabBar.frame = frame;
    
    NSInteger count = 0;
    for (UITabBarItem * item in self.tabBar.items) {
        if(count == 2)
        {
            if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667)
            {
                item.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0);
            }
            else if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812)
            {
                item.titlePositionAdjustment = UIOffsetMake(0, 15);
            }
            else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 736)
            {
                item.imageInsets = UIEdgeInsetsMake(-4, 0, 4, 0);
                item.titlePositionAdjustment = UIOffsetMake(0, -5);
            }
            else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 896)
            {
                item.titlePositionAdjustment = UIOffsetMake(0, 13);
                item.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            }
        }
        else
        {
            if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667)
            {
                item.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);
            }
            else if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812)
            {
                item.titlePositionAdjustment = UIOffsetMake(0, 15);
                item.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
            }
            else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 736)
            {
                item.titlePositionAdjustment = UIOffsetMake(0, -5);
            }
            else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 896)
            {
                item.titlePositionAdjustment = UIOffsetMake(0, 13);
                item.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
            }
        }
        count ++;
    }
}

@end
