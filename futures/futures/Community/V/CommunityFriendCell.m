//
//  CommunityFiendCell.m
//  futures
//
//  Created by Ssiswent on 2020/5/19.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityFriendCell.h"

#import "TYCyclePagerView.h"
#import "CommunityFriendViewCell.h"

#import "CommunityFriendModel.h"

@interface CommunityFriendCell()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate, CommunityFriendViewCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *titleView;

@property (nonatomic, strong) TYCyclePagerView *pagerView;

@property (nonatomic, strong) NSArray *friendsArray;


@end

@implementation CommunityFriendCell

NSString *FriendCellID = @"FriendCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSMutableAttributedString *titleAttString = [[NSMutableAttributedString alloc] initWithString:@"今日活跃圈友" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#333333"], NSKernAttributeName:@(1.0f)}];
    _titleLabel.attributedText = titleAttString;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self addPagerView];
    
    [self getFriends];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _pagerView.frame = CGRectMake(9.5, CGRectGetMaxY(_titleView.frame) - 10, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetMaxY(_titleView.frame));
}

- (void)addPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
    pagerView.isInfiniteLoop = NO;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    [pagerView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityFriendViewCell class]) bundle:nil] forCellWithReuseIdentifier:FriendCellID];
    [self addSubview:pagerView];
    _pagerView = pagerView;
}

- (void)communityFriendViewCellDidClickFollowBtn:(CommunityFriendViewCell *)cell
{
//    [self.pagerView reloadData];
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.friendsArray.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    CommunityFriendViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:FriendCellID forIndex:index];
    
    cell.delegate = self;
    cell.friendModel = self.friendsArray[index];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(136, 167);
    layout.itemSpacing = 0;
    layout.layoutType = normal;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (IBAction)refreshBtnClicked:(id)sender {
    [self getFriends];
}

-(void)getFriends{
    WEAKSELF
    [ENDNetWorkManager getWithPathUrl:@"/user/follow/getRecommandUserList" parameters:nil queryParams:nil Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.friendsArray = [MTLJSONAdapter modelsOfClass:[CommunityFriendModel class] fromJSONArray:result[@"data"] error:&error];
//        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf.pagerView reloadData];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf Message:@"请求圈友数据失败" afterHideTime:DELAYTiME];
    }];
}

@end
