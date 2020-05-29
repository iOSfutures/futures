//
//  CommunityChildBVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/15.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityChildBVC.h"
#import "CommunityFriendCell.h"
#import "CommunityDynamicCell.h"

#import "CommunityDynamicModel.h"

@interface CommunityChildBVC ()<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong , nonatomic) NSArray *dynamicsArray;

@end

@implementation CommunityChildBVC

NSString *DynamicCell2 = @"DynamicCell2";
NSString *FriendID2 = @"Friend2";

- (void)viewDidLoad {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityDynamicCell class]) bundle:nil]forCellReuseIdentifier:DynamicCell2];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityFriendCell class]) bundle:nil] forCellReuseIdentifier:FriendID2];
    
    [self getDynamics];
}

-(UIView *)listView{
    return self.view;
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dynamicsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 2)
    {
        CommunityFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:FriendID2];
        return cell;
    }
    else if(indexPath.row < 2)
    {
        CommunityDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicCell2];
        cell.dynamicModel = self.dynamicsArray[indexPath.row];
        return cell;
    }
    else
    {
        CommunityDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicCell2];
        cell.dynamicModel = self.dynamicsArray[indexPath.row - 1];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)getDynamics{
    WEAKSELF
    [ENDNetWorkManager getWithPathUrl:@"/user/talk/getRecommandTalk" parameters:nil queryParams:nil Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.dynamicsArray = [MTLJSONAdapter modelsOfClass:[CommunityDynamicModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求推荐说说失败" afterHideTime:DELAYTiME];
    }];
}

@end
