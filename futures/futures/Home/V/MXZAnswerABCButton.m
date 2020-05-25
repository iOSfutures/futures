//
//  MXZAnswerABCView.m
//  futures
//
//  Created by Francis on 2020/5/22.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZAnswerABCButton.h"

@implementation MXZAnswerABCButton



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置阴影部分
        self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,2);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 7;
        self.layer.cornerRadius = 15;
        self.backgroundColor = [UIColor whiteColor];
        
        //设置按钮字体大小;背景颜色;文字颜色;点击事件
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(9, 9, 250, 12);
}





@end
