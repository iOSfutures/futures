//
//  MXZFullFirstSectionCell.m
//  futures
//
//  Created by Francis on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZFullFirstSectionCell.h"

@implementation MXZFullFirstSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headPic.layer.cornerRadius = 17.5;
    self.headPic.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
