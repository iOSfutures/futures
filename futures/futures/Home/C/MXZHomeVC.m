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
#import "ZKCycleScrollView.h"
#import "MXZHomeFirstSectionCollectionViewCell.h"
#import "MXZFullDisplay.h"
#import <Masonry/Masonry.h>
#import "MXZSignVC.h"
#import "MXZAnswerVC.h"
#import "MXZFinanceAffairModel.h"
#import "MXZHomeThirdSectionHeadView.h"

#import "MXZHomeNavSearchView.h"
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define kScaleFrom_iPhone6_Desgin(_X_) (_X_ * (SCREEN_WIDTH/375))

@interface MXZHomeVC ()<UITableViewDelegate, UITableViewDataSource, NSURLSessionDataDelegate, ZKCycleScrollViewDelegate, ZKCycleScrollViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (strong, nonatomic) NSArray *affairsArray;
@property (strong, nonatomic) MXZHomeThirdSectionHeadView *homeThirdSectionHeadView;
@end

@implementation MXZHomeVC

- (MXZHomeThirdSectionHeadView *)homeThirdSectionHeadView
{
    if(_homeThirdSectionHeadView == nil){
        MXZHomeThirdSectionHeadView *tempView = [[MXZHomeThirdSectionHeadView alloc]init];
        _homeThirdSectionHeadView = tempView;
    }
    return _homeThirdSectionHeadView;
}

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
    [self setNavBarView];

    //为homeTableView注册cell
    [self.homeTableView registerNib:[UINib nibWithNibName:@"MXZHomeSecondSectionCell" bundle:nil] forCellReuseIdentifier:@"MXZHomeSecondSectionCell"];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"MXZHomeFourthSectionCell" bundle:nil] forCellReuseIdentifier:@"MXZHomeFourthSectionCell"];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"MXZHomeFifthSectionCell" bundle:nil] forCellReuseIdentifier:@"MXZHomeFifthSectionCell"];
    
    //去掉tableView的分割线
    self.homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSString *port = [NSString stringWithFormat:@"/admin/getFinanceAffairs?date"];
    [self getData:port];
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
    [super viewWillAppear:animated];
}

//设置navigationBar
-(void)setNavBarView{
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:254/255.0 green:162/255.0 blue:3/255.0 alpha:1.0];
    
    //导航栏搜索框
    MXZHomeNavSearchView *searchView = [[NSBundle mainBundle]loadNibNamed:@"MXZHomeNavSearchView" owner:self options:nil].firstObject;
    //参数x, y, w无效
//    searchView.frame = CGRectMake(0,9,100,27);
    searchView.subviews.firstObject.layer.cornerRadius = 12;
    searchView.subviews.firstObject.subviews.firstObject.layer.cornerRadius = 12;
    
    UIView *testView = [UIView new];
    //宽度无效
    testView.frame = CGRectMake(0, 0, SCREEN_WIDTH , 27);
    [testView addSubview:searchView];
    searchView.frame = CGRectMake((SCREEN_WIDTH - 300)/2 - 28, 0, SCREEN_WIDTH - 75, 27);
    self.navigationItem.titleView = testView;
        
    //设置首页导航栏右边的签到按钮
    UIBarButtonItem *qiandaoBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_qiandao"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationItem.rightBarButtonItem = qiandaoBtn;
    //UIBarButtonItem无法调用addTarget: action: forControlEvents:这个方法
    qiandaoBtn.target = self;
    qiandaoBtn.action = @selector(qiandaoBtnClick);
//    [self.navigationItem.rightBarButtonItem addTarget:self action:@selector(qiandaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
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

