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

@interface CommunityChildAVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CommunityChildAVC

NSString *BannerID = @"Banner";
NSString *TopicID = @"Topic";
NSString *ID = @"cell";

- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self.view bringSubviewToFront:self.tableView];
    [self.tableView registerClass:[CommunityBannerCell class] forCellReuseIdentifier:BannerID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityTopicCell class]) bundle:nil] forCellReuseIdentifier:TopicID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

-(UIView *)listView{
    return self.view;
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        CommunityBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:BannerID];
        return cell;
    }
    else if(indexPath.row == 1)
    {
        CommunityTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicID];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
    {
        return 150;
    }
    else if(indexPath.row == 1)
    {
        return 325.5;
    }
    else
    {
        return 44;
    }
}

@end
