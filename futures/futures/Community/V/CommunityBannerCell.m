//
//  BannerCell.m
//  futures
//
//  Created by Ssiswent on 2020/5/18.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityBannerCell.h"

#import "TYCyclePagerView.h"
#import "CommunityBannerViewCell.h"


@interface CommunityBannerCell ()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (weak, nonatomic) IBOutlet TYCyclePagerView *tyPagerView;

@property (nonatomic, strong) NSArray *bannerImgs;

@end

@implementation CommunityBannerCell

- (NSArray *)bannerImgs
{
    if(_bannerImgs == nil)
    {
        NSArray *temp = [NSArray arrayWithObjects:@"financial topics_bn_community", @"financial reading_bn_community", @"financial topics_bn_community", @"financial reading_bn_community", nil];
        _bannerImgs = temp;
    }
    return _bannerImgs;
}

NSString *BannerCellID = @"BannerCell";

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addPagerView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _tyPagerView.frame = CGRectMake(3, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)addPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
    pagerView.isInfiniteLoop = NO;
//    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    // registerClass or registerNib
//    [pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [pagerView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityBannerViewCell class])bundle:nil] forCellWithReuseIdentifier:BannerCellID];
//    pagerView.contentOffset = UIEdgeInsetsMake(10, 15, 10, 15);
    [self addSubview:pagerView];
//    _pagerView = pagerView;
    _tyPagerView = pagerView;
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.bannerImgs.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    CommunityBannerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:BannerCellID forIndex:index];
    cell.BannnerImgView.image = [UIImage imageNamed:self.bannerImgs[index]];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(180, 132);
    layout.itemSpacing = 0;
    layout.layoutType = normal;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

@end
