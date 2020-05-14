//
//  HomeVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/11.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "HomeVC.h"
#import "HomeCalendarVC.h"
#import "HomeIndustryVC.h"
#import "HomeExpressVC.h"
#import "HomeQuoteVC.h"

@interface HomeVC ()
@property(nonatomic, weak) UIScrollView *homeScrollView;
@property(nonatomic, weak) UITextField *searchView;
@property(nonatomic, weak) UIImageView *qiandaoImage;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //不使用系统TabBar设置背景图片的方式来设置图片
    [self getBackView:self.tabBarController.tabBar getViewBlock:^(UIView *subView) {
        if ([subView isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            [self getBackView:subView getViewBlock:^(UIView *view) {
                
                if ([view isKindOfClass:NSClassFromString(@"UIImageView")]) {
                    [view removeFromSuperview];
                    UIImageView *imageView = [UIImageView new];
                    if(SCREEN_WIDTH == 375)
                    {
                        imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kScaleFrom_iPhone8_Width(74));
                    }
                    else if (SCREEN_WIDTH == 414)
                    {
                        imageView.frame = CGRectMake(0, -20, SCREEN_WIDTH, kScaleFrom_iPhone8_Width(74));
                    }
                    imageView.image = [UIImage imageNamed:@"background_tob"];
                    [subView addSubview:imageView];
                }
            }];
        }
    }];
    
    UIScrollView *homeScrollView = [[UIScrollView alloc]init];
    homeScrollView.frame = [UIScreen mainScreen].bounds;
    homeScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1575);
    homeScrollView.backgroundColor = [UIColor redColor];
    self.homeScrollView = homeScrollView;
    [self.view addSubview:homeScrollView];
    NSLog(@"homeScrollView---%@", NSStringFromCGRect(homeScrollView.frame));
    NSLog(@"homeScrollView---%@", NSStringFromCGSize(homeScrollView.contentSize));
    
    
    [self setBannerView];
    
    [self setButton];
    
}

-(void)getBackView:(UIView*)superView getViewBlock:(void(^)(UIView *view))Blcok

{
    if (Blcok) {
        Blcok(superView);
    }
    
    for (UIView *view in superView.subviews)
    {
        [self getBackView:view getViewBlock:Blcok];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self setNavBarView];
}

//设置navigationBar
-(void)setNavBarView{
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:254/255.0 green:162/255.0 blue:3/255.0 alpha:1.0];
    //{{0, 0}, {375, 44}}    NSLog(@"%@", NSStringFromCGRect(self.navigationController.navigationBar.frame));
    
    //导航栏搜索框
    UITextField *searchView = [[UITextField alloc] init];
    searchView.frame = CGRectMake(15.5,9,300,27);
    searchView.backgroundColor = [UIColor colorWithRed:254/255.0 green:247/255.0 blue:231/255.0 alpha:1.0];
    //设置边角弧度
    searchView.layer.cornerRadius = 12;
    searchView.placeholder = @"数字货币";
    self.searchView = searchView;
    [self.navigationController.navigationBar addSubview:searchView];
    
    //导航栏右边签到图片
    UIImageView *qiandaoImage = [[UIImageView alloc]init];
    qiandaoImage.frame = CGRectMake(340.5, 12.5, 19.5, 20.5);
    qiandaoImage.image = [UIImage imageNamed:@"ic_qiandao"];
    self.qiandaoImage = qiandaoImage;
    [self.navigationController.navigationBar addSubview:qiandaoImage];
    //44    NSLog(@"%d", (int) self.navigationController.navigationBar.frame.size.height);
}

