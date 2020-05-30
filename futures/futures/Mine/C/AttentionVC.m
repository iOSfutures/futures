//
//  AttentionVC.m
//  futures
//
//  Created by apple on 2020/5/25.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "AttentionVC.h"
#import "MineVC.h"
#import "AttentionTableViewCell.h"
#import "UIImage+OriginalImage.h"

#import "UserModel.h"

@interface AttentionVC () <UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)NSArray *followsArray;

@end

@implementation AttentionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:254/255.0 green:162/255.0 blue:3/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back "] style:0 target:self action:@selector(backBtnClicked)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if([_followsOrFans isEqualToString:@"follows"])
    {
        [self getFollows];
    }
    else if([_followsOrFans isEqualToString:@"Fans"])
    {
        [self getFans];
    }
    
    
    
    //启用右滑返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)backBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.tabBarController.tabBar.frame;
        if(SCREEN_WIDTH == 375)
        {
            frame.origin.y = 667;
        }
        else if (SCREEN_WIDTH == 414)
        {
            frame.origin.y = 896;
        }
        self.tabBarController.tabBar.frame = frame;
    }];
}

#pragma mark - UITableViewViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.followsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Attention";
    AttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AttentionTableViewCell" owner:self options:nil]lastObject];
    }
    cell.model = self.followsArray[indexPath.row];
    return cell;
}

-(void)getFollows{
    WEAKSELF
    NSDictionary *dic = @{@"userId":@155,@"type":@1};
    [ENDNetWorkManager getWithPathUrl:@"/user/follow/getUserFollowList" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.followsArray = [MTLJSONAdapter modelsOfClass:[UserModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求关注列表失败" afterHideTime:DELAYTiME];
    }];
}

-(void)getFans{
    WEAKSELF
    NSDictionary *dic = @{@"userId":@155,@"type":@2};
    [ENDNetWorkManager getWithPathUrl:@"/user/follow/getUserFollowList" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.followsArray = [MTLJSONAdapter modelsOfClass:[UserModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求粉丝列表失败" afterHideTime:DELAYTiME];
    }];
}

@end
