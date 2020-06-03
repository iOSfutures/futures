//
//  MineVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/11.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MineVC.h"
#import "MineModel.h"
#import "MXZSettingCenterVC.h"
#import "MXZMessageCenterVC.h"

#import "AttentionVC.h"

#import "MineDynamicVC.h"
#import "MineEditVC.h"

#import "MXZMessageCenterVC.h"
#import "MXZSignVC.h"

#import "UserModel.h"

#import "LoginVC.h"

@interface MineVC ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lvImgViewLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertViewLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertViewRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertImgViewLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertImgViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertImgViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertLabelLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertBtnTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertBtnBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertBtnRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *favoriteViewLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *favoriteViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fanViewRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *FavoriteImgViewLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *FavoriteLabelRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AttentionImgViewLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AttentionLabelRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *FanImgViewLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *FanLabelRight;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;

@property (weak, nonatomic) IBOutlet UIView *alertView;

@property (weak, nonatomic) IBOutlet UITableView *mineTableView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIView *AttentionView;
@property (weak, nonatomic) IBOutlet UIView *fanView;
@property (weak, nonatomic) IBOutlet UIView *favoriteView;
@property (weak, nonatomic) IBOutlet UIImageView *checkInImgView;
@property (weak, nonatomic) IBOutlet UILabel *attentionCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanCountLabel;

@property (nonatomic, strong)NSArray *mineArray;

@property (nonatomic, strong)NSNumber *userId;

@property (nonatomic, assign)BOOL hasUserId;
@end

@implementation MineVC

- (NSArray *)mineArray
{
    if(_mineArray == nil)
    {
        MineModel *taskModel = MineModel.new;
        taskModel.text = @"我的任务";
        taskModel.imageName = @"ic_my task_mine";
        MineModel *newsModel = MineModel.new;
        newsModel.text = @"消息中心";
        newsModel.imageName = @"ic_news_mine";
        MineModel *editModel = MineModel.new;
        editModel.text = @"个性编辑";
        editModel.imageName = @"ic_edit_mine";
        MineModel *dynamicModel = MineModel.new;
        dynamicModel.text = @"我的动态";
        dynamicModel.imageName = @"ic_dynamic_mine";
        MineModel *settingsModel = MineModel.new;
        settingsModel.text = @"设置";
        settingsModel.imageName = @"ic_site_mine";
        MineModel *signOutModel = MineModel.new;
        signOutModel.text = @"退出登录";
        signOutModel.imageName = @"ic_sign out_mine";
        NSMutableArray *temp = NSMutableArray.new;
        [temp addObject:taskModel];
        [temp addObject:newsModel];
        [temp addObject:editModel];
        [temp addObject:dynamicModel];
        [temp addObject:settingsModel];
        [temp addObject:signOutModel];
        _mineArray = temp;
    }
    return _mineArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getUserDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.view.backgroundColor = UIColorWithRGBA(240, 240, 240, 1);
    
    [self setConstant];
    [self changeBottomViewBg];
    [self setLayer];
    [self setGestures];
}

- (void)getUserDefault
{
    //获取用户偏好
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //读取userId
    NSNumber *userId = [userDefault objectForKey:@"userId"];
    if(userId != nil)
    {
        _userId = userId;
        _hasUserId = YES;
        [self getUser];
    }
}

- (void)setGestures
{
    [self clickFavoriteGes];
    [self clickAttentionGes];
    [self clickFanGes];
    [self clickCheckInGes1];
    [self clickCheckInGes2];
    [self clickAvatarGes];
}

 - (void)clickAvatarGes
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avatarImgViewClicked)];
    [_avatarImgView addGestureRecognizer:tap];
}

- (void)avatarImgViewClicked
{
    if(_hasUserId)
    {
        MineDynamicVC *mineDynamicVC = MineDynamicVC.new;
        [self.navigationController pushViewController:mineDynamicVC animated:YES];
    }
    else
    {
        LoginVC *loginVC = [LoginVC new];
        [self.navigationController pushViewController:loginVC animated:YES];
        [Toast makeText:loginVC.view Message:@"请先注册或登录" afterHideTime:DELAYTiME];
    }
    
}

