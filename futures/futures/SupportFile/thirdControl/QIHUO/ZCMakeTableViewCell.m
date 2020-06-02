//
//  ZCMakeTableViewCell.m
//  FuturesPass
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 FuturesPass. All rights reserved.
//

#import "ZCMakeTableViewCell.h"

@implementation ZCMakeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = RGB(255, 255, 255);
        [self addSubview:self.backV];
        
    }
    
    return self;
    
}

- (UIView *)backV{
    if (!_backV) {
        _backV = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_WIDTH*0.025, SCREEN_WIDTH*0.9, SCREEN_WIDTH*0.15)];
        _backV.backgroundColor = [UIColor whiteColor];
        // 阴影颜色
        _backV.layer.shadowColor = RGB(100, 100, 100).CGColor;
        // 阴影偏移，默认(0, -3)
        _backV.layer.shadowOffset = CGSizeMake(1,1);
        // 阴影透明度，默认0
        _backV.layer.shadowOpacity = 0.5;
        // 阴影半径，默认3
        _backV.layer.shadowRadius = 5;
        
        [_backV addSubview:self.nameL];
        [_backV addSubview:self.codeL];
        [_backV addSubview:self.picL];
        [_backV addSubview:self.changeL];
    }
    return _backV;
}

-(UILabel *)nameL{
    if (!_nameL) {
        
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_WIDTH*0.025, SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.05)];
        _nameL.font = NameFont(18);
        _nameL.textColor = LabelColor;
        
    }
    return _nameL;
}

-(UILabel *)codeL{
    if (!_codeL) {
        _codeL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, CGRectGetMaxY(_nameL.frame), SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.05)];
        _codeL.font = NameFont(13);
        _codeL.textColor = LabelColor;
        
        
    }
    return _codeL;
}

-(UILabel *)picL{
    if (!_picL) {
        _picL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameL.frame), 0, SCREEN_WIDTH*0.2, SCREEN_WIDTH*0.15)];
        _picL.font = NameFont(15);
        _picL.textColor = LabelColor;
        _picL.textAlignment = NSTextAlignmentRight;
        
        //        _picL.backgroundColor = LXRandomColor;
    }
    return _picL;
}

-(UILabel *)changeL{
    if (!_changeL) {
        _changeL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_picL.frame)+SCREEN_WIDTH*0.1, SCREEN_WIDTH*0.04, SCREEN_WIDTH*0.2, SCREEN_WIDTH*0.07)];
        _changeL.font = NameFont(15);
        _changeL.textColor = LabelColor;
        _changeL.textAlignment = NSTextAlignmentCenter;
        
        
        LXViewRadius(_changeL, 5);
        
    }
    return _changeL;
}

@end
