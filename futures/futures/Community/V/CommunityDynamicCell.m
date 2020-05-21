//
//  CommunityDynamicCell.m
//  futures
//
//  Created by Ssiswent on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityDynamicCell.h"
#import "CommunityDynamicModel.h"

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

- (void)setDynamicModel:(CommunityDynamicModel *)dynamicModel
{
    _dynamicModel = dynamicModel;
    self.avatarImgView.image = [UIImage imageNamed:dynamicModel.avatarImgName];
//    self.nameLabel.text = dynamicModel.name;
    self.contentLabel.text = dynamicModel.content;
    if(dynamicModel.contentImg1Name)
    {
        self.contentImgView1.hidden = NO;
        self.contentImgView1W.constant = 345;
        self.contentImgView1H.constant = 167.5;
        self.contentImgView1.image = [UIImage imageNamed:dynamicModel.contentImg1Name];
        
        self.contentImgView1T.constant = 21.5;
        
        if(dynamicModel.contentImg2Name)
        {
            self.contentImgView1W.constant = 165;
            self.contentImgView2.hidden = NO;
            self.contentImgView2H.constant = 167.5;
            self.contentImgView2.image = [UIImage imageNamed:dynamicModel.contentImg2Name];
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
