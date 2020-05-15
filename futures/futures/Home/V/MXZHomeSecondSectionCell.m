//
//  HomeQuoteTableViewCell.m
//  futures
//
//  Created by Francis on 2020/5/13.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZHomeSecondSectionCell.h"

@implementation MXZHomeSecondSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cellView.layer.shadowColor =  [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.17].CGColor;
    self.cellView.layer.shadowOffset = CGSizeMake(0,0);
    self.cellView.layer.shadowOpacity = 1;
    self.cellView.layer.shadowRadius = 15;
    self.cellView.layer.cornerRadius = 6;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
