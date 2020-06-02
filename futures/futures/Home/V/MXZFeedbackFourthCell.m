//
//  MXZFeedbackFourthCell.m
//  futures
//
//  Created by Francis on 2020/5/26.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZFeedbackFourthCell.h"

@implementation MXZFeedbackFourthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)publishClick:(id)sender {
    if (_pubulishBlock) {
        _pubulishBlock();
    }
}

@end
