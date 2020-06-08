//
//  QuoteNewsVC.m
//  futures
//
//  Created by apple on 2020/5/14.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "ZZHQuoteNewsVC.h"
#import "ZZHTimeLineTableViewCell.h"
#import "ZZHImageTableViewCell.h"

#import "QuoteNewModel.h"
#import "UIImage+OriginalImage.h"

@interface ZZHQuoteNewsVC () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *topicsArray;


@end

@implementation ZZHQuoteNewsVC

NSString *ZZHImageCellID = @"ZZHImageCell";
NSString *TimeLineID = @"TimeLine";


- (void)viewDidLoad {
    
    self.title = @"7×24快讯";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(backPreView)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //自适应高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 152;
    //注册头部轮播图cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZZHImageTableViewCell class]) bundle:nil] forCellReuseIdentifier:ZZHImageCellID];
    //注册时间线轮播图cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZZHTimeLineTableViewCell class]) bundle:nil] forCellReuseIdentifier:TimeLineID];
    
    //启用右滑返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [self getTopics];
}

-(UIView *)listView{
    return self.view;
}

-(void)backPreView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getTopics{
    WEAKSELF
    NSDate *todayDate = [NSDate date];
    NSDictionary *dic = @{@"date":todayDate};
    [ENDNetWorkManager getWithPathUrl:@"/admin/getFinanceTalk" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.topicsArray = [MTLJSONAdapter modelsOfClass:[QuoteNewModel class] fromJSONArray:result[@"data"] error:&error];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
//        [weakSelf.tableView reloadData];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求话题失败" afterHideTime:DELAYTiME];
    }];
}

#pragma mark - UITableViewViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
        return _topicsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZZHImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZZHImageCellID];
        return cell;
    }
    else {
        ZZHTimeLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TimeLineID];
        cell.quoteNewModel = self.topicsArray[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 0.01f;
}


- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = self.isTabBarHidden;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

@end
