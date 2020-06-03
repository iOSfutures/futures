//
//  RegisterVC.m
//  futures
//
//  Created by apple on 2020/5/27.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "RegisterVC.h"
#import "LoginVC.h"

#import "ZXCountDownView.h"
#import "UIColor+Hex.h"
#import "UIImage+OriginalImage.h"

#import "UserModel.h"

#import "MineCodeView.h"

@interface RegisterVC ()<MineCodeViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UIView *timeBgView;
@property (weak, nonatomic) IBOutlet ZXCountDownLabel *scheduleStoreLabel;
@property (weak, nonatomic) IBOutlet UITextField *numtextF;
@property (weak, nonatomic) IBOutlet UITextField *CaptchaTextF;
@property (weak, nonatomic) IBOutlet UITextField *pwdtextF;
@property (weak, nonatomic) IBOutlet UITextField *dittopwdtextF;

@property (weak, nonatomic)UIView *coverView;
@property (weak, nonatomic)MineCodeView *mineCodeView;

@property (copy, nonatomic)NSString *picCode;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClick)];
    
    self.pointLabel.textColor = [UIColor colorWithHexString:@"#AAAAAA"];
    
    self.timeBgView.userInteractionEnabled = NO;
    
        self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
    self.timeBgView.layer.cornerRadius = 15;
    
    
    [self.scheduleStoreLabel setCountDown:60 mark:@"ScheduleStoreLabel" resTextFormat:^NSString * _Nullable(long remainSec) {
        [self timeBGViewCountViewStatus];
        //显示剩余几分几秒
        return [NSString stringWithFormat:@"%lds",remainSec];
    }];
    
    [self clickGes];
    
    self.timeBgView.userInteractionEnabled = NO;
    //监听文本框内容的改变
    [self.numtextF addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
}

//查看计时器的状态
- (void)timeBGViewCountViewStatus {
    //判断计时器是否是开启状态,是就执行以下操作
    if (self.scheduleStoreLabel.countViewStatus == 2) {
        self.timeBgView.userInteractionEnabled = NO;
        self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
    } else {
        self.timeBgView.userInteractionEnabled = YES;
        self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    }
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

- (void)leftClick {
//    LoginVC *vc = self.navigationController.childViewControllers[2];
//    [self.navigationController popToViewController:vc animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)registClicked:(id)sender {
    [self regist];
}


- (void)textChange {
    if(self.numtextF.text.length == 11)
    {
        self.timeBgView.userInteractionEnabled = YES;
        self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    }
    else
    {
        self.timeBgView.userInteractionEnabled = NO;
        self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
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
        [Toast makeText:weakSelf.view Message:@"获取图形验证码失败" afterHideTime:DELAYTiME];
    }];
}

- (void)sendCode
{
    WEAKSELF
    if([self.picCode isEqualToString:@""])
    {
        self.picCode = @" ";
    }
    NSDictionary *dic = @{@"phone":self.numtextF.text,@"type":@(1),@"project":ProjectCategory,@"code":self.picCode};
    [ENDNetWorkManager postWithPathUrl:@"/system/sendCode" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        [self removeCoverView];
        [self.scheduleStoreLabel startCountDown];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.coverView Message:@"发送验证码失败" afterHideTime:DELAYTiME];
    }];
    
}

- (void)regist
{
    WEAKSELF
    NSDictionary *dic = @{@"phone":self.numtextF.text,@"password":self.pwdtextF.text,@"confirmPassword":self.dittopwdtextF.text,@"code":self.CaptchaTextF.text,@"type":@(1),@"project":ProjectCategory};
    [ENDNetWorkManager postWithPathUrl:@"/system/register" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        UserModel *user = [MTLJSONAdapter modelOfClass:[UserModel class] fromJSONDictionary:result[@"data"] error:&error];
        NSLog(@"User:%@",user);
        //获取用户偏好
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        //记录userId
        [userDefault setObject:user.userId forKey:@"userId"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"注册失败" afterHideTime:DELAYTiME];
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

@end
