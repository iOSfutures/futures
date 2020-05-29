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

#import "UIColor+Hex.h"
#import "UIImage+OriginalImage.h"

@interface ZZHQuoteCalendarVC () <UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *weekDayArray;
// 数据数组
@property (nonatomic, strong) NSMutableArray *dataArray;

@end



@implementation ZZHQuoteCalendarVC

NSString *CollectionTableViewID = @"collectionView";

NSString *TableViewID = @"TableView";

- (void)viewDidLoad {
    
    self.title = @"日历数据";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(backPreView)];
    
    _weekDayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        ZZHDateHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionTableViewID];
        return cell;
    } else {
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
        return cell;
    }
}

@end
