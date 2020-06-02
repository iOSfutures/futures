//
//  QHDataCollectionViewCell.m
//  StockItem
//
//  Created by apple on 2019/4/16.
//  Copyright © 2019 apple. All rights reserved.
//

#import "QHDataCollectionViewCell.h"

@implementation QHDataCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.nameL];
        [self addSubview:self.contL];
    }
    return self;
}

- (UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.05-5)];
        _nameL.textAlignment = NSTextAlignmentCenter;
        _nameL.font = NameFont(14);
        _nameL.textColor = RGB(80, 80, 80);
        _nameL.backgroundColor = ClearColor;
    }
    return _nameL;
}

-(UILabel *)contL{
    if (!_contL) {
        _contL = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameL.frame), SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.05-5)];
        _contL.textAlignment = NSTextAlignmentCenter;
        _contL.font = NameFont(13);
        _contL.textColor = RGB(100, 100, 100);
        _contL.backgroundColor = ClearColor;
    }
    return _contL;
}

@end
