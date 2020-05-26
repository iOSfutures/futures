//
//  AttentionTableViewCell.m
//  futures
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "AttentionTableViewCell.h"
#import "UIColor+Hex.h"

@implementation AttentionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
