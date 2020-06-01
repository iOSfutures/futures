//
//  AttentionTableViewCell.m
//  futures
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "AttentionTableViewCell.h"
#import "UIColor+Hex.h"

#import "UserModel.h"

@interface AttentionTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation AttentionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _headImgView.layer.cornerRadius = 17.5;
    _headImgView.layer.masksToBounds = YES;
}

- (void)setModel:(UserModel *)model
{
    _model = model;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.head]
    placeholderImage:[UIImage imageNamed:@"user_hot_community"]];
    _nameLabel.text = model.nickName;
}

@end
