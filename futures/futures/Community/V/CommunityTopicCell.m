//
//  CommunityTopicCell.m
//  futures
//
//  Created by Ssiswent on 2020/5/19.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityTopicCell.h"
#import "CommunityTopicViewCell.h"
#import "CommunityTopicModel.h"

@interface CommunityTopicCell ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UITableView *topicTableView;

@property (strong , nonatomic) NSArray *topicsArray;

@end

@implementation CommunityTopicCell

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

NSString *TopicCellID = @"TopicCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSMutableAttributedString *titleAttString = [[NSMutableAttributedString alloc] initWithString:@"今日话题" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#F69312"], NSKernAttributeName:@(2.0f)}];
    [titleAttString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#333333"]} range:NSMakeRange(0, 2)];
    _titleLable.attributedText = titleAttString;
    
    self.topicTableView.rowHeight = 94;
    self.topicTableView.dataSource = self;
    self.topicTableView.delegate = self;
    [self.topicTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityTopicViewCell class]) bundle:nil] forCellReuseIdentifier:TopicCellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topicsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityTopicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCellID];
    CommunityTopicModel *topicModel = CommunityTopicModel.new;
    topicModel = self.topicsArray[indexPath.row];
    cell.contentLabel.text = topicModel.content;
    cell.topicImgView.image = [UIImage imageNamed:topicModel.imageName];
    
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

@end
