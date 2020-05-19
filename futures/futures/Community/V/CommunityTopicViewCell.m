//
//  CommunityTopicViewCell.m
//  futures
//
//  Created by Ssiswent on 2020/5/19.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityTopicViewCell.h"

@interface CommunityTopicViewCell()

@end

@implementation CommunityTopicViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _tagView.layer.cornerRadius = 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
