//
//  LoginTableViewCell.m
//  futures
//
//  Created by apple on 2020/5/29.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "LoginTableViewCell.h"
#import "ZXCountDownView.h"
#import "forgetPwdVC.h"

@interface LoginTableViewCell ()

@property (weak, nonatomic) IBOutlet ZXCountDownLabel *loginTimeLabel;

@property (weak, nonatomic) IBOutlet UITextField *numTextF;

@end

@implementation LoginTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.loginTimeLabel.text = _labelStr;
    self.loginTimeLabel.textColor = _labelColor;
//    _timeBgView.backgroundColor = _bgColor;
    
    //设置圆角
    self.timeBgView.layer.cornerRadius = 15;
    //开启交互
    self.timeBgView.userInteractionEnabled = YES;
    
    [self.loginTimeLabel setCountDown:60 mark:@"loginTimeLabel" resTextFormat:^NSString * _Nullable(long remainSec) {
            if(remainSec < 60){
    //            self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
            } else {
//                self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
            }
            //显示剩余几分几秒
            return [NSString stringWithFormat:@"%lds",remainSec];
        }];
        
        [self clickGes];
    
}

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
//    _timeBgView.backgroundColor = _bgColor;
}

- (void)setLabelStr:(NSString *)labelStr
{
    _labelStr = labelStr;
    self.loginTimeLabel.text = _labelStr;
}

- (void)setLabelColor:(UIColor *)labelColor
{
    _labelColor = labelColor;
    self.loginTimeLabel.textColor = labelColor;
}


- (void)clickGes {
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGes:)];
    [self.timeBgView addGestureRecognizer:tap];
}

- (void)clickGes: (UITapGestureRecognizer *)tap {
    if(self.isPwd == NO){
        //开启定时器
        [self.loginTimeLabel startCountDown];
        self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
    }else{
        //跳转到忘记密码界面
        
    }
}


@end
