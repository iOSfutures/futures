//
//  CommunityTopicViewCell.h
//  futures
//
//  Created by Ssiswent on 2020/5/19.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CommunityTopicModel;

@interface CommunityTopicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topicImgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@property (strong, nonatomic) CommunityTopicModel *communityTopicModel;

@end

NS_ASSUME_NONNULL_END
