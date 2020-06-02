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

#import "CommunityTopicModel.h"

@interface MXZHomeIndustryVC ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property (nonatomic ,copy)NSString *port;

@end

@implementation MXZHomeIndustryVC



- (void)viewDidLoad {
    
//    NSString *port = [NSString stringWithFormat:@"/admin/getFinanceAffairs?date"];
//    _port = port;
//    [self getData:_port];
    
    [self getTopics];
    
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
//    [self getData:_port];
    
    [self getTopics];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)backPreView{
    [self.navigationController popViewControllerAnimated:YES];
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
    CommunityTopicModel *tempModel = self.affairsArray[indexPath.section];
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

//#pragma mark - URLRequest
//-(void)getData:(NSString *)port{
//    WEAKSELF
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.yysc.online/%@", port]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if(error == nil){
//            //网络连接成功才执行
////            NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
//            id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//            NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:jsonObj];
//            NSArray *allArray = dict[@"data"];
//            NSMutableArray *arrayObj = [NSMutableArray array];
//            for (NSDictionary *affairDict in allArray) {
//                MXZFinanceAffairModel *affair = [[MXZFinanceAffairModel alloc]init];
//                affair.content = affairDict[@"content"];
//                [arrayObj addObject:affair];
//            }
//            weakSelf.affairsArray = arrayObj;
//        }
//    }];
//    [dataTask resume];
//}

-(void)getTopics{
    WEAKSELF
    NSDate *todayDate = [NSDate date];
    NSDictionary *dic = @{@"date":todayDate};
    [ENDNetWorkManager getWithPathUrl:@"/admin/getFinanceAffairs" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.affairsArray = [MTLJSONAdapter modelsOfClass:[CommunityTopicModel class] fromJSONArray:result[@"data"] error:&error];
        [weakSelf.tableView reloadData];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求话题失败" afterHideTime:DELAYTiME];
    }];
}

@end
