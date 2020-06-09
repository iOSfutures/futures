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

#import "MXZRecommandTalkModel.h"
#import "MXZFullDisplay.h"

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
@property (weak, nonatomic) IBOutlet UIView *fanView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintH;

@property (strong , nonatomic) NSMutableArray *dynamicsArray;

@property (strong, nonatomic)UserModel *user;

@property (nonatomic, strong)NSNumber *userId;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImgViewBottom;

@end

@implementation MineDynamicVC

NSString *DynamicCell3 = @"DynamicCell3";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getUserDefault];
    
    CGFloat bottomConstant = 132;
    
    if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667)
    {
        bottomConstant = 132;
    }
    else if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812)
    {
        bottomConstant = 115;
    }
    else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 736)
    {
        bottomConstant = 132;
    }
    else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 896)
    {
        bottomConstant = 110;
    }
    
    _avatarImgViewBottom.constant = bottomConstant;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back "] style:0 target:self action:@selector(backBtnClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_share it_homepage"] style:0 target:self action:nil];
    
    
    _newsBtn.adjustsImageWhenHighlighted = NO;
    _editBtn.adjustsImageWhenHighlighted = NO;
    _dynamicBtn.adjustsImageWhenHighlighted = NO;
    _likeBtn.adjustsImageWhenHighlighted = NO;
    
    [self.dynamicTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityDynamicCell class]) bundle:nil]forCellReuseIdentifier:DynamicCell3];
    
    
    [self setLayer];
    [self setContentInset];
    
    [self clickAttentionGes];
    [self clickFavoriteGes];
    [self clickFanGes];
    
    [self getUser];
    [self getDynamics];
    
    //启用右滑返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)getUserDefault
{
    //获取用户偏好
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //读取userId
    NSNumber *userId = [userDefault objectForKey:@"userId"];
    _userId = userId;
}

- (void)clickAttentionGes {
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAttentionGes:)];
    [self.AttentionView addGestureRecognizer:tap];
}

- (void)clickAttentionGes: (UITapGestureRecognizer *)tap {
    AttentionVC *attentionVC = [[AttentionVC alloc] init];
    attentionVC.titleStr = @"wo的关注";
    attentionVC.followsOrFans = @"follows";
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

- (void)clickFanGes {
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFanGes:)];
    [self.fanView addGestureRecognizer:tap];
}

- (void)clickFanGes: (UITapGestureRecognizer *)tap {
    AttentionVC *attentionVC = [[AttentionVC alloc] init];
    attentionVC.titleStr = @"wo的粉丝";
    attentionVC.followsOrFans = @"Fans";
    if (tap > 0) {
        [self.navigationController pushViewController:attentionVC animated:YES];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityDynamicModel *model = _dynamicsArray[indexPath.row];
    MXZRecommandTalkModel *mxzModel = MXZRecommandTalkModel.new;
    mxzModel.content = model.content;
    mxzModel.picture = model.picture1;
    mxzModel.user = model.user;
    mxzModel.recommandCount = indexPath.row%5;
    MXZFullDisplay *vc = MXZFullDisplay.new;
    vc.cellNum = indexPath.row;
    vc.recommandModel = mxzModel;
    vc.rightBarBtnHidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
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

- (void)setContentInset
{
    if (@available(iOS 11.0, *)) {
        self.dynamicTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
    
    [self getUserDefault];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.tabBarController.tabBar.frame;
        if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667)
        {
            frame.origin.y = 700;
        }
        else if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812)
        {
            frame.origin.y = 900;
        }
        else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 736)
        {
            frame.origin.y = 800;
        }
        else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 896)
        {
            frame.origin.y = 1000;
        }
        self.tabBarController.tabBar.frame = frame;
        self.navigationController.navigationBar.backgroundColor = UIColorWithRGBA(254, 162, 3, 1);
    }];
    
    [self getUser];
}

-(void)getDynamics{
    WEAKSELF
    
    NSDictionary *dic = @{@"_orderByDesc":@"publishTime",@"userId":_userId};
    //    [NSString stringWithFormat:@"/user/talk/getTalkList/%d",_user.userId.intValue]
    [ENDNetWorkManager postWithPathUrl:@"/user/talk/getTalkList/155" parameters:dic queryParams:nil Header:nil success:^(BOOL success, id result) {
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
    NSDictionary *dic = @{@"userId":_userId};
    [ENDNetWorkManager postWithPathUrl:@"/user/personal/queryUser" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        UserModel *user = [MTLJSONAdapter modelOfClass:[UserModel class] fromJSONDictionary:result[@"data"] error:&error];
        weakSelf.attentionCountLabel.text = [NSString stringWithFormat:@"%d",user.followCount.intValue];
        weakSelf.fanCountLabel.text = [NSString stringWithFormat:@"%d",user.fansCount.intValue];
        [weakSelf.avatarImgView sd_setImageWithURL:[NSURL URLWithString:user.head]
                                  placeholderImage:[UIImage imageNamed:@"wallhaven-oxv6gl"]];
        weakSelf.nameLabel.text = user.nickName;
        if([user.signature isEqualToString:@""])
        {
            weakSelf.signatureLabel.text = @"这个人太懒了，什么都没留...";
        }
        else
        {
            weakSelf.signatureLabel.text = user.signature;
        }
        weakSelf.user = user;
        //        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求用户数据失败" afterHideTime:DELAYTiME];
    }];
}

@end
