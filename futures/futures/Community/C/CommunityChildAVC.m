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

@interface CommunityChildAVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong , nonatomic) NSArray *topicsArray;
@property (strong , nonatomic) NSArray *dynamicsArray;

@end

@implementation CommunityChildAVC

- (NSArray *)topicsArray
{
    if(_topicsArray == nil)
    {
        CommunityTopicModel *topicModelA = CommunityTopicModel.new;
        topicModelA.content = @"美股芯片股盘前普遍下挫，此前美光披露第四财季业绩，净利润同比大...";
        topicModelA.imageName = @"banner01_community";
        CommunityTopicModel *topicModelB = CommunityTopicModel.new;
        topicModelB.content = @"家乐福超市被收购？ 今日，苏宁易购完成收购家乐…";
        topicModelB.imageName = @"banner02_community";
        CommunityTopicModel *topicModelC = CommunityTopicModel.new;
        topicModelC.content = @"美股芯片股盘前普遍下挫，此前美光披露第四财季业绩，净利润同比大...";
        topicModelC.imageName = @"banner03_community";
        NSMutableArray *temp = NSMutableArray.new;
        [temp addObject:topicModelA];
        [temp addObject:topicModelB];
        [temp addObject:topicModelC];
        _topicsArray = temp;
    }
    return _topicsArray;
}

- (NSArray *)dynamicsArray
{
    if(_dynamicsArray == nil)
    {
        CommunityDynamicModel *dynamicModelA = CommunityDynamicModel.new;
        dynamicModelA.avatarImgName = @"user_hot chat_community";
        dynamicModelA.contentImg1Name = @"talk about_banner01_community";
        dynamicModelA.content = @"今年你更看好哪种基金表现？";
        CommunityDynamicModel *dynamicModelB = CommunityDynamicModel.new;
        dynamicModelB.avatarImgName = @"user_hot_community";
        dynamicModelB.contentImg1Name = @"talk about_banner02_community";
        dynamicModelB.contentImg2Name = @"talk about_banner03_community";
        dynamicModelB.content = @"今年你更看好哪种基金表现？";
        CommunityDynamicModel *dynamicModelC = CommunityDynamicModel.new;
        dynamicModelC.avatarImgName = @"user_hot chat_community";
        dynamicModelC.content = @"Facebook携手权威咨询机构发布了“2019年中国出海品牌50强白皮书”，连续三年推出了“2019年度，咨询机构发布了...";
        CommunityDynamicModel *dynamicModelD = CommunityDynamicModel.new;
        dynamicModelD.avatarImgName = @"user_hot_community";
        dynamicModelD.contentImg1Name = @"talk about_banner01_community";
        dynamicModelD.content = @"今年你更看好哪种基金表现？";
        
        NSMutableArray *temp = NSMutableArray.new;
        [temp addObject:dynamicModelA];
        [temp addObject:dynamicModelB];
        [temp addObject:dynamicModelC];
        [temp addObject:dynamicModelD];
        _dynamicsArray = temp;
    }
    return _dynamicsArray;
}

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
        return 3;
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
        }
        else if(indexPath.row == 1)
        {
            cell.tagView.backgroundColor = [UIColor colorWithHexString:@"#77C116"];
            cell.tagLabel.text = @"#都市新闻";
        }
        else
        {
            cell.tagView.backgroundColor = [UIColor colorWithHexString:@"#F9386E"];
            cell.tagLabel.text = @"#财经频道";
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

@end
