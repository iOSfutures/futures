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
#import "ZJScrollPageView.h"

#import <ZJScrollPageView/ZJScrollPageView.h>

@interface CommunityVC ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;
@property (weak, nonatomic) ZJScrollSegmentView *segmentView;
@property (weak, nonatomic) ZJContentView *contentView;


@property (nonatomic, strong) UIView *customizedStatusBar;

@end

@implementation CommunityVC

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
//    UIButton *avatarBtn= [[UIButton alloc] initWithFrame:contentView.bounds];
//    [avatarBtn setImage:[UIImage imageNamed:@"wallhaven-oxv6gl"] forState:UIControlStateNormal];
//    avatarBtn.layer.cornerRadius = 22;
//    avatarBtn.layer.masksToBounds = YES;
//    [contentView addSubview:avatarBtn];
//    //    [avatarBtn addTarget:self action:@selector(avatarBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
//    self.navigationItem.leftBarButtonItem = barButtonItem ;
////        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:avatarBtn];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"效果示例";

    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.childVcs = [self setupChildVc];
    // 初始化
    [self setupSegmentView];
    [self setupContentView];
    
    //设置导航条的背景图片不为空，就可以隐藏背景
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = UIColorWithRGBA(254, 162, 3, 1);
    
}

- (void)setupSegmentView {
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
   // style.showCover = YES;
    // 不要滚动标题, 每个标题将平分宽度
    style.scrollTitle = NO;
    style.showLine = YES;
    style.scrollContentView = NO;
    style.scrollLineColor = [UIColor whiteColor];
    //标题一般状态颜色 --- 注意一定要使用RGB空间的颜色值
    style.normalTitleColor = UIColorWithRGBA(255, 255, 255, 0.6);
    //标题选中状态颜色 --- 注意一定要使用RGB空间的颜色值
    style.selectedTitleColor = UIColorWithRGBA(255, 255, 255, 1);
    
    self.titles = @[@"社区", @"关注"];
    
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 64.0, 160.0, 28.0) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
        
    }];
    
    self.segmentView = segment;
    self.navigationItem.titleView = self.segmentView;
    
}

- (void)setupContentView {
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:self.contentView];
    
}

- (NSArray *)setupChildVc {
    
    CommunityChildAVC *childAVC = CommunityChildAVC.new;
    childAVC.view.backgroundColor = [UIColor systemTealColor];
    CommunityChildBVC *childBVC = CommunityChildBVC.new;
    childBVC.view.backgroundColor = [UIColor greenColor];
    
    NSArray *childVcs = [NSArray arrayWithObjects:childBVC, childAVC, nil];
    return childVcs;
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = self.childVcs[index];
    }
    
    return childVc;
}


-(CGRect)frameOfChildControllerForContainer:(UIView *)containerView {
    return  CGRectInset(containerView.bounds, 20, 20);
}

@end
