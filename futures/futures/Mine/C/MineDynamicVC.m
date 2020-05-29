//
//  MineDynamicVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/21.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MineDynamicVC.h"
#import "UIImage+OriginalImage.h"

#import "CommunityDynamicCell.h"
#import "CommunityDynamicModel.h"
#import "MineEditVC.h"

#define oriOffsetY -335.5
#define oriH 293

@interface MineDynamicVC ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UIButton *newsBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *dynamicBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UITableView *dynamicTableView;

@property (strong , nonatomic) NSArray *dynamicsArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintH;

@property (nonatomic, strong) UIView *customizedStatusBar;

@end

@implementation MineDynamicVC

NSString *DynamicCell3 = @"DynamicCell3";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back "] style:0 target:self action:@selector(backBtnClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_share it_homepage"] style:0 target:self action:nil];
    
    
    _newsBtn.adjustsImageWhenHighlighted = NO;
    _editBtn.adjustsImageWhenHighlighted = NO;
    _dynamicBtn.adjustsImageWhenHighlighted = NO;
    _likeBtn.adjustsImageWhenHighlighted = NO;
    
    [self.dynamicTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityDynamicCell class]) bundle:nil]forCellReuseIdentifier:DynamicCell3];
    
    [self setLayer];
    [self setFadeStyle];
    
    //启用右滑返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)backBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dynamicsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicCell3];
    cell.dynamicModel = self.dynamicsArray[indexPath.row];
    return cell;
}

- (void)setLayer
{
    _avatarImgView.layer.cornerRadius = CGRectGetWidth(_avatarImgView.frame)/2;
    _avatarImgView.layer.masksToBounds = YES;
    
    _newsBtn.layer.borderWidth = 1;
    _newsBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _newsBtn.layer.cornerRadius = 3;
    _newsBtn.layer.masksToBounds = YES;
    
    _editBtn.layer.borderWidth = 1;
    _editBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _editBtn.layer.cornerRadius = 3;
    _editBtn.layer.masksToBounds = YES;
}

- (void)setFadeStyle
{
    self.dynamicTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.dynamicTableView.contentInset = UIEdgeInsetsMake(335.5, 0, 0, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y - oriOffsetY;
    CGFloat h = oriH - offset;
    if (h <= 64) {
        h = 64;
    }
    self.constraintH.constant = h;
}

- (IBAction)editBtnClicked:(id)sender {
    MineEditVC *mineEditVC = MineEditVC.new;
    [self.navigationController pushViewController:mineEditVC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = 667;
        self.tabBarController.tabBar.frame = frame;
        self.navigationController.navigationBar.backgroundColor = UIColorWithRGBA(254, 162, 3, 1);
    }];
}

@end
