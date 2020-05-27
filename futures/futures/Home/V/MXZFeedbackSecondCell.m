//
//  MXZFeedbackSecondCell.m
//  futures
//
//  Created by Francis on 2020/5/26.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZFeedbackSecondCell.h"

@implementation MXZFeedbackSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _addPicBtn.layer.cornerRadius = 6;
    _addPicBtn.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.7];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
