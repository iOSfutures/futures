//
//  MXZFullFourthSectionCell.m
//  futures
//
//  Created by Francis on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZFullFourthSectionCell.h"

@implementation MXZFullFourthSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headImg.layer.cornerRadius = 15;
    self.headImg.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDiscussModel:(MXZDiscussModel *)discussModel
{
    _discussModel = discussModel;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:discussModel.user.head] placeholderImage:[UIImage imageNamed:@"user_hot_community"]];
    if (discussModel.content != nil) {
        self.commentLabel.text = discussModel.content;
    }
    if (discussModel.user.nickName != nil) {
        self.nickName.text = discussModel.user.nickName;
    }
}

@end
