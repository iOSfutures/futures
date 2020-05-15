//
//  HomeVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/11.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZHomeVC.h"
#import "MXZHomeCalendarVC.h"
#import "MXZHomeIndustryVC.h"
#import "MXZHomeExpressVC.h"
#import "MXZHomeQuoteVC.h"
#import "MXZHomeSecondSectionCell.h"
#import "MXZHomeFourthSectionCell.h"
#import "MXZHomeFifthSectionCell.h"
#import "UIImage+OriginalImage.h"
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define kScaleFrom_iPhone6_Desgin(_X_) (_X_ * (SCREEN_WIDTH/375))

@interface MXZHomeVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@end

@implementation MXZHomeVC

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
                        imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kScaleFrom_iPhone6_Desgin(74));
                    }
                    else if (SCREEN_WIDTH == 414)
                    {
                        imageView.frame = CGRectMake(0, -20, SCREEN_WIDTH, kScaleFrom_iPhone6_Desgin(74));
                    }
                    imageView.image = [UIImage imageNamed:@"background_tob"];
                    [subView addSubview:imageView];
                }
            }];
        }
    }];
    

    //为homeTableView注册cell
    [self.homeTableView registerNib:[UINib nibWithNibName:@"MXZHomeSecondSectionCell" bundle:nil] forCellReuseIdentifier:@"MXZHomeSecondSectionCell"];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"MXZHomeFourthSectionCell" bundle:nil] forCellReuseIdentifier:@"MXZHomeFourthSectionCell"];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"MXZHomeFifthSectionCell" bundle:nil] forCellReuseIdentifier:@"MXZHomeFifthSectionCell"];
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
    searchView.frame = CGRectMake(0,9,300,27);
    searchView.backgroundColor = [UIColor colorWithRed:254/255.0 green:247/255.0 blue:231/255.0 alpha:1.0];
    //设置边角弧度
    searchView.layer.cornerRadius = 12;
    searchView.placeholder = @"数字货币";
    
//    self.navigationItem.titleView.alignmentRectInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchView];
    
    
    UIBarButtonItem *qiandaoBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_qiandao"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationItem.rightBarButtonItem = qiandaoBtn;
}

//设置轮播图
-(void)setBannerView:(UIView *)fView{
    CGFloat bannerW = 345;//单个banner宽度
    CGFloat bannerH = 190;
    CGFloat bannerRimW = 9;
    CGFloat bannerViewW = [UIScreen mainScreen].bounds.size.width;//banner的frame的宽度
    CGFloat bannerSpaceW = ([UIScreen mainScreen].bounds.size.width - bannerW - 2 * bannerRimW)/2;
    
    //轮播图
    UIScrollView *bannerScrollView = [[UIScrollView alloc]init];
    bannerScrollView.frame = CGRectMake(0, 13, bannerViewW, bannerH);
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
    
    [fView addSubview:bannerScrollView];
    
    bannerScrollView.pagingEnabled = YES;
    
    //    UIPageControl *pageControl = [[UIPageControl alloc]init];
    //    pageControl.numberOfPages = bannerCount;
    
}

