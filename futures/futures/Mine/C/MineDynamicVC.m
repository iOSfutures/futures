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
#import "AttentionVC.h"
#import "MXZMessageCenterVC.h"

#import "UserModel.h"

#define oriOffsetY -335.5
#define oriH 293

@interface MineDynamicVC ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;

@property (weak, nonatomic) IBOutlet UIButton *newsBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *dynamicBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UITableView *dynamicTableView;

@property (weak, nonatomic) IBOutlet UILabel *attentionCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanCountLabel;

@property (weak, nonatomic) IBOutlet UIView *AttentionView;
@property (weak, nonatomic) IBOutlet UIView *favoriteView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintH;

@property (strong , nonatomic) NSArray *dynamicsArray;

@property (nonatomic, strong)UserModel *user;

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
    
//    [self setHeaderView];
    
    [self setLayer];
    [self setFadeStyle];
    
    [self clickAttentionGes];
    [self clickFavoriteGes];
    
//    _user = UserModel.new;
//    _user.userId = @155;
    [self getUser];
    [self getDynamics];
    
    //启用右滑返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)clickAttentionGes {
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAttentionGes:)];
    [self.AttentionView addGestureRecognizer:tap];
}

- (void)clickAttentionGes: (UITapGestureRecognizer *)tap {
    AttentionVC *attentionVC = [[AttentionVC alloc] init];
    if (tap > 0) {
        [self.navigationController pushViewController:attentionVC animated:YES];
    }
}

- (void)clickFavoriteGes {
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFavoriteGes:)];
    [self.favoriteView addGestureRecognizer:tap];
}

- (void)clickFavoriteGes: (UITapGestureRecognizer *)tap {
    MXZMessageCenterVC *favoriteVC = [[MXZMessageCenterVC alloc] init];
    favoriteVC.labelStr = @"暂无收藏";
    favoriteVC.titleStr = @"我的收藏";
    if (tap > 0) {
        [self.navigationController pushViewController:favoriteVC animated:YES];
    }
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
    mineEditVC.user = _user;
    [self.navigationController pushViewController:mineEditVC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.tabBarController.tabBar.frame;
        if(SCREEN_WIDTH == 375)
        {
            frame.origin.y = 667;
        }
        else if (SCREEN_WIDTH == 414)
        {
            frame.origin.y = 896;
        }
        self.tabBarController.tabBar.frame = frame;
        self.navigationController.navigationBar.backgroundColor = UIColorWithRGBA(254, 162, 3, 1);
    }];
    
    [self getUser];
}

//- (void)setHeaderView
//{
//    _attentionCountLabel.text = [NSString stringWithFormat:@"%d",_user.followCount.intValue];
//    _fanCountLabel.text = [NSString stringWithFormat:@"%d",_user.fansCount.intValue];
//    [_avatarImgView sd_setImageWithURL:[NSURL URLWithString:_user.head]
//    placeholderImage:[UIImage imageNamed:@"wallhaven-oxv6gl"]];
//    _nameLabel.text = _user.nickName;
//    _signatureLabel.text = _user.signature;
//}

-(void)getDynamics{
    WEAKSELF
    NSDictionary *dic = @{@"_orderByDesc":@"publishTime",@"userId":@155};
    [ENDNetWorkManager postWithPathUrl:[NSString stringWithFormat:@"/user/talk/getTalkList/%d",_user.userId.intValue] parameters:dic queryParams:nil Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.dynamicsArray = [MTLJSONAdapter modelsOfClass:[CommunityDynamicModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
        [weakSelf.dynamicTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求用户说说失败" afterHideTime:DELAYTiME];
    }];
}

-(void)getUser{
    WEAKSELF
    NSDictionary *dic = @{@"userId":@155};
    [ENDNetWorkManager postWithPathUrl:@"/user/personal/queryUser" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        UserModel *user = [MTLJSONAdapter modelOfClass:[UserModel class] fromJSONDictionary:result[@"data"] error:&error];
        weakSelf.attentionCountLabel.text = [NSString stringWithFormat:@"%d",user.followCount.intValue];
        weakSelf.fanCountLabel.text = [NSString stringWithFormat:@"%d",user.fansCount.intValue];
        [weakSelf.avatarImgView sd_setImageWithURL:[NSURL URLWithString:user.head]
        placeholderImage:[UIImage imageNamed:@"wallhaven-oxv6gl"]];
        weakSelf.nameLabel.text = user.nickName;
        weakSelf.signatureLabel.text = user.signature;
        weakSelf.user = user;
//        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求用户数据失败" afterHideTime:DELAYTiME];
    }];
}

@end
