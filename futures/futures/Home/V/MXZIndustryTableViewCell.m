//
//  MXZIndustryTableViewCell.m
//  futures
//
//  Created by Francis on 2020/5/18.
//  Copyright © 2020 Francis. All rights reserved.
//
#define MAS_SHORTHAND
#import "MXZIndustryTableViewCell.h"
#import <Masonry/Masonry.h>



@implementation MXZIndustryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self.contentLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6.5f; // 设置行间距
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
    self.contentLabel.attributedText = attributedStr;
    
    //设置阴影
    self.cellView.layer.shadowColor =  [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.17].CGColor;
    self.cellView.layer.shadowOffset = CGSizeMake(0,0);
    self.cellView.layer.shadowOpacity = 1;
    self.cellView.layer.shadowRadius = 15;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.nonSubtitle == true) {
//        AutoLayout创建的控件,frame设置无效
//        self.titleLabel.frame = CGRectMake(15, 50, 300, 16);
//        self.titleLabel.frame = CGRectMake(self.kindLabel.frame.origin.x, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kindLabel).offset(38.f);
            make.left.equalTo(self.kindLabel.superview).offset(15.f);
            make.width.equalTo(self.kindLabel).offset(180.f);
            make.height.equalTo(self.kindLabel).offset(-4.f);
        }];
    }
}




@end
