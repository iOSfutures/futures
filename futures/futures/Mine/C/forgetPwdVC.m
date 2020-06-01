//
//  forgetPwdVC.m
//  futures
//
//  Created by apple on 2020/5/28.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "forgetPwdVC.h"
#import "LoginVC.h"

#import "ZXCountDownView.h"
#import "UIColor+Hex.h"
#import "UIImage+OriginalImage.h"

@interface forgetPwdVC ()

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *timeBgView;
@property (weak, nonatomic) IBOutlet ZXCountDownLabel *forgetStoreLabel;
@end

@implementation forgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置navigationBar颜色
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    
    //左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClick)];
    //右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我要登录" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
     [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"PingFang-SC-Regular" size:15] , NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    
    self.timeBgView.userInteractionEnabled = YES;
    
    self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    self.timeBgView.layer.cornerRadius = 15;
    
    
    [self.forgetStoreLabel setCountDown:60 mark:@"forgetStoreLabel" resTextFormat:^NSString * _Nullable(long remainSec) {
            if(remainSec < 60){
    //            self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
            } else {
    //            self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
            }
            //显示剩余几分几秒
            return [NSString stringWithFormat:@"%lds",remainSec];
        }];
        
        [self clickGes];
    
}


- (void)leftClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightClick {
    LoginVC *loginVC = [LoginVC new];
    [self.navigationController pushViewController:loginVC animated:YES];
}


- (void)clickGes {
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGes:)];
    [self.timeBgView addGestureRecognizer:tap];
}

- (void)clickGes: (UITapGestureRecognizer *)tap {
        [self.forgetStoreLabel startCountDown];
        self.timeBgView.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
}


@end
