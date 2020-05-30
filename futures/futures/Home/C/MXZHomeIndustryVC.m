//
//  HomeIndustryVC.m
//  futures
//
//  Created by Francis on 2020/5/12.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZHomeIndustryVC.h"
#import "MXZIndustryTableViewCell.h"
#import "UIImage+OriginalImage.h"

@interface MXZHomeIndustryVC ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MXZHomeIndustryVC

- (void)viewDidLoad {
    self.navigationItem.title = @"行业风暴";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"MXZIndustryTableViewCell" bundle:nil] forCellReuseIdentifier:@"MXZIndustryTableViewCell"];
//    self.tableView.estimatedRowHeight = 171;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(backPreView)];
    
    //启用右滑返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (UIView *)listView
{
    return self.view;
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

-(void)backPreView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setAffairsArray:(NSArray *)affairsArray{
    _affairsArray = affairsArray;
}
#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.affairsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MXZIndustryTableViewCell";
    MXZIndustryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[MXZIndustryTableViewCell alloc]init];
    }
    MXZFinanceAffairModel *tempModel = self.affairsArray[indexPath.section];
    cell.contentLabel.text = tempModel.content;

    switch (indexPath.section) {
        case 1:
            cell.subtitleLabel.text = @"HOT";
            break;
        case 2:
            cell.kindLabel.text = @"财经日报";
            cell.timeLabel.text = @"12分钟前";
            cell.nonSubtitle = YES;
            break;
        case 3:
            cell.kindLabel.text = @"理财专栏";
            cell.timeLabel.text = @"昨天";
            cell.nonSubtitle = YES;
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

@end
