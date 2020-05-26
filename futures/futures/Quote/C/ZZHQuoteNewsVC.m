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

@interface ZZHQuoteNewsVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;


@end

@implementation ZZHQuoteNewsVC

NSString *ZZHCollectionCellID = @"ZZHCollectionCell";
NSString *ZZHImageCellID = @"ZZHImageCell";
NSString *ID = @"TimeLine";


- (void)viewDidLoad {
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZZHTimeLineTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
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
    
    if(indexPath.row == 0)
    {
        ZZHImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZZHImageCellID];
        return cell;
    }else {
        ZZHTimeLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

        if (indexPath.row == 1) {
               cell.topLine.hidden = YES;
           }
        return cell;
    }
}

//禁止下拉,允许上拉
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.tableView.contentOffset.y > 0) {
        self.tableView.bounces = YES;
    } else if (self.tableView.contentOffset.y < 0) {
        self.tableView.bounces = NO;
    }
}

@end
