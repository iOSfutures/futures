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

@interface AttentionVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AttentionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"wo的关注";
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:254/255.0 green:162/255.0 blue:3/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //设置左右图片,图片会被系统渲染为蓝色
    /*
        设置左右按钮为图片按钮
    */
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setImage:[UIImage imageNamed:@"ic_back_black"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"ic_back_black"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    //按钮自适应
    [btn sizeToFit];
    //设置左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)leftClick {
    MineVC *vc = self.navigationController.childViewControllers[0];
    [self.navigationController popToViewController:vc animated:YES];
}

#pragma mark - UITableViewViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Attention";
    AttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AttentionTableViewCell" owner:self options:nil]lastObject];
    }
    return cell;
}


@end
