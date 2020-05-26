//
//  ZZHImageTableViewCell.m
//  futures
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "ZZHImageTableViewCell.h"
#import "UIColor+Hex.h"

#import "ZZHNewsImageModel.h"

#import "ZZHCollectionViewCell.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"

@interface ZZHImageTableViewCell ()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>
@property (weak, nonatomic) IBOutlet TYCyclePagerView *tyPagerView;

@property (nonatomic, strong) TYPageControl *pageControl;

@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation ZZHImageTableViewCell

- (NSArray *) imageArray {
    if (_imageArray == nil) {
        ZZHNewsImageModel *imageModelA = ZZHNewsImageModel.new;
        imageModelA.avatarImgName = @"banner01_qoutation";
        imageModelA.name = @"NYMEX纽约原油6月期货受移仓换月影响";
        ZZHNewsImageModel *imageModelB = ZZHNewsImageModel.new;
        imageModelB.avatarImgName = @"banner01_qoutation";
        imageModelB.name = @"NYMEX纽约原油6月期货受移仓换月影响";
        ZZHNewsImageModel *imageModelC = ZZHNewsImageModel.new;
        imageModelC.avatarImgName = @"banner01_qoutation";
        imageModelC.name = @"NYMEX纽约原油6月期货受移仓换月影响";
        
        NSMutableArray *temp = NSMutableArray.new;
        [temp addObject:imageModelA];
        [temp addObject:imageModelB];
        [temp addObject:imageModelC];
        _imageArray = temp;
    }
    return _imageArray;
}

NSString *ZZHBannerCellID = @"ZZHBannerCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addPagerView];
    [self addPageControl];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _tyPagerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    _pageControl.frame = CGRectMake(145, CGRectGetHeight(_tyPagerView.frame) - 30, CGRectGetWidth(_tyPagerView.frame), 26);
}

- (void)addPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
    pagerView.isInfiniteLoop = NO;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    [pagerView registerNib:[UINib nibWithNibName:NSStringFromClass([ZZHCollectionViewCell class])bundle:nil] forCellWithReuseIdentifier:ZZHBannerCellID];
    [self addSubview:pagerView];
    _tyPagerView = pagerView;
}

- (void)addPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc]init];
    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(12.7, 3);
    pageControl.pageIndicatorSize = CGSizeMake(3.7, 3);
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#FFFFFF"];
    pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#151723"];
//    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
//    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
//    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
//    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    [_tyPagerView addSubview:pageControl];
    _pageControl = pageControl;
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    _pageControl.numberOfPages = self.imageArray.count;
    return self.imageArray.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    ZZHCollectionViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:ZZHBannerCellID forIndex:index];
    cell.imageModel = self.imageArray[index];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(345, 106);
    layout.itemSpacing = 15;
    layout.layoutType = normal;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

@end
