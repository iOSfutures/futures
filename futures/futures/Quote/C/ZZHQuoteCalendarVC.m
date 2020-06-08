//
//  QuoteCalendarVC.m
//  futures
//
//  Created by apple on 2020/5/14.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "ZZHQuoteCalendarVC.h"

#import "ZZHDateTableViewCell.h"
#import "ZZHDateHeadCell.h"
#import "QuoteCalendarModel.h"

#import "UIColor+Hex.h"
#import "UIImage+OriginalImage.h"


@interface ZZHQuoteCalendarVC () <UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *calendarArray;

@end



@implementation ZZHQuoteCalendarVC

NSString *CollectionTableViewID = @"collectionView";

NSString *TableViewID = @"TableView";

- (void)viewDidLoad {
    
    self.title = @"日历数据";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(backPreView)];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZZHDateHeadCell class]) bundle:nil] forCellReuseIdentifier:CollectionTableViewID];

    //注册tableView cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZZHDateTableViewCell class]) bundle:nil] forCellReuseIdentifier:TableViewID];
    
    //设置分割线:对tableView的separatorInset, layoutMargins属性的设置
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            self.tableView.separatorInset = UIEdgeInsetsZero;
        }

    
    //自适应高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    //启用右滑返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

//    NSDate *todayDate = [NSDate date];
//    NSLog(@"!!!!!!%@",todayDate);
    
    [self getCanlendar];
}

//请求数据
- (void)getCanlendar {
    WEAKSELF
    NSDate *todayDate = [NSDate date];
    NSDictionary *dic = @{@"date":todayDate};
    [ENDNetWorkManager getWithPathUrl:@"/admin/getFinanceCalender" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.calendarArray = [MTLJSONAdapter modelsOfClass:[QuoteCalendarModel class] fromJSONArray:result[@"data"] error:&error];
        //刷新第2个section
//        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf.tableView reloadData];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求失败" afterHideTime:DELAYTiME];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = self.tabBarHidden;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)backPreView{
    [self.navigationController popViewControllerAnimated:YES];
}


-(UIView *)listView{
    return self.view;
}

#pragma mark - UITableViewViewDataSource
-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    return _calendarArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        ZZHDateHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionTableViewID];
        return cell;
    }
    else {
        ZZHDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewID];
        //对cell的LayoutMargins属性的设置
        //2.调整(iOS8以上)tableView边距
            if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
                cell.preservesSuperviewLayoutMargins = NO;
            }
           //3.调整(iOS8以上)view边距
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:UIEdgeInsetsZero];
            }
        cell.calendarModel = self.calendarArray[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 132;
    }
    else
        return UITableViewAutomaticDimension;
}

@end
