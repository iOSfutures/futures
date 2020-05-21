//
//  CommunityTopicViewCell.m
//  futures
//
//  Created by Ssiswent on 2020/5/19.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityTopicCell.h"
#import "CommunityTopicModel.h"

@interface CommunityTopicCell()

@end

@implementation CommunityTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _tagView.layer.cornerRadius = 8;
}

- (void)setCommunityTopicModel:(CommunityTopicModel *)communityTopicModel
{
    _communityTopicModel = communityTopicModel;
    self.contentLabel.text = communityTopicModel.content;
    self.topicImgView.image = [UIImage imageNamed:communityTopicModel.imageName];
}

@end
