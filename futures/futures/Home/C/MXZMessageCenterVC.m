//
//  MXZMessageCenterVC.m
//  futures
//
//  Created by Francis on 2020/5/25.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZMessageCenterVC.h"

@interface MXZMessageCenterVC ()

@end

@implementation MXZMessageCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息中心";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
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
