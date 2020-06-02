//
//  CommunityDynamicCell.m
//  futures
//
//  Created by Ssiswent on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityDynamicCell.h"
#import "CommunityDynamicModel.h"
#import "UserModel.h"

@interface CommunityDynamicCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImgView1;
@property (weak, nonatomic) IBOutlet UIImageView *contentImgView2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImgView1H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImgView2H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImgView1W;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImgView1T;

@end

@implementation CommunityDynamicCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _avatarImgView.layer.cornerRadius = 21;
    _avatarImgView.layer.masksToBounds = YES;
    
    _contentImgView1.layer.cornerRadius = 6;
    _contentImgView1.layer.masksToBounds = YES;
    
    _contentImgView2.layer.cornerRadius = 6;
    _contentImgView2.layer.masksToBounds = YES;
}

- (void)setDynamicModel:(CommunityDynamicModel *)dynamicModel
{
    _dynamicModel = dynamicModel;
    
    UserModel *userModel = dynamicModel.user;
    
    [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:userModel.head]
    placeholderImage:[UIImage imageNamed:@"user_hot chat_community"]];
    self.nameLabel.text = userModel.nickName;
    self.contentLabel.text = dynamicModel.content;
    if(dynamicModel.picture1)
    {
        self.contentImgView1.hidden = NO;
        self.contentImgView1W.constant = kScaleFrom_iPhone8_Width(345);
        self.contentImgView1H.constant = 167.5;
        [self.contentImgView1 sd_setImageWithURL:[NSURL URLWithString:dynamicModel.picture1]
        placeholderImage:[UIImage imageNamed:@"talk about_banner01_community"]];
        
        self.contentImgView1T.constant = 21.5;
        
        if(dynamicModel.picture2)
        {
            self.contentImgView1W.constant = kScaleFrom_iPhone8_Width(165);
            self.contentImgView2.hidden = NO;
            self.contentImgView2H.constant = 167.5;
            [self.contentImgView2 sd_setImageWithURL:[NSURL URLWithString:dynamicModel.picture2]
            placeholderImage:[UIImage imageNamed:@"talk about_banner03_community"]];
        }
        else
        {
            self.contentImgView2.hidden = YES;
            self.contentImgView2H.constant = 0;
        }
    }
    else
    {
        self.contentImgView1.hidden = YES;
        self.contentImgView2.hidden = YES;
        self.contentImgView1H.constant = 0;
        self.contentImgView2H.constant = 0;
        
        self.contentImgView1T.constant = 0;
    }
}

@end
