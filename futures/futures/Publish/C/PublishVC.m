//
//  PublishVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/11.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "PublishVC.h"
#import "MXZFeedbackFirstCell.h"
#import "MXZFeedbackSecondCell.h"
#import "MXZFeedbackFourthCell.h"

@interface PublishVC ()<UITableViewDelegate, UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSString *contentStr;
@property (strong, nonatomic) NSArray *picArray;
@property (copy, nonatomic)  NSString *saveURL;
@end

@implementation PublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    
    self.navigationItem.title = @"发布说说";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _tableView.scrollEnabled = NO;
    //注册
    [self.tableView registerClass:[MXZFeedbackFirstCell class] forCellReuseIdentifier:@"MXZFeedbackFirstCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXZFeedbackSecondCell" bundle:nil] forCellReuseIdentifier:@"MXZFeedbackSecondCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXZFeedbackFourthCell" bundle:nil] forCellReuseIdentifier:@"MXZFeedbackFourthCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
    MXZFeedbackFirstCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MXZFeedbackFirstCell"];
    [cell.btnA setTitle:@"生活小方针" forState:UIControlStateNormal];
    [cell.btnB setTitle:@"财经顾问" forState:UIControlStateNormal];
    [cell.btnC setTitle:@"周边爆料" forState:UIControlStateNormal];
    return cell;
    }
    else if (indexPath.section == 1){
    MXZFeedbackSecondCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MXZFeedbackSecondCell"];
        
        //设置完成编辑代理监听
        cell.textBlock = ^(NSString * string) {
            NSLog(@"string = %@",string);
            self.contentStr = string;
        };
//        cell.contentTextView.delegate = self;
        NSMutableArray *savePicArray = [NSMutableArray array];
        [savePicArray addObject:cell.picImage.image];
        self.picArray = savePicArray;
    return cell;
    }
    MXZFeedbackFourthCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MXZFeedbackFourthCell"];
    cell.pubulishBlock = ^(){
        //点击提交按钮后,结束编辑
        [self.view endEditing:true];
        //将图片上传到服务器,获得图片的URL
        [self uploadImg];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 60)];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 25, 70, 15)];
    //设置字体大小和字重
    titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    if(section == 0){
        titleLabel.text = @"分类标签";
    }
    else if (section == 1){
        titleLabel.text = @"我要反馈";
    }
    [headView addSubview:titleLabel];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

//上传图片
-(void)uploadImg{
    WEAKSELF
    NSDictionary *dict = @{
        @"file" : self.picArray[0]
    };
    
    [ENDNetWorkManager postFormWithPathUrl:@"http://image.yysc.online/upload" parameters:nil queryParams:dict Header:nil success:^(BOOL success, id result) {
        NSLog(@"result:%@", result);
        NSString *URL = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
        weakSelf.saveURL = URL;
        //上传图片成功后才publishMessage
        [self publishMessage];
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.view Message:@"上传图片失败" afterHideTime:DELAYTiME];
        NSLog(@"error:%@", error);
        self.saveURL = @"http://image.yysc.online/files/2020/5/1/ad4c4e590953f15463064bcf5c39a1b9.jpg";
        [self publishMessage];
    }];
}


-(void)publishMessage{
    WEAKSELF
    NSDictionary *dict = @{
        @"userId" : @4160,
        @"content" : self.contentStr,
        @"picture" : self.saveURL
    };
    [ENDNetWorkManager postWithPathUrl:@"/user/talk/publishTalk" parameters:nil queryParams:dict Header:nil success:^(BOOL success, id result) {
        [Toast makeText:weakSelf.view Message:@"发布说说成功" afterHideTime:DELAYTiME];
        NSLog(@"%@",result);
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.view Message:@"发布说说失败" afterHideTime:DELAYTiME];
        NSLog(@"%@",error);
    }];
}



@end
