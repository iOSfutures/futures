//
//  CommunityFriendViewCell.h
//  futures
//
//  Created by Ssiswent on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CommunityFriendModel, CommunityFriendViewCell;

@protocol CommunityFriendViewCellDelegate <NSObject>

@optional

- (void)communityFriendViewCellDidClickFollowBtn:(CommunityFriendViewCell *)cell;

@end

@interface CommunityFriendViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;

@property (nonatomic, strong)CommunityFriendModel *friendModel;

@property (nonatomic, weak)id<CommunityFriendViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