//设置轮播图
-(void)setBannerView{
    CGFloat bannerW = 345;//单个banner宽度
    CGFloat bannerH = 190;
    CGFloat bannerRimW = 9;
    CGFloat bannerViewW = [UIScreen mainScreen].bounds.size.width;//banner的frame的宽度
    CGFloat bannerSpaceW = ([UIScreen mainScreen].bounds.size.width - bannerW - 2 * bannerRimW)/2;
    //6    NSLog(@"%d",(int)bannerSpaceW);
    
    //轮播图
    UIScrollView *bannerScrollView = [[UIScrollView alloc]init];
    bannerScrollView.frame = CGRectMake(0, 13, bannerViewW, bannerH);
    NSLog(@"bannerScrollView---%@", NSStringFromCGRect(bannerScrollView.frame));
    bannerScrollView.backgroundColor = [UIColor whiteColor];
    
    //添加轮播图图片
    int bannerCount = 3;
    for(int i=0; i<bannerCount; i++){
        UIImageView *bannerImageView = [[UIImageView alloc] init];
        bannerImageView.image = [UIImage imageNamed:@"banner01_home"];
        bannerImageView.frame = CGRectMake(i * (bannerW + bannerSpaceW), 0, bannerW + bannerSpaceW, bannerH);
        [bannerScrollView addSubview:bannerImageView];
    }
    
    bannerScrollView.contentSize = CGSizeMake(bannerCount * (bannerW + bannerSpaceW), 190);
    //{1053, 190}    NSLog(@"%@", NSStringFromCGSize(bannerScrollView.contentSize));
    //{{0, 67}, {375, 190}}    NSLog(@"%@", NSStringFromCGRect(bannerScrollView.frame));
    
    [self.homeScrollView addSubview:bannerScrollView];
    
    bannerScrollView.pagingEnabled = YES;
    
    //    UIPageControl *pageControl = [[UIPageControl alloc]init];
    //    pageControl.numberOfPages = bannerCount;
    
}

-(void)setButton{
    UIButton *calendarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    calendarBtn.frame = CGRectMake(26, 276-64, 55, 54);
    [calendarBtn setImage:[UIImage imageNamed:@"ic_calendar data_home"] forState:UIControlStateNormal];
    [self.homeScrollView addSubview:calendarBtn];
    [calendarBtn addTarget:self action:@selector(calendarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *industryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    industryBtn.frame = CGRectMake(113.5, 276-64, 55, 54);
    [industryBtn setImage:[UIImage imageNamed:@"ic_industry storm_home"] forState:UIControlStateNormal];
    [self.homeScrollView addSubview:industryBtn];
    [industryBtn addTarget:self action:@selector(industryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *expressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    expressBtn.frame = CGRectMake(204, 276-64, 55, 54);
    [expressBtn setImage:[UIImage imageNamed:@"ic_7X24 express_home"] forState:UIControlStateNormal];
    [self.homeScrollView addSubview:expressBtn];
    [expressBtn addTarget:self action:@selector(expressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *quoteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quoteBtn.frame = CGRectMake(294, 276-64, 55, 54);
    [quoteBtn setImage:[UIImage imageNamed:@"ic_quote data_home"] forState:UIControlStateNormal];
    [self.homeScrollView addSubview:quoteBtn];
    [quoteBtn addTarget:self action:@selector(quoteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

//跳转界面
-(void)calendarBtnClick{
    [self.searchView removeFromSuperview];
    [self.qiandaoImage removeFromSuperview];
    HomeCalendarVC *calendarVC = [[HomeCalendarVC alloc]init];
    [self.navigationController pushViewController:calendarVC animated:YES];
}

-(void)industryBtnClick
{
    [self.searchView removeFromSuperview];
    [self.qiandaoImage removeFromSuperview];
    HomeIndustryVC *industryVC = [[HomeIndustryVC alloc]init];
    [self.navigationController pushViewController:industryVC animated:YES];
}

-(void)expressBtnClick
{
    [self.searchView removeFromSuperview];
    [self.qiandaoImage removeFromSuperview];
    HomeExpressVC *expressVC = [[HomeExpressVC alloc]init];
    [self.navigationController pushViewController:expressVC animated:YES];
}

-(void)quoteBtnClick
{
    [self.searchView removeFromSuperview];
    [self.qiandaoImage removeFromSuperview];
    HomeQuoteVC *quoteVC = [[HomeQuoteVC alloc]init];
    [self.navigationController pushViewController:quoteVC animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
