//
//  MineVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/11.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MineVC.h"

@interface MineVC ()
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

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
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
    
    CGFloat avatarImgViewHeight = kScaleFrom_iPhone8_Height(45);
    _avatarImgView.layer.cornerRadius = avatarImgViewHeight/2;
    
    CGFloat alertViewHeight = kScaleFrom_iPhone8_Height(24);
    _alertView.layer.cornerRadius = alertViewHeight/2;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
