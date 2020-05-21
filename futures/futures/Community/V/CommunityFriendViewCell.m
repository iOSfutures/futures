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

- (void)setFriendModel:(CommunityFriendModel *)friendModel
{
    _friendModel = friendModel;
    self.avatarImgView.image = [UIImage imageNamed:friendModel.avatarImgName];
    self.nameLabel.text = friendModel.name;
    self.descriptionLabel.text = friendModel.descript;
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