//用collectionView设置轮播图
-(void)creatCyclView:(UIView *)fView{
    UIView *tableHeaderBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    ZKCycleScrollView *cycleScrollView = [[ZKCycleScrollView alloc] initWithFrame:CGRectMake(0.f, 13, SCREEN_WIDTH, 190.f)];
    cycleScrollView.delegate = self;
    cycleScrollView.dataSource = self;
    cycleScrollView.hidesPageControl = NO;
    //banner之间的间距
    cycleScrollView.itemSpacing = ((SCREEN_WIDTH - 345.f)/2)*0.4f;
    //缩放
    cycleScrollView.itemZoomScale = 1.0;
    cycleScrollView.itemSize = CGSizeMake(345.f, cycleScrollView.bounds.size.height);
    //注册
    [cycleScrollView registerCellNib:[UINib nibWithNibName:@"MXZHomeFirstSectionCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MXZHomeFirstSectionCollectionViewCell"];
    [tableHeaderBackView addSubview:cycleScrollView];
    [fView addSubview:tableHeaderBackView];
}

- (NSInteger)numberOfItemsInCycleScrollView:(ZKCycleScrollView *)cycleScrollView
{
    return 3;
}

- (__kindof UICollectionViewCell *)cycleScrollView:(ZKCycleScrollView *)cycleScrollView cellForItemAtIndex:(NSInteger)index
{
    MXZHomeFirstSectionCollectionViewCell *cell = [cycleScrollView dequeueReusableCellWithReuseIdentifier:@"MXZHomeFirstSectionCollectionViewCell" forIndex:index];
    return cell;
}


//设置4个跳转界面按钮
-(void)setButton:(UIView *)fView{
    CGFloat spaceW = (SCREEN_WIDTH - 2*26 - 55*4)/3;
    UIButton *calendarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    calendarBtn.frame = CGRectMake(26, 296-64, 55, 54);
    [calendarBtn setImage:[UIImage imageNamed:@"ic_calendar data_home"] forState:UIControlStateNormal];
    [fView addSubview:calendarBtn];
    [calendarBtn addTarget:self action:@selector(calendarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *calendarLabel = [[UILabel alloc] init];
    calendarLabel.frame = CGRectMake(CGRectGetMinX(calendarBtn.frame), CGRectGetMaxY(calendarBtn.frame)+1, 55, 12);
    calendarLabel.text = @"日历数据";
    calendarLabel.font = [UIFont systemFontOfSize:12];
    calendarLabel.textAlignment = NSTextAlignmentCenter;
    [fView addSubview:calendarLabel];
    
    UIButton *industryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    industryBtn.frame = CGRectMake(26+55+spaceW, 296-64, 55, 54);
    [industryBtn setImage:[UIImage imageNamed:@"ic_industry storm_home"] forState:UIControlStateNormal];
    [fView addSubview:industryBtn];
    [industryBtn addTarget:self action:@selector(industryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *industryLabel = [[UILabel alloc] init];
    industryLabel.frame = CGRectMake(CGRectGetMinX(industryBtn.frame), CGRectGetMaxY(industryBtn.frame)+1, 55, 12);
    industryLabel.text = @"行业风暴";
    industryLabel.font = [UIFont systemFontOfSize:12];
    industryLabel.textAlignment = NSTextAlignmentCenter;
    [fView addSubview:industryLabel];

    UIButton *expressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    expressBtn.frame = CGRectMake(26+(55+spaceW)*2, 296-64, 55, 54);
    [expressBtn setImage:[UIImage imageNamed:@"ic_7X24 express_home"] forState:UIControlStateNormal];
    [fView addSubview:expressBtn];
    [expressBtn addTarget:self action:@selector(expressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *expressLabel = [[UILabel alloc] init];
    expressLabel.frame = CGRectMake(CGRectGetMinX(expressBtn.frame), CGRectGetMaxY(expressBtn.frame)+1, 55, 12);
    expressLabel.text = @"7X24快讯";
    expressLabel.font = [UIFont systemFontOfSize:12];
    expressLabel.textAlignment = NSTextAlignmentCenter;
    [fView addSubview:expressLabel];
    
    UIButton *quoteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quoteBtn.frame = CGRectMake(SCREEN_WIDTH-26-55, 296-64, 55, 54);
    [quoteBtn setImage:[UIImage imageNamed:@"ic_quote data_home"] forState:UIControlStateNormal];
    [fView addSubview:quoteBtn];
    [quoteBtn addTarget:self action:@selector(quoteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *quoteLabel = [[UILabel alloc] init];
    quoteLabel.frame = CGRectMake(CGRectGetMinX(quoteBtn.frame), CGRectGetMaxY(quoteBtn.frame)+1, 55, 12);
    quoteLabel.text = @"行情数据";
    quoteLabel.font = [UIFont systemFontOfSize:12];
    quoteLabel.textAlignment = NSTextAlignmentCenter;
    [fView addSubview:quoteLabel];
    
}

//跳转界面
-(void)calendarBtnClick{
    MXZHomeCalendarVC *calendarVC = [[MXZHomeCalendarVC alloc]init];
    [self.navigationController pushViewController:calendarVC animated:YES];
}

-(void)industryBtnClick{
    MXZHomeIndustryVC *industryVC = [[MXZHomeIndustryVC alloc]init];
    industryVC.affairsArray = self.affairsArray;
    industryVC.tabBarHidden = YES;
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

-(void)qiandaoBtnClick{
    MXZSignVC *signVC = [[MXZSignVC alloc]init];
    [self.navigationController pushViewController:signVC animated:YES];
}

-(void)setQiandaoBtn:(UIView *)fView{
    UIButton *qianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qianBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 338/2, 366-64, 338, 100);
    [qianBtn setImage:[UIImage imageNamed:@"qiandao_banner02_home"] forState:UIControlStateNormal];
    [fView addSubview:qianBtn];
    [qianBtn addTarget:self action:@selector(answerBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)answerBtnClick{
    MXZAnswerVC *answerVC = [[MXZAnswerVC alloc]init];
    [self.navigationController pushViewController:answerVC animated:YES];
}


#pragma mark - URLRequest
-(void)getData:(NSString *)port{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.yysc.online/%@", port]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil){
            //网络连接成功才执行
//            NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:jsonObj];
            NSArray *allArray = dict[@"data"];
            NSMutableArray *arrayObj = [NSMutableArray array];
            for (NSDictionary *affairDict in allArray) {
                MXZFinanceAffairModel *affair = [[MXZFinanceAffairModel alloc]init];
                affair.content = affairDict[@"content"];
                [arrayObj addObject:affair];
            }
            self.affairsArray = arrayObj;
        }
    }];
    
    [dataTask resume];
}

//获取财经大事数据
-(void)setAffairs{
    
    MXZFinanceAffairModel *tempModel0 = _affairsArray[0];
    MXZFinanceAffairModel *tempModel1 = _affairsArray[1];
    MXZFinanceAffairModel *tempModel2 = _affairsArray[2];
    if (tempModel0 != nil){
    self.homeThirdSectionHeadView.affairLabel0.text = tempModel0.content;
    self.homeThirdSectionHeadView.affairLabel1.text = tempModel1.content;
    self.homeThirdSectionHeadView.affairLabel2.text = tempModel2.content;
    }
    
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
//        [self setBannerView:headerView];
        [self creatCyclView:headerView];
        [self setButton:headerView];
        [self setQiandaoBtn:headerView];
        return headerView;
    }
    else if (section == 1){
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 44)];
        UIImageView *quoteImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"quick quotes_title_home"]];
        //headerView里x,y,w无效;只有h有效
        quoteImageView.frame = CGRectMake(SCREEN_WIDTH/2 - 176/2, 0, 176, 24);
        [headerView addSubview:quoteImageView];
        return headerView;
    }
    else if (section == 2){
        [self setAffairs];
        WEAKSELF
        self.homeThirdSectionHeadView.jumpBlock = ^(NSArray * _Nonnull affairArray){
            MXZHomeIndustryVC *industryVC = [[MXZHomeIndustryVC alloc]init];
            industryVC.affairsArray = affairArray;
            industryVC.tabBarHidden = YES;
            [weakSelf.navigationController pushViewController:industryVC animated:YES];
        };
        self.homeThirdSectionHeadView.affairsArray = self.affairsArray;
        return self.homeThirdSectionHeadView;
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
        return 430;
    }
    else if (section == 1){
        return 44;
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
    else if (section == 2){
        UIView *footerView = [[UIView alloc]init];
        footerView.frame = CGRectMake(0, 0, 0, 15);
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
    else if (section == 2){
        return 15;
    }
    else{
        return 0.01;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4) {
        MXZFullDisplay *titleVC = [[MXZFullDisplay alloc]init];
        [self.navigationController pushViewController:titleVC animated:YES];
    }
}

@end
