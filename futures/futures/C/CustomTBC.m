//
//  CustomTBC.m
//  futures
//
//  Created by Ssiswent on 2020/5/12.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CustomTBC.h"

#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define kScaleFrom_iPhone6_Desgin(_X_) (_X_ * (SCREEN_WIDTH/375))

@interface CustomTBC ()

@end

@implementation CustomTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //去掉原生tabbar分割线
    [self.tabBar setShadowImage:[UIImage new]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    
    self.tabBar.unselectedItemTintColor = [UIColor blackColor];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:254/255.0 green:114/255.0 blue:34/255.0 alpha:1.0]} forState:UIControlStateSelected];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect frame = self.tabBar.frame;
    frame.size.height = kScaleFrom_iPhone6_Desgin(74);
    frame.origin.y = self.view.frame.size.height - frame.size.height;
    self.tabBar.frame = frame;
    
    NSInteger count = 0;
    for (UITabBarItem * item in self.tabBar.items) {
        if(count == 2)
        {
            if(SCREEN_WIDTH == 375)
            {
                item.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0);
            }
            else if (SCREEN_WIDTH == 414)
            {
                item.titlePositionAdjustment = UIOffsetMake(0, 10);
                item.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            }
        }
        else
        {
            if(SCREEN_WIDTH == 375)
            {
                item.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);
            }
            else if (SCREEN_WIDTH == 414)
            {
                item.titlePositionAdjustment = UIOffsetMake(0, 10);
                item.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
            }
        }
        count ++;
    }
}

@end
