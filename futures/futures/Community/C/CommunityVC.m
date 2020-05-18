//
//  CommunityVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/11.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "CommunityVC.h"
#import "CommunityChildAVC.h"
#import "CommunityChildBVC.h"
#import "UIColor+Hex.h"
#import "UIImage+OriginalImage.h"

#import "JXCategoryTitleView.h"

@interface CommunityVC ()

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;

@end

@implementation CommunityVC

- (void)viewDidLoad {
    self.titles = @[@"社交", @"关注" ];
    
    //设置导航条的背景图片不为空，就可以隐藏背景
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    
    [super viewDidLoad];
    
    self.myCategoryView.frame = CGRectMake(0, 0, 120, 30);
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.cellWidth = 120/2;
    self.myCategoryView.titleFont = [UIFont systemFontOfSize:18];
    self.myCategoryView.titleColor = UIColorWithRGBA(255, 255, 255, 0.6);
    self.myCategoryView.titleSelectedColor = UIColorWithRGBA(255, 255, 255, 1);
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorWidth = 10;
    lineView.indicatorHeight = 2;
    lineView.indicatorColor = UIColorWithRGBA(255, 255, 255, 1);
    
    self.myCategoryView.indicators = @[lineView];
    [self.myCategoryView removeFromSuperview];
    self.navigationItem.titleView = self.myCategoryView;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    UIButton *avatarBtn= [[UIButton alloc] initWithFrame:contentView.bounds];
    [avatarBtn setImage:[UIImage imageNamed:@"wallhaven-oxv6gl"] forState:UIControlStateNormal];
    avatarBtn.layer.cornerRadius = 17;
    avatarBtn.layer.masksToBounds = YES;
    [contentView addSubview:avatarBtn];
    //    [avatarBtn addTarget:self action:@selector(avatarBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_qiandao"] style:0 target:self action:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.myCategoryView.frame = CGRectMake(0, 0, 120, 30);
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 0;
}


-(NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return  2;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0)
    {
        CommunityChildAVC *Avc = [CommunityChildAVC new];
        return Avc;
    }
    else
    {
        CommunityChildBVC *Bvc = [CommunityChildBVC new];
        return Bvc;
    }
    
}
@end
