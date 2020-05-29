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
    //设置kindLabel随机颜色
    self.kindLabel.backgroundColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1.0];
    self.subtitleLabel.backgroundColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1.0];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self = [[NSBundle mainBundle]loadNibNamed:@"MXZIndustryTableViewCell" owner:self options:nil].firstObject;
    if (self) {
        self.frame = frame;
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.nonSubtitle == true) {
        [self.subtitleLabel removeFromSuperview];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kindLabel).offset(38.f);
        }];
    }
}




@end