- (void)clickAttentionGes {
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAttentionGes:)];
    [self.AttentionView addGestureRecognizer:tap];
}

- (void)clickAttentionGes: (UITapGestureRecognizer *)tap {
    if(_hasUserId)
    {
        AttentionVC *attentionVC = [[AttentionVC alloc] init];
        attentionVC.titleStr = @"wo的关注";
        attentionVC.followsOrFans = @"follows";
        if (tap > 0) {
            [self.navigationController pushViewController:attentionVC animated:YES];
        }
    }
    else
    {
        LoginVC *loginVC = [LoginVC new];
        [self.navigationController pushViewController:loginVC animated:YES];
        [Toast makeText:loginVC.view Message:@"请先注册或登录" afterHideTime:DELAYTiME];
    }
}

- (void)clickFanGes {
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFanGes:)];
    [self.fanView addGestureRecognizer:tap];
}

- (void)clickFanGes: (UITapGestureRecognizer *)tap {
    if(_hasUserId)
    {
        AttentionVC *attentionVC = [[AttentionVC alloc] init];
        attentionVC.titleStr = @"wo的粉丝";
        attentionVC.followsOrFans = @"Fans";
        if (tap > 0) {
            [self.navigationController pushViewController:attentionVC animated:YES];
        }
    }
    else
    {
        LoginVC *loginVC = [LoginVC new];
        [self.navigationController pushViewController:loginVC animated:YES];
        [Toast makeText:loginVC.view Message:@"请先注册或登录" afterHideTime:DELAYTiME];
    }
}

- (void)clickFavoriteGes {
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFavoriteGes:)];
    [self.favoriteView addGestureRecognizer:tap];
}

- (void)clickFavoriteGes: (UITapGestureRecognizer *)tap {
    if(_hasUserId)
    {
        MXZMessageCenterVC *favoriteVC = [[MXZMessageCenterVC alloc] init];
        favoriteVC.labelStr = @"暂无收藏";
        favoriteVC.titleStr = @"我的收藏";
        if (tap > 0) {
            [self.navigationController pushViewController:favoriteVC animated:YES];
        }
    }
    else
    {
        LoginVC *loginVC = [LoginVC new];
        [self.navigationController pushViewController:loginVC animated:YES];
        [Toast makeText:loginVC.view Message:@"请先注册或登录" afterHideTime:DELAYTiME];
    }
}

- (void)clickCheckInGes1 {
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCheckInGes:)];
    [self.checkInImgView addGestureRecognizer:tap];
}

- (void)clickCheckInGes2 {
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCheckInGes:)];
    [self.alertView addGestureRecognizer:tap];
}

- (void)clickCheckInGes: (UITapGestureRecognizer *)tap {
    if(_hasUserId)
    {
        MXZSignVC *signVC = MXZSignVC.new;
        [self.navigationController pushViewController:signVC animated:YES];
    }
    else
    {
        LoginVC *loginVC = [LoginVC new];
        [self.navigationController pushViewController:loginVC animated:YES];
        [Toast makeText:loginVC.view Message:@"请先注册或登录" afterHideTime:DELAYTiME];
    }
}

- (void)setLayer
{
    CGFloat avatarImgViewHeight = kScaleFrom_iPhone8_Height(45);
    _avatarImgView.layer.cornerRadius = avatarImgViewHeight/2;
    _avatarImgView.layer.masksToBounds = YES;
    
    CGFloat alertViewHeight = kScaleFrom_iPhone8_Height(24);
    _alertView.layer.cornerRadius = alertViewHeight/2;
    _alertView.layer.masksToBounds = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 3;
    }
    else if(section == 1)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = UITableViewCell.new;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.section == 0)
    {
        MineModel *mineModel = self.mineArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:mineModel.imageName];
        cell.textLabel.text = mineModel.text;
    }
    else if(indexPath.section == 1)
    {
        MineModel *mineModel = self.mineArray[indexPath.row + 3];
        cell.imageView.image = [UIImage imageNamed:mineModel.imageName];
        cell.textLabel.text = mineModel.text;
    }
    else
    {
        MineModel *mineModel = self.mineArray[indexPath.row + 5];
        cell.imageView.image = [UIImage imageNamed:mineModel.imageName];
        cell.textLabel.text = mineModel.text;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = UIView.new;
    footerView.backgroundColor = UIColorWithRGBA(240, 240, 240, 1);
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kScaleFrom_iPhone8_Height(15);
}

