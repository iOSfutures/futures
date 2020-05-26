//
//  MXZSignVC.m
//  futures
//
//  Created by Francis on 2020/5/21.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZSignVC.h"
#import "MXZSignPopView.h"
#import "UIImage+OriginalImage.h"

@interface MXZSignVC ()
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) UIView *coverView;
@property (strong, nonatomic) MXZSignPopView *popView;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIView *redPacket;
@end

@implementation MXZSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.navigationItem.title = @"签到领奖";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.titleView.layer.cornerRadius = 14;
    [self.signBtn addTarget:self action:@selector(popCoverview) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(backPreView)];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)backPreView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popCoverview{
    [_signBtn setTitle:@"已签到" forState:UIControlStateNormal];
    _signBtn.enabled = NO;
//    设置蒙版
    _coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //设置alpha有区别
//    _coverView.backgroundColor = [UIColor blackColor];
//    _coverView.alpha = 0.8;
    _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    //添加蒙版上弹窗视图
    _popView = [[MXZSignPopView alloc]initWithFrame:CGRectMake(0, 0, 312, 372)];
    _popView.center = _coverView.center;
    [_popView.confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_coverView addSubview:_popView];
    //实现弹出方法
    
    [[UIApplication sharedApplication].keyWindow addSubview:_coverView];
}

-(void)confirmBtnClick{
    [_coverView removeFromSuperview];
}

-(void)showBg{
      _bgView=[[UIView alloc]init];
        _bgView.frame=CGRectMake(0, 0, 375, 667);
        _bgView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _bgView.tag=12;
    _redPacket= [[UIView alloc] init];
    _redPacket.backgroundColor = [UIColor redColor];
    _redPacket.center=_bgView.center;
    _redPacket.frame = CGRectMake(0, 0, 290, 300);
        [_bgView addSubview:_redPacket];
         [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
