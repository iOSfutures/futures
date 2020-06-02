//
//  QHDHHeadCollectionViewCell.m
//  FuturesPass
//
//  Created by apple on 2019/6/3.
//  Copyright © 2019 FuturesPass. All rights reserved.
//

#import "QHDHHeadCollectionViewCell.h"

@implementation QHDHHeadCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleL];
        
        
        [self addSubview:self.lineView];
    }
    return self;
}

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/5, 40)];
        _titleL.font = NameFont(18);
        _titleL.textColor = LabelColor;
        _titleL.textAlignment = NSTextAlignmentCenter;
        
        _titleL.backgroundColor = [UIColor clearColor];
    }
    return _titleL;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH/5, 2)];
        _lineView.backgroundColor = [UIColor colorWithRed:0.296 green:0.613 blue:1.000 alpha:1.000];
        _lineView.hidden = YES;
    }
    return _lineView;
}

@end
