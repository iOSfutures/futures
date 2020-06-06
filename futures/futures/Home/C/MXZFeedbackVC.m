//
//  MXZFeedbackVC.m
//  futures
//
//  Created by Francis on 2020/5/26.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZFeedbackVC.h"
#import "MXZFeedbackFirstCell.h"
#import "MXZFeedbackSecondCell.h"
#import "MXZFeedbackThirdCell.h"
#import "MXZFeedbackFourthCell.h"
#import "UIImage+OriginalImage.h"

@interface MXZFeedbackVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MXZFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(backPreView)];
    
    _tableView.scrollEnabled = NO;
    
    //注册
    [self.tableView registerClass:[MXZFeedbackFirstCell class] forCellReuseIdentifier:@"MXZFeedbackFirstCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXZFeedbackSecondCell" bundle:nil] forCellReuseIdentifier:@"MXZFeedbackSecondCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXZFeedbackThirdCell" bundle:nil] forCellReuseIdentifier:@"MXZFeedbackThirdCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXZFeedbackFourthCell" bundle:nil] forCellReuseIdentifier:@"MXZFeedbackFourthCell"];
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
    if(indexPath.section == 0){
    MXZFeedbackFirstCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MXZFeedbackFirstCell"];
    [cell.btnA setTitle:@"功能建议" forState:UIControlStateNormal];
    [cell.btnB setTitle:@"bug反馈" forState:UIControlStateNormal];
    [cell.btnC setTitle:@"其他" forState:UIControlStateNormal];
    return cell;
    }
    else if (indexPath.section == 1){
    MXZFeedbackSecondCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MXZFeedbackSecondCell"];
    return cell;
    }
    else if (indexPath.section == 2){
    MXZFeedbackThirdCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MXZFeedbackThirdCell"];
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
    else if (section == 2){
        titleLabel.text = @"我要反馈";
    }
    [headView addSubview:titleLabel];
    return headView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 3){
        return 0.0001;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}


@end