- (void)setConstant
{
    _avatarH.constant = kScaleFrom_iPhone8_Height(45);
    _avatarLeft.constant = kScaleFrom_iPhone8_Width(15);
    _avatarTop.constant = kScaleFrom_iPhone8_Height(53.5);
    _nameLabelLeft.constant = kScaleFrom_iPhone8_Width(81);
    _lvImgViewLeft.constant = kScaleFrom_iPhone8_Width(8.5);
    _alertViewLeft.constant = kScaleFrom_iPhone8_Width(20);
    _alertViewRight.constant = kScaleFrom_iPhone8_Width(20);
    _alertViewTop.constant = kScaleFrom_iPhone8_Height(135);
    _alertImgViewLeft.constant = kScaleFrom_iPhone8_Width(10);
    _alertImgViewTop.constant = kScaleFrom_iPhone8_Height(5);
    _alertImgViewBottom.constant = kScaleFrom_iPhone8_Height(5);
    _alertLabelLeft.constant = kScaleFrom_iPhone8_Width(34.5);
    _alertBtnTop.constant = kScaleFrom_iPhone8_Height(5);
    _alertBtnBottom.constant = kScaleFrom_iPhone8_Height(5);
    _alertBtnRight.constant = kScaleFrom_iPhone8_Width(10);
    _favoriteViewLeft.constant = kScaleFrom_iPhone8_Width(15.5);
    _favoriteViewBottom.constant = kScaleFrom_iPhone8_Height(26);
    _fanViewRight.constant = kScaleFrom_iPhone8_Width(15.5);
    if(SCREEN_WIDTH == 414)
    {
        _FavoriteImgViewLeft.constant = 8;
        _FavoriteLabelRight.constant = 8;
        _AttentionImgViewLeft.constant = 10;
        _AttentionLabelRight.constant = 10;
        _FanImgViewLeft.constant = 11;
        _FanLabelRight.constant = 11;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.tabBarController.tabBar.frame;
        if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667)
        {
            frame.origin.y = 593;
        }
        else if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812)
        {
            frame.origin.y = 742;
        }
        else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 736)
        {
            frame.origin.y = 662;
        }
        else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 896)
        {
            frame.origin.y = 816;
        }
        self.tabBarController.tabBar.frame = frame;
        self.navigationController.navigationBar.backgroundColor = UIColorWithRGBA(254, 162, 3, 0);
        self.tabBarController.tabBar.hidden = NO;
    }];
    [self getUserDefault];
}

- (void)changeBottomViewBg
{
    UIColor *bgColor = UIColor.new;
    if(SCREEN_WIDTH == 414)
    {
        bgColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
    else if(SCREEN_WIDTH == 375)
    {
        bgColor = [UIColor colorWithHexString:@"#F0F0F0"];
    }
    self.bottomView.backgroundColor = bgColor;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1) {
        MXZSettingCenterVC *settingVC = [[MXZSettingCenterVC alloc]init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
    else if (indexPath.item == 1){
        MXZMessageCenterVC *messageVC = [[MXZMessageCenterVC alloc]init];
        messageVC.labelStr = @"暂无消息";
        messageVC.titleStr = @"消息中心";
        [self.navigationController pushViewController:messageVC animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 0) {
        if(_hasUserId)
        {
            MineDynamicVC *mineDynamicVC = MineDynamicVC.new;
            [self.navigationController pushViewController:mineDynamicVC animated:YES];
        }
        else
        {
            LoginVC *loginVC = [LoginVC new];
            [self.navigationController pushViewController:loginVC animated:YES];
            [Toast makeText:loginVC.view Message:@"请先注册或登录" afterHideTime:DELAYTiME];
        }
    }
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
//        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求用户数据失败" afterHideTime:DELAYTiME];
    }];
}

@end
