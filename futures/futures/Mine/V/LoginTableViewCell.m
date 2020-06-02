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

#import "MineCodeView.h"

@interface LoginTableViewCell ()<MineCodeViewDelegate>

@property (weak, nonatomic) IBOutlet ZXCountDownLabel *loginTimeLabel;

@property (weak, nonatomic) IBOutlet UITextField *numTextF;

@property (weak, nonatomic)UIView *coverView;
@property (weak, nonatomic)MineCodeView *mineCodeView;

@property (copy, nonatomic)NSString *picCode;

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
    self.timeBgView.userInteractionEnabled = NO;
    self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
    
    [self.loginTimeLabel setCountDown:60 mark:@"loginTimeLabel" resTextFormat:^NSString * _Nullable(long remainSec) {
        [self timeBGViewCountViewStatus];
            //显示剩余几分几秒
            return [NSString stringWithFormat:@"%lds",remainSec];
        }];
        
        [self clickGes];
    
    [self.numTextF addTarget:self action:@selector(textChange1) forControlEvents:UIControlEventEditingChanged];
    [self.pwdTextF addTarget:self action:@selector(textChange2) forControlEvents:UIControlEventEditingChanged];
}

//查看计时器的状态
- (void)timeBGViewCountViewStatus {
    //判断计时器是否是开启状态,是就执行以下操作
    if (self.loginTimeLabel.countViewStatus == 2) {
        self.timeBgView.userInteractionEnabled = NO;
        self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
    } else {
        self.timeBgView.userInteractionEnabled = YES;
        self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    }
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
    MineCodeView *mineCodeView = [[NSBundle mainBundle]loadNibNamed:@"MineCodeView" owner:nil options:nil].firstObject;
    mineCodeView.delegate = self;
    self.mineCodeView = mineCodeView;
    [self addCoverView];
    [self getPicCode];
}

- (void)textChange1
{
    if(self.numTextF.text.length == 11)
    {
        self.timeBgView.userInteractionEnabled = YES;
        self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    }
    else
    {
        self.timeBgView.userInteractionEnabled = NO;
        self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
    }
    if([self.delegate respondsToSelector:@selector(loginTableViewCellDidChangedTextF:phone:pwd:)])
    {
        [self.delegate loginTableViewCellDidChangedTextF:self phone:_numTextF.text pwd:_pwdTextF.text];
    }
}

- (void)textChange2
{
    if([self.delegate respondsToSelector:@selector(loginTableViewCellDidChangedTextF:phone:pwd:)])
    {
        [self.delegate loginTableViewCellDidChangedTextF:self phone:_numTextF.text pwd:_pwdTextF.text];
    }
}

- (void)MineCodeViewDidClickCancelBtn:(MineCodeView *)mineCodeView
{
    [self removeCoverView];
}

- (void)MineCodeViewDidClickConfirmBtn:(MineCodeView *)mineCodeView inputCode:(NSString *)inputCode
{
    self.picCode = inputCode;
    [self sendCode];
}

- (void)MineCodeViewDidClickChangeBtn:(MineCodeView *)mineCodeView
{
    [self getPicCode];
}

- (void)MineCodeViewDidClickCodeImgView:(MineCodeView *)mineCodeView
{
    [self getPicCode];
}

- (void)removeCoverView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.mineCodeView.alpha = 0;
        CGRect frame = self.mineCodeView.frame;
        frame.size = CGSizeMake(0, 0);
        self.mineCodeView.frame = frame;
    }completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
    }];
}

- (void)addCoverView
{
    UIView *coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    _mineCodeView.alpha = 0;
    _mineCodeView.center = coverView.center;
    CGRect frame = _mineCodeView.frame;
    frame.size = CGSizeMake(0, 0);
    _mineCodeView.frame = frame;
    [coverView addSubview:_mineCodeView];
    _coverView = coverView;
    
    NSArray *array = [UIApplication sharedApplication].windows;
    UIWindow *keyWindow = [array objectAtIndex:0];
    [keyWindow addSubview:_coverView];
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        self.mineCodeView.alpha = 1;
        CGRect frame = self.mineCodeView.frame;
        frame.size = CGSizeMake(340, 181);
        self.mineCodeView.frame = frame;
    }];
}

- (void)getPicCode
{
    WEAKSELF
    [ENDNetWorkManager getWithPathUrl:@"/system/sendVerify" parameters:nil queryParams:nil Header:nil success:^(BOOL success, id result) {
        NSString *dataStr = result[@"data"];
        NSData *imgData = [[NSData alloc]initWithBase64EncodedString:dataStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        //        NSData *imageDAta1 = [dataStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        UIImage *image = [UIImage imageWithData:imgData];
        weakSelf.mineCodeView.codeImgView.image = image;
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf Message:@"获取图形验证码失败" afterHideTime:DELAYTiME];
    }];
}

- (void)sendCode
{
    WEAKSELF
    if([self.picCode isEqualToString:@""])
    {
        self.picCode = @" ";
    }
    NSDictionary *dic = @{@"phone":self.numTextF.text,@"type":@(1),@"project":ProjectCategory,@"code":self.picCode};
    [ENDNetWorkManager postWithPathUrl:@"/system/sendCode" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        [self removeCoverView];
        [self.loginTimeLabel startCountDown];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.coverView Message:@"发送验证码失败" afterHideTime:DELAYTiME];
    }];
    
}

@end
