//
//  PublishVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/11.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "PublishVC.h"
#import "MXZFeedbackFirstCell.h"
#import "MXZFeedbackSecondCell.h"
#import "MXZFeedbackFourthCell.h"

@interface PublishVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    
    self.navigationItem.title = @"发布说说";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _tableView.scrollEnabled = NO;
    //注册
    [self.tableView registerClass:[MXZFeedbackFirstCell class] forCellReuseIdentifier:@"MXZFeedbackFirstCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXZFeedbackSecondCell" bundle:nil] forCellReuseIdentifier:@"MXZFeedbackSecondCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXZFeedbackFourthCell" bundle:nil] forCellReuseIdentifier:@"MXZFeedbackFourthCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
    MXZFeedbackFirstCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MXZFeedbackFirstCell"];
    [cell.btnA setTitle:@"生活小方针" forState:UIControlStateNormal];
    [cell.btnB setTitle:@"财经顾问" forState:UIControlStateNormal];
    [cell.btnC setTitle:@"周边爆料" forState:UIControlStateNormal];
    return cell;
    }
    else if (indexPath.section == 1){
    MXZFeedbackSecondCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MXZFeedbackSecondCell"];
    return cell;
    }
    MXZFeedbackFourthCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MXZFeedbackFourthCell"];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 60)];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 25, 70, 15)];
    //设置字体大小和字重
    titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    if(section == 0){
        titleLabel.text = @"分类标签";
    }
    else if (section == 1){
        titleLabel.text = @"我要反馈";
    }
    [headView addSubview:titleLabel];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
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