//设置4个跳转界面按钮
-(void)setButton:(UIView *)fView{
    UIButton *calendarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    calendarBtn.frame = CGRectMake(26, 296-64, 55, 54);
    [calendarBtn setImage:[UIImage imageNamed:@"ic_calendar data_home"] forState:UIControlStateNormal];
    [fView addSubview:calendarBtn];
    [calendarBtn addTarget:self action:@selector(calendarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *industryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    industryBtn.frame = CGRectMake(113.5, 296-64, 55, 54);
    [industryBtn setImage:[UIImage imageNamed:@"ic_industry storm_home"] forState:UIControlStateNormal];
    [fView addSubview:industryBtn];
    [industryBtn addTarget:self action:@selector(industryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *expressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    expressBtn.frame = CGRectMake(204, 296-64, 55, 54);
    [expressBtn setImage:[UIImage imageNamed:@"ic_7X24 express_home"] forState:UIControlStateNormal];
    [fView addSubview:expressBtn];
    [expressBtn addTarget:self action:@selector(expressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *quoteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quoteBtn.frame = CGRectMake(294, 296-64, 55, 54);
    [quoteBtn setImage:[UIImage imageNamed:@"ic_quote data_home"] forState:UIControlStateNormal];
    [fView addSubview:quoteBtn];
    [quoteBtn addTarget:self action:@selector(quoteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

//跳转界面
-(void)calendarBtnClick{
    MXZHomeCalendarVC *calendarVC = [[MXZHomeCalendarVC alloc]init];
    [self.navigationController pushViewController:calendarVC animated:YES];
}

-(void)industryBtnClick{
    MXZHomeIndustryVC *industryVC = [[MXZHomeIndustryVC alloc]init];
    [self.navigationController pushViewController:industryVC animated:YES];
}

-(void)expressBtnClick{
    MXZHomeExpressVC *expressVC = [[MXZHomeExpressVC alloc]init];
    [self.navigationController pushViewController:expressVC animated:YES];
}

-(void)quoteBtnClick{
    MXZHomeQuoteVC *quoteVC = [[MXZHomeQuoteVC alloc]init];
    [self.navigationController pushViewController:quoteVC animated:YES];
}

-(void)setQiandaoBtn:(UIView *)fView{
    UIButton *qianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qianBtn.frame = CGRectMake(15.5, 386-64, 338.5, 101);
    [qianBtn setImage:[UIImage imageNamed:@"qiandao_banner02_home"] forState:UIControlStateNormal];
    [fView addSubview:qianBtn];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 1){
        return 4;
    }
    else if(section == 3){
        return 1;
    }
    else if (section == 4){
        return 1;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
        static NSString *cellID = @"MXZHomeSecondSectionCell";
        MXZHomeSecondSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil){
            cell = [[NSBundle mainBundle] loadNibNamed:@"MXZHomeSecondSectionCell" owner:self options:nil].firstObject;
        }
        return cell;
    }
    else if(indexPath.section == 3){
        static NSString *cellID = @"MXZHomeFourthSectionCell";
        MXZHomeFourthSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil){
            cell = [[NSBundle mainBundle] loadNibNamed:@"MXZHomeFourthSectionCell" owner:self options:nil].firstObject;
        }
        return cell;
    }
    else if(indexPath.section == 4){
        static NSString *cellID = @"MXZHomeFifthSectionCell";
        MXZHomeFifthSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil){
            cell = [[NSBundle mainBundle] loadNibNamed:@"MXZHomeFifthSectionCell" owner:self options:nil].firstObject;
        }
        return cell;
    }
    
    else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        return 107;
    }
    else if(indexPath.section == 3){
        return 190;
    }
    else if(indexPath.section == 4){
        return 90;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 450)];
        [self setBannerView:headerView];
        [self setButton:headerView];
        [self setQiandaoBtn:headerView];
        return headerView;
    }
    else if (section == 1){
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 24)];
        UIImageView *quoteImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"quick quotes_title_home"]];
        //headerView里x,y,w无效;只有h有效
        quoteImageView.frame = CGRectMake(100, 0, 176, 24);
        [headerView addSubview:quoteImageView];
        return headerView;
    }
    else if (section == 2){
        UIView *headerView = [[NSBundle mainBundle]loadNibNamed:@"MXZHomeThirdSectionHeadView" owner:self options:nil].firstObject;
        return headerView;
    }
    else if (section == 3 || section == 4){
        UIView *headerView = [[NSBundle mainBundle]loadNibNamed:@"MXZHomeFourthSectionHeadView" owner:self options:nil].firstObject;
        return headerView;
    }
    else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 450;
    }
    else if (section == 1){
        return 24;
    }
    else if (section == 2){
        return 57;
    }
    else if (section == 3 || section == 4){
        return 40;
    }
    else{
        return 0;
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section == 1){
        UIView *footerView = [[NSBundle mainBundle] loadNibNamed:@"MXZHomeSecondSectionFootView" owner:self options:nil].firstObject;
        return footerView;
    }
    else{
        return nil;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 1){
        return 44;
    }
    else{
        return 0.01;
    }
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
