//
//  MXZHomeFifthSectionCell.m
//  futures
//
//  Created by Francis on 2020/5/15.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZHomeFifthSectionCell.h"

@interface MXZHomeFifthSectionCell()

@end
@implementation MXZHomeFifthSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecommandModel:(MXZRecommandTalkModel *)recommandModel
{
    _recommandModel = recommandModel;
    [self.contentPic sd_setImageWithURL:[NSURL URLWithString:recommandModel.picture] placeholderImage:[UIImage imageNamed:@"banner01_zx"]];
    if(recommandModel.content != nil){
    self.contentLabel.text = recommandModel.content;
    }
}

@end
