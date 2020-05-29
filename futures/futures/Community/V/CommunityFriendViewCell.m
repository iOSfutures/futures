//
//  CommunityFriendViewCell.m
//  futures
//
//  Created by Ssiswent on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityFriendViewCell.h"
#import "CommunityFriendModel.h"

@implementation CommunityFriendViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _avatarImgView.layer.cornerRadius = 31;
    _avatarImgView.layer.masksToBounds = YES;
}

- (void)setFriendModel:(CommunityFriendModel *)friendModel
{
    _friendModel = friendModel;
    [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:friendModel.head]
    placeholderImage:[UIImage imageNamed:@"user_hot_community"]];
    self.nameLabel.text = friendModel.nickName;
    self.descriptionLabel.text = friendModel.signature;
    if(friendModel.isFollowed == YES)
    {
        [self.followBtn setImage:[UIImage imageNamed:@"ic_followed"] forState:UIControlStateNormal];
    }
    else if(friendModel.isFollowed == NO)
    {
        [self.followBtn setImage:[UIImage imageNamed:@"ic_follow"] forState:UIControlStateNormal];
    }
}

- (IBAction)followBtnClicked:(id)sender {
    self.friendModel.followed = !self.friendModel.followed;
    if(self.friendModel.isFollowed == YES)
    {
        [self.followBtn setImage:[UIImage imageNamed:@"ic_followed"] forState:UIControlStateNormal];
    }
    else if(self.friendModel.isFollowed == NO)
    {
        [self.followBtn setImage:[UIImage imageNamed:@"ic_follow"] forState:UIControlStateNormal];
    }

    if([self.delegate respondsToSelector:@selector(communityFriendViewCellDidClickFollowBtn:)])
    {
        [self.delegate communityFriendViewCellDidClickFollowBtn:self];
    }
}

@end
