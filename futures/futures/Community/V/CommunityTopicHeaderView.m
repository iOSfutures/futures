//
//  CommunityTopicHeaderView.m
//  futures
//
//  Created by Ssiswent on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityTopicHeaderView.h"

@interface CommunityTopicHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CommunityTopicHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSMutableAttributedString *titleAttString = [[NSMutableAttributedString alloc] initWithString:@"今日话题" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#F69312"], NSKernAttributeName:@(1.0f)}];
    [titleAttString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#333333"]} range:NSMakeRange(0, 2)];
    _titleLabel.attributedText = titleAttString;
}

@end
