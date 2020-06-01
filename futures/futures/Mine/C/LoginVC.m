//
//  LoginVC.m
//  futures
//
//  Created by apple on 2020/5/27.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "LoginVC.h"
#import "MXZSettingCenterVC.h"
#import "RegisterVC.h"
#import "LoginTableViewCell.h"
#import "forgetPwdVC.h"

#import "UIColor+Hex.h"
#import "UIImage+OriginalImage.h"

@interface LoginVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *numLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *pwdLoginBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (nonatomic, assign) BOOL isPwd;


@end

@implementation LoginVC

NSString *LoginID = @"LoginVC";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LoginTableViewCell class]) bundle:nil] forCellReuseIdentifier:LoginID];
    
    
    _labelStr = @"获取验证码";
    _labelColor = [UIColor whiteColor];
    _bgColor = [UIColor colorWithHexString:@"#FEA203"];
    
    
    //设置navigationBar颜色
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    
    //左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClick)];
    
    //右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我是新手，我要注册" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
     [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"PingFang-SC-Regular" size:15] , NSFontAttributeName, nil] forState:UIControlStateNormal];
 
    
    self.bgView.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //设置cell高度
    self.tableView.rowHeight = 135;
    //隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //创建手机登录按钮下的小条
    UIView *pointView = [UIView new];
    self.pointView = pointView;
    pointView.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    pointView.frame = CGRectMake(17, 44, 50, 3);
    [self.bgView addSubview:pointView];

    
}



- (void)leftClick {
    MXZSettingCenterVC *vc = self.navigationController.childViewControllers[1];
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)rightClick {
    RegisterVC *registerVC = [RegisterVC new];
    [self.navigationController pushViewController:registerVC animated:YES];
}

//手机登录按钮点击
- (IBAction)numLoginBtnClick:(UIButton *)sender {
    self.pointView.frame = CGRectMake(17, 44, 50, 3);
    self.isPwd = NO;
    _labelStr = @"获取验证码";
    _labelColor = [UIColor whiteColor];
//    _bgColor = [UIColor colorWithHexString:@"#FEA203"];
    
    [self.tableView reloadData];
}

//密码登录按钮点击
- (IBAction)pwdLoginBtnClick:(UIButton *)sender {
    self.pointView.frame = CGRectMake(17 + 94, 44, 50, 3);
    self.isPwd = YES;
    _labelStr = @"忘记密码";
//    _labelColor = [UIColor colorWithHexString:@"#AAAAAA"];
    _bgColor = [UIColor whiteColor];
    [self.tableView reloadData];
}


#pragma mark - UITableViewViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LoginID];
    cell.isPwd = self.isPwd;
    if(self.isPwd == NO){
        cell.pwdTextF.placeholder = @"输入验证码";
    }else{
        cell.pwdTextF.placeholder = @"输入密码";
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGes:)];
        [cell.forgetpwdBtn addGestureRecognizer:tap];
        
    }
    if(self.isPwd == NO){
        cell.forgetpwdBtn.hidden = YES;
        cell.timeBgView.hidden = NO;
    }else{
        cell.forgetpwdBtn.hidden = NO;
        cell.timeBgView.hidden = YES;
    }
    cell.labelStr = _labelStr;
    cell.bgColor = _bgColor;
    cell.labelColor = _labelColor;
    return cell;
}


- (void)clickGes: (UITapGestureRecognizer *)tap {
    //跳转到忘记密码界面
    forgetPwdVC *forgetVC = [[forgetPwdVC alloc]init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}


@end
