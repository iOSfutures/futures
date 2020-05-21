//
//  CommunityChildBVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/15.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityChildBVC.h"
#import "CommunityFiendCell.h"
#import "CommunityDynamicCell.h"

#import "CommunityDynamicModel.h"

@interface CommunityChildBVC ()<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong , nonatomic) NSArray *dynamicsArray;

@end

@implementation CommunityChildBVC

- (NSArray *)dynamicsArray
{
    if(_dynamicsArray == nil)
    {
        CommunityDynamicModel *dynamicModelA = CommunityDynamicModel.new;
        dynamicModelA.avatarImgName = @"user_hot_community";
        dynamicModelA.contentImg1Name = @"talk about_banner02_community";
        dynamicModelA.contentImg2Name = @"talk about_banner03_community";
        dynamicModelA.content = @"今年你更看好哪种基金表现？";
        CommunityDynamicModel *dynamicModelB = CommunityDynamicModel.new;
        dynamicModelB.avatarImgName = @"user_hot chat_community";
        dynamicModelB.content = @"Facebook携手权威咨询机构发布了“2019年中国出海品牌50强白皮书”，连续三年推出了“2019年度，咨询机构发布了...";
        CommunityDynamicModel *dynamicModelC = CommunityDynamicModel.new;
        dynamicModelC.avatarImgName = @"user_hot_community";
        dynamicModelC.contentImg1Name = @"talk about_banner01_community";
        dynamicModelC.content = @"今年你更看好哪种基金表现？";
        CommunityDynamicModel *dynamicModelD = CommunityDynamicModel.new;
        dynamicModelD.avatarImgName = @"user_hot chat_community";
        dynamicModelD.contentImg1Name = @"talk about_banner02_community";
        dynamicModelD.contentImg2Name = @"talk about_banner03_community";
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

NSString *DynamicCell2 = @"DynamicCell2";
NSString *FriendID2 = @"Friend2";

- (void)viewDidLoad {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityDynamicCell class]) bundle:nil]forCellReuseIdentifier:DynamicCell2];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityFiendCell class]) bundle:nil] forCellReuseIdentifier:FriendID2];
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
        CommunityFiendCell *cell = [tableView dequeueReusableCellWithIdentifier:FriendID2];
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

@end
