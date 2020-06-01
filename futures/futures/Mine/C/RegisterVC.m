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

@interface RegisterVC ()
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UIView *timeBgView;
@property (weak, nonatomic) IBOutlet ZXCountDownLabel *scheduleStoreLabel;
@property (weak, nonatomic) IBOutlet UITextField *numtextF;
@property (weak, nonatomic) IBOutlet UITextField *CaptchaTextF;
@property (weak, nonatomic) IBOutlet UITextField *pwdtextF;
@property (weak, nonatomic) IBOutlet UITextField *dittopwdtextF;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClick)];
    
    self.pointLabel.textColor = [UIColor colorWithHexString:@"#AAAAAA"];
    
    self.timeBgView.userInteractionEnabled = YES;
    
    self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    self.timeBgView.layer.cornerRadius = 15;
    
    
    [self.scheduleStoreLabel setCountDown:60 mark:@"ScheduleStoreLabel" resTextFormat:^NSString * _Nullable(long remainSec) {
        if(remainSec < 60){
//            self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
        } else {
//            self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
        }
        //显示剩余几分几秒
        return [NSString stringWithFormat:@"%lds",remainSec];
    }];
    
    [self clickGes];
    
    
    //监听文本框内容的改变
    [self.numtextF addTarget:self action:@selector(textChange) forControlEvents:UIControlEventValueChanged];
}

- (void)clickGes {
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGes:)];
    [self.timeBgView addGestureRecognizer:tap];
}

- (void)clickGes: (UITapGestureRecognizer *)tap {
        [self.scheduleStoreLabel startCountDown];
        self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"]; 
}

- (void)leftClick {
    LoginVC *vc = self.navigationController.childViewControllers[2];
    [self.navigationController popToViewController:vc animated:YES];
}


- (void)textChange {
    
}

@end
