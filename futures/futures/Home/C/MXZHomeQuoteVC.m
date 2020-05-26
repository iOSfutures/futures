//
//  HomeQuoteVC.m
//  futures
//
//  Created by Francis on 2020/5/12.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZHomeQuoteVC.h"
#import "JXCategoryTitleView.h"
#import "MXZTtileVC.h"
#import "UIImage+OriginalImage.h"

@interface MXZHomeQuoteVC ()
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation MXZHomeQuoteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"实时行情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [self.navigationController popViewControllerAnimated:YES];
//    [self setTitleView];
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

-(void)setTitleView{
    MXZTtileVC *titleVC = [[MXZTtileVC alloc] init];
    
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)titleVC.categoryView;
    titleCategoryView.titleColorGradientEnabled = YES;
    titleVC.isNeedIndicatorPositionChangeItem = YES;
    [self.navigationController pushViewController:titleVC animated:YES];
    
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
