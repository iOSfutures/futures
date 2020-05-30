//
//  MXZSettingCenterVC.m
//  futures
//
//  Created by Francis on 2020/5/25.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZSettingCenterVC.h"
#import "MXZAboutUsVC.h"
#import "UIImage+OriginalImage.h"
#import "MXZFeedbackVC.h"

@interface MXZSettingCenterVC ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *labelArray;

@end

@implementation MXZSettingCenterVC

- (NSArray *)labelArray{
    if (_labelArray == nil) {
        _labelArray = [[NSArray alloc]initWithObjects:@"立即注册与登录", @"编辑个人资料", @"意见与反馈", @"关于我们", @"退出登录", @"清理所有数据", nil];
    }
    return _labelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置中心";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(backPreView)];
    
    //启用右滑返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)backPreView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 3;
    }
    else if (section == 1){
        return 2;
    }
    else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    if (indexPath.section == 0) {
        cell.textLabel.text = self.labelArray[indexPath.row];
    }
    else if (indexPath.section == 1){
        cell.textLabel.text = self.labelArray[indexPath.row + 3];
    }
    else{
        cell.textLabel.text = self.labelArray[indexPath.row + 5];
        cell.textLabel.textColor = [UIColor redColor];
    }
    // 设置cell右边的指示样式
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    if (section != 2) {
        header.frame = CGRectMake(0, 0, 0, 38);
    }
    else{
        header.frame = CGRectMake(0, 0, 0, 56);
    }
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 2) {
        //跳转到意见反馈界面
        MXZFeedbackVC *feedbackVC = [[MXZFeedbackVC alloc]init];
        [self.navigationController pushViewController:feedbackVC animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 0){
        MXZAboutUsVC *aboutVC = [[MXZAboutUsVC alloc]init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}

@end
