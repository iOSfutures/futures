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

@interface MineVC ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarTop;
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
@property (weak, nonatomic) IBOutlet UIView *alertView;

@property (weak, nonatomic) IBOutlet UITableView *mineTableView;

@property (nonatomic, strong)NSArray *mineArray;

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
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self setConstant];
    
    CGFloat avatarImgViewHeight = kScaleFrom_iPhone8_Height(45);
    _avatarImgView.layer.cornerRadius = avatarImgViewHeight/2;
    
    CGFloat alertViewHeight = kScaleFrom_iPhone8_Height(24);
    _alertView.layer.cornerRadius = alertViewHeight/2;
    
    self.view.backgroundColor = UIColorWithRGBA(240, 240, 240, 1);
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
    _avatarLeft.constant = kScaleFrom_iPhone8_Width(15);
    _avatarTop.constant = kScaleFrom_iPhone8_Height(53.5);
    _nameLabelLeft.constant = kScaleFrom_iPhone8_Width(81);
    _lvImgViewLeft.constant = kScaleFrom_iPhone8_Width(235);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1) {
        MXZSettingCenterVC *settingVC = [[MXZSettingCenterVC alloc]init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
    else if (indexPath.item == 1){
        MXZMessageCenterVC *messageVC = [[MXZMessageCenterVC alloc]init];
        [self.navigationController pushViewController:messageVC animated:YES];
    }
}

@end
