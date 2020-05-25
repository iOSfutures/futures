//
//  HomeIndustryVC.m
//  futures
//
//  Created by Francis on 2020/5/12.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZHomeIndustryVC.h"
#import "MXZIndustryTableViewCell.h"

@interface MXZHomeIndustryVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MXZHomeIndustryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"行业风暴";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"MXZIndustryTableViewCell" bundle:nil] forCellReuseIdentifier:@"MXZIndustryTableViewCell"];
//    self.tableView.estimatedRowHeight = 171;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
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
        cell = [[NSBundle mainBundle] loadNibNamed:@"MXZIndustryTableViewCell" owner:self options:nil].firstObject;
    }
    switch (indexPath.section) {
        case 1:
            cell.kindLabel.backgroundColor = [UIColor colorWithRed:119/255.0 green:193/255.0 blue:22/255.0 alpha:1.0];
            cell.subtitleLabel.text = @"HOT";
            cell.subtitleLabel.backgroundColor =[UIColor colorWithRed:254/255.0 green:198/255.0 blue:3/255.0 alpha:1.0];
            break;
        case 2:
            cell.kindLabel.text = @"财经日报";
            cell.kindLabel.backgroundColor = [UIColor colorWithRed:230/255.0 green:75/255.0 blue:122/255.0 alpha:1.0];
            cell.timeLabel.text = @"12分钟前";
            cell.subtitleLabel.hidden = YES;
            cell.nonSubtitle = YES;
            break;
        case 3:
            cell.kindLabel.text = @"理财专栏";
            cell.kindLabel.backgroundColor = [UIColor colorWithRed:49/255.0 green:120/255.0 blue:221/255.0 alpha:1.0];
            cell.timeLabel.text = @"昨天";
            cell.subtitleLabel.hidden = YES;
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
