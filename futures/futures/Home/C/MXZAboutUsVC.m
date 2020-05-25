//
//  MXZAboutUsVC.m
//  futures
//
//  Created by Francis on 2020/5/25.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZAboutUsVC.h"

@interface MXZAboutUsVC ()
@property (weak, nonatomic) IBOutlet UIView *checkView;

@end

@implementation MXZAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"关于我们";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    //设置checkView阴影
//    self.checkView.backgroundColor = [UIColor colorWithRed:35/255.0 green:33/255.0 blue:56/255.0 alpha:1.0];
    _checkView.backgroundColor = [UIColor whiteColor];
    _checkView.layer.shadowColor = [UIColor colorWithRed:144/255.0 green:199/255.0 blue:254/255.0 alpha:0.19].CGColor;
    _checkView.layer.shadowOffset = CGSizeMake(0, 0);
    _checkView.layer.shadowOpacity = 1;
    _checkView.layer.shadowRadius = 5;
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
