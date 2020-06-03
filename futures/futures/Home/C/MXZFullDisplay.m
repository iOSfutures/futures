//
//  MXZFullDisplay.m
//  futures
//
//  Created by Francis on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZFullDisplay.h"
#import "MXZFullFirstSectionCell.h"
#import "MXZFullSecondSectionCell.h"
#import "MXZFullThirdSectionHeadView.h"
#import "MXZFullThirdSectionCell.h"
#import "MXZFullFourthSectionCell.h"
#import "UIImage+OriginalImage.h"
#import "MXZDiscussModel.h"

@interface MXZFullDisplay ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *displayTableview;
@property (strong, nonatomic) NSArray *discussArray;
@end

@implementation MXZFullDisplay

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.displayTableview registerNib:[UINib nibWithNibName:@"MXZFullFirstSectionCell" bundle:nil] forCellReuseIdentifier:@"MXZFullFirstSectionCell"];
    [self.displayTableview registerNib:[UINib nibWithNibName:@"MXZFullSecondSectionCell" bundle:nil] forCellReuseIdentifier:@"MXZFullSecondSectionCell"];
    [self.displayTableview registerNib:[UINib nibWithNibName:@"MXZFullThirdSectionCell" bundle:nil] forCellReuseIdentifier:@"MXZFullThirdSectionCell"];
    [self.displayTableview registerNib:[UINib nibWithNibName:@"MXZFullFourthSectionCell" bundle:nil] forCellReuseIdentifier:@"MXZFullFourthSectionCell"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(backPreView)];
    
    //启用右滑返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [self getDiscussModel];
}


- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)backPreView{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark getDiscuss
-(void)getDiscussModel{
    WEAKSELF
    [ENDNetWorkManager getWithPathUrl:@"/user/talk/getDiscussByUserId?userId=4161" parameters:nil queryParams:nil Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.discussArray = [MTLJSONAdapter modelsOfClass:[MXZDiscussModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
        //刷新第5个section
        [weakSelf.displayTableview reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];

    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.view Message:@"获取评论失败" afterHideTime:DELAYTiME];
    }];
}


#pragma mark -TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 3){
        return self.discussArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        static NSString *cellID = @"MXZFullFirstSectionCell";
        MXZFullFirstSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil){
            cell = [[NSBundle mainBundle] loadNibNamed:@"MXZFullFirstSectionCell" owner:self options:nil].firstObject;
        }
        [cell.headPic sd_setImageWithURL:[NSURL URLWithString:self.recommandModel.user.head]placeholderImage:[UIImage imageNamed:@"user_hot chat_community"]];
        cell.nickNameLabel.text = self.recommandModel.user.nickName;
        return cell;
    }
    else if (indexPath.section == 1){
        static NSString *cellID = @"MXZFullSecondSectionCell";
        MXZFullSecondSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil){
            cell = [[NSBundle mainBundle] loadNibNamed:@"MXZFullSecondSectionCell" owner:self options:nil].firstObject;
        }
        if(self.recommandModel != nil){
            cell.firstLabel.text = self.recommandModel.content;
            [cell.pic01 sd_setImageWithURL:[NSURL URLWithString:self.recommandModel.picture]];
        }
        return cell;
    }
    else if (indexPath.section == 2){
        static NSString *cellID = @"MXZFullThirdSectionCell";
        MXZFullThirdSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil){
            cell = [[NSBundle mainBundle] loadNibNamed:@"MXZFullThirdSectionCell" owner:self options:nil].firstObject;
        }
        return cell;
    }
    else if (indexPath.section == 3){
        static NSString *cellID = @"MXZFullFourthSectionCell";
        MXZFullFourthSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil){
            cell = [[NSBundle mainBundle] loadNibNamed:@"MXZFullFourthSectionCell" owner:self options:nil].firstObject;
        }
        cell.discussModel = self.discussArray[indexPath.row];
        return cell;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 85)];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15,0,350,80);
        label.numberOfLines = 0;
        label.text = [self.recommandModel.content substringToIndex:30];
//        label.text = @"对个人而言，股票指数期货市场将是一个大有可为的市场。那么股指期货如何操作？";
        label.font = [UIFont boldSystemFontOfSize:18];
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        
        [headView addSubview:label];
        
        return headView;
    }
    else if(section == 2){
        UIView *headView = [[NSBundle mainBundle] loadNibNamed:@"MXZFullThirdSectionHeadView" owner:self options:nil].firstObject;
        return headView;
    }
    else if (section == 3){
        MXZFullThirdSectionHeadView *headView = [[NSBundle mainBundle] loadNibNamed:@"MXZFullThirdSectionHeadView" owner:self options:nil].firstObject;
        headView.titleLabel.text = @"全部48条评论";
        return headView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 85;
    }
    else if (section == 2 || section == 3){
        return 56;
    }
    return 0.001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section == 1){
        UIView *footView = [[NSBundle mainBundle] loadNibNamed:@"MXZFullSecondSectionFootView" owner:self options:nil].firstObject;
        return footView;
    }
    else if (section == 3){
        UIView *footView = [[NSBundle mainBundle] loadNibNamed:@"MXZFullFourthSectionFootVIew" owner:self options:nil].firstObject;
        return footView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 1){
        return 70;
    }
    else if (section == 3){
        return 50;
    }
    return 0.001f;
}
@end
