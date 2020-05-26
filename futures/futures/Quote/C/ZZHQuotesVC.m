//
//  QuoteVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/11.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "ZZHQuotesVC.h"
#import "ZZHQuoteTimeVC.h"
#import "ZZHQuoteCalendarVC.h"
#import "ZZHQuoteIndustryVC.h"
#import "ZZHQuoteNewsVC.h"
#import "MXZHomeIndustryVC.h"

#import "UIColor+Hex.h"
#import "JXCategoryTitleView.h"

@interface ZZHQuotesVC ()
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation ZZHQuotesVC

- (void)viewDidLoad {
    self.titles = @[@"实时行情", @"日历数据", @"行业风暴", @"7x24快讯"];
    
    //设置导航条的背景图片不为空，就可以隐藏背景
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    
    [super viewDidLoad];
    
    self.myCategoryView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.cellSpacing = 32;
    self.myCategoryView.cellWidth = 68;
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
    self.myCategoryView.listContainer.contentScrollView.scrollEnabled = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.myCategoryView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
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
    return  4;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0)
    {
        ZZHQuoteTimeVC *quoteTimeVC = [ZZHQuoteTimeVC new];
        return quoteTimeVC;
    }
    else if(index == 1)
    {
        ZZHQuoteCalendarVC *quoteCalendarVC = [ZZHQuoteCalendarVC new];
        return quoteCalendarVC;
    }
    else if(index == 2)
    {
        MXZHomeIndustryVC *industryVC = [[MXZHomeIndustryVC alloc]init];
        industryVC.tabBarHidden = NO;
        return industryVC;
    }
    else
    {
        ZZHQuoteNewsVC *quoteNewsVC = [ZZHQuoteNewsVC new];
        return quoteNewsVC;
    }
    
}

@end
