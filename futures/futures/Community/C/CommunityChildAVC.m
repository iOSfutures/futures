//
//  CommunityChildAVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/14.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityChildAVC.h"

#import "CommunityBannerCell.h"
#import "CommunityTopicCell.h"
#import "CommunityFriendCell.h"
#import "CommunityDynamicCell.h"

#import "CommunityTopicModel.h"
#import "CommunityDynamicModel.h"

#import "CommunityTopicHeaderView.h"

#import "MXZFullDisplay.h"
#import "MXZRecommandTalkModel.h"

@interface CommunityChildAVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong , nonatomic) NSArray *topicsArray;
@property (strong , nonatomic) NSMutableArray *dynamicsArray;

@end

@implementation CommunityChildAVC

NSString *BannerID = @"Banner";
NSString *FriendID = @"Friend";
NSString *TopicCellID = @"TopicCell";
NSString *DynamicCell = @"DynamicCell";

- (void)viewDidLoad {
    //    [super viewDidLoad];
    //    [self.view bringSubviewToFront:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityBannerCell class]) bundle:nil] forCellReuseIdentifier:BannerID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityFriendCell class]) bundle:nil] forCellReuseIdentifier:FriendID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityTopicCell class]) bundle:nil] forCellReuseIdentifier:TopicCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityDynamicCell class]) bundle:nil]forCellReuseIdentifier:DynamicCell];
    
    [self getTopics];
    [self getDynamics];
    
}

-(UIView *)listView{
    return self.view;
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }
    else if(section == 1)
    {
        if(self.topicsArray.count >= 3)
        {
            return 3;
        }
        else
        {
            return self.topicsArray.count;
        }
    }
    else if(section == 2)
    {
        return 1;
    }
    else
    {
        return self.dynamicsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        CommunityBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:BannerID];
        return cell;
    }
    else if(indexPath.section == 1)
    {
        CommunityTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCellID];
        cell.communityTopicModel = self.topicsArray[indexPath.row];
        
        if(indexPath.row == 0)
        {
            cell.tagView.backgroundColor = [UIColor colorWithHexString:@"#EF9942"];
            cell.tagLabel.text = @"#今日财经";
            cell.topicImgView.image = [UIImage imageNamed:@"banner01_community"];
        }
        else if(indexPath.row == 1)
        {
            cell.tagView.backgroundColor = [UIColor colorWithHexString:@"#77C116"];
            cell.tagLabel.text = @"#都市新闻";
            cell.topicImgView.image = [UIImage imageNamed:@"banner02_community"];
        }
        else
        {
            cell.tagView.backgroundColor = [UIColor colorWithHexString:@"#F9386E"];
            cell.tagLabel.text = @"#财经频道";
            cell.topicImgView.image = [UIImage imageNamed:@"banner03_community"];
        }
        return cell;
    }
    else if(indexPath.section == 2)
    {
        CommunityFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:FriendID];
        return cell;
    }
    else
    {
        CommunityDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicCell];
        cell.dynamicModel = self.dynamicsArray[indexPath.row];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        CommunityTopicHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"CommunityTopicHeaderView" owner:nil options:nil].firstObject;
        return headerView;
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        return 40;
    }
    else
    {
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)getTopics{
    WEAKSELF
    NSDate *todayDate = [NSDate date];
    NSDictionary *dic = @{@"date":todayDate};
    [ENDNetWorkManager getWithPathUrl:@"/admin/getFinanceAffairs" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.topicsArray = [MTLJSONAdapter modelsOfClass:[CommunityTopicModel class] fromJSONArray:result[@"data"] error:&error];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求话题失败" afterHideTime:DELAYTiME];
    }];
}

-(void)getDynamics{
    WEAKSELF
    [ENDNetWorkManager getWithPathUrl:@"/user/talk/getRecommandTalk" parameters:nil queryParams:nil Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.dynamicsArray = [MTLJSONAdapter modelsOfClass:[CommunityDynamicModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
        
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求推荐说说失败" afterHideTime:DELAYTiME];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 3)
    {
        CommunityDynamicModel *model = _dynamicsArray[indexPath.row];
        MXZRecommandTalkModel *mxzModel = MXZRecommandTalkModel.new;
        mxzModel.content = model.content;
        mxzModel.picture = model.picture1;
        mxzModel.user = model.user;
        mxzModel.recommandCount = indexPath.row%5;
        MXZFullDisplay *vc = MXZFullDisplay.new;
        vc.cellNum = indexPath.row;
        vc.recommandModel = mxzModel;
        [self.navigationController pushViewController:vc animated:YES];
        WEAKSELF
        vc.shieldBlock = ^(NSInteger shieldNum){
            [weakSelf.dynamicsArray removeObjectAtIndex:shieldNum];
            [weakSelf.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:shieldNum inSection:3]] withRowAnimation:UITableViewRowAnimationTop];
            
        };
    }
}

@end
