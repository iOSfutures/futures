//
//  HomeExpressVC.m
//  futures
//
//  Created by Francis on 2020/5/12.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZHomeExpressVC.h"
#import "UIImage+OriginalImage.h"

@interface MXZHomeExpressVC ()

@end

@implementation MXZHomeExpressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"7X24快讯";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(backPreView)];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)backPreView{
    [self.navigationController popViewControllerAnimated:YES];
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
