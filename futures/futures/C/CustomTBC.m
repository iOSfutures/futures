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
    
    //去掉原生tabbar分割线
    [self.tabBar setShadowImage:[UIImage new]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    
    self.tabBar.tintColor = UIColorWithRGBA(254, 162, 3, 1);
    self.tabBar.unselectedItemTintColor = [UIColor blackColor];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect frame = self.tabBar.frame;
    frame.size.height = kScaleFrom_iPhone8_Width(74);
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
