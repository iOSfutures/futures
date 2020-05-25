//
//  HomeExpressVC.m
//  futures
//
//  Created by Francis on 2020/5/12.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZHomeExpressVC.h"

@interface MXZHomeExpressVC ()

@end

@implementation MXZHomeExpressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"7X24快讯";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
