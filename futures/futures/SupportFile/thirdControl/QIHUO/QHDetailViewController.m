//
//  DetailViewController.m
//  FuturesPass
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 FuturesPass. All rights reserved.
//

#import "QHDetailViewController.h"
//#import "DetailNewsViewController.h"
//#import "DetaDHNewsTableViewCell.h"
#import "BusinessProcess.h"
#import "TopView.h"

#import "MVPKlineView.h"

#import "ZCManage.h"

#import "UIImage+OriginalImage.h"



//推迟执行
CG_INLINE void dispatch_queue_after_S(CGFloat time ,dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}


@interface QHDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{
    
    NSString *idStr,*nameStr,*zdf;
    
    
    UIButton *saveB;
}

@property(nonatomic,strong)UITableView *detaTab;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)TopView *topV;
@property(nonatomic,strong)MVPKlineView *klineV;

@property(nonatomic,copy)NSArray *listArr;
@property (nonatomic, strong) UIView *navBackView;



@end

@implementation QHDetailViewController


-(void)getId:(NSString *)futID{
    
    idStr = futID;
    [self.topV getDataL:futID];
    [self.klineV setCode:futID];
}

-(void)newsDate{
    
    WEAKSELF
    
    [BusinessProcess postWithPath:@"http://news.jzpyp.xyz//api/articlelist?catid=14,16,10,12,11&number=10&page=1" params:[NSDictionary dictionary] success:^(id  _Nonnull json) {
        
        weakSelf.listArr = (NSArray *)json;
        
        if (weakSelf.listArr.count == 0) {
            
            return ;
        }
        
        [weakSelf.detaTab reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
        return;
    }];
    
}

-(void)getZhangD:(float)colorType forName:(NSString *)futName{
    
    [self.view addSubview:self.detaTab];
    
    nameStr = futName;
    zdf = [NSString stringWithFormat:@"%f",colorType];
    
    self.title = nameStr;
    
//    if (colorType < 0) {
//        [super setTitle:futName titleColor:[UIColor blackColor]];
//        [super backNavigationStyle:Rise];
//    }else if (colorType > 0){
//        [super setTitle:futName titleColor:[UIColor blackColor]];
//        [super backNavigationStyle:Fall];
//    }else{
//        [super setTitle:futName titleColor:[UIColor blackColor]];
//        [super backNavigationStyle:[UIColor colorWithRed:0.296 green:0.613 blue:1.000 alpha:1.000]];
//    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back "] style:0 target:self action:@selector(backBtnClicked)];
   // [self.navigationController setNavigationBarHidden:NO];
    //    saveB = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    //    [saveB setBackgroundImage:UIImageWithName(@"J") forState:UIControlStateNormal];
    //    [saveB addTarget:self action:@selector(saveInplist) forControlEvents:UIControlEventTouchUpInside];
    //    [super setNavigationrightBtn:saveB];
//    [self setLeftButtonWithImageName:@"banner01_qoutation" bgImageName:@""];

    
    //    [self newsDate];
    //启用右滑返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)backBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveInplist{
    
    //    if (!Has_Login) {
    //        [self pushLoginVC];
    //        return;
    //    }
    
    if (_listArr.count == 0) {
        
        [SVProgressHUD  showErrorWithStatus:@"未能获取到数据，请刷新重试"];
        
        return;
        
    }
    
    if (saveB.tag == 001) {
        
        [ZCManage deleteThePlist:Option forKey:idStr];
        [saveB setBackgroundImage:UIImageWithName(@"J") forState:UIControlStateNormal];
        saveB.tag = 002;
        
        return;
    }
    
    NSMutableDictionary *saveDic = [[NSMutableDictionary alloc]init];
    
    [saveDic setObject:nameStr forKey:@"name"];
    
    [saveDic setObject:idStr forKey:@"code"];
    
    [saveDic setObject:zdf forKey:@"zdf"];
    
    [ZCManage WriteData:saveDic forKey:idStr inPlistName:Option];
    
    [saveB setBackgroundImage:UIImageWithName(@"D") forState:UIControlStateNormal];
    
    saveB.tag = 001;
}
-(void)pushLoginVC{
    //    LoginViewController *login = [[LoginViewController alloc]init];
    //    login.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:login animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    [self.navigationController setNavigationBarHidden:NO];
    [self getBackView:self.navigationController.navigationBar];
    //    if (Has_Login) {
    
    NSArray *saveArr = [[NSArray alloc]init];
    saveArr = [[ZCManage readDataThePlist:Option] allValues];
    
    for (int i = 0; i < saveArr.count; i++) {
        
        if ([idStr isEqualToString:[saveArr[i] objectForKey:@"code"]]) {
            [saveB setBackgroundImage:UIImageWithName(@"D") forState:UIControlStateNormal];
            saveB.tag = 001;
            return;
        }else{
            [saveB setBackgroundImage:UIImageWithName(@"J") forState:UIControlStateNormal];
            saveB.tag = 002;
        }
    }
    //    }
    
    
}

- (UIView *)headView{
    if (!_headView) {
        
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*1.2+10)];
        
        [_headView addSubview:self.topV];
        [_headView addSubview:self.klineV];
        
        //        [super setBorderWithView:_headView top:NO left:NO bottom:YES right:NO borderColor:BackLine borderWidth:1];
    }
    return _headView;
}

- (UITableView *)detaTab{
    if (!_detaTab) {
        _detaTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-MORE) style:UITableViewStylePlain];
        
        _detaTab.delegate = self;
        _detaTab.dataSource = self;
        
        //隐藏垂直滚动条
        _detaTab.showsVerticalScrollIndicator = NO;
        _detaTab.showsHorizontalScrollIndicator = NO;
        
        _detaTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _detaTab.tableHeaderView = self.headView;
        
        //设置回调（一旦你进入刷新状态，然后调用target的动作，即调用[self NewsData]）
        //        MJRefreshGifHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //
        //        } ];
        //        WEAKSELF
        //        _detaTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //            [weakSelf newsDate];
        //        }];
        ////    headerWithRefreshingTarget:self refreshingAction:@selector(NewsData)];
        //
        //        //设置标题
        //        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        //        [header setTitle:@"即将刷新" forState:MJRefreshStatePulling];
        //        [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
        //
        //        // 设置header
        //        _detaTab.mj_header = header;
        
        
    }
    return _detaTab;
}

-(void)NewsData{
    
    [self.topV getDataL:idStr];
    [self.klineV setCode:idStr];
    [self.detaTab reloadData];
    
    [self newsDate];
    
    WEAKSELF
    
    dispatch_queue_after_S(1, ^{
        
        [weakSelf.detaTab.mj_header endRefreshing];
        
    });
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tableViewcell = [self.detaTab dequeueReusableCellWithIdentifier:@"cellId"];
    if (tableViewcell == nil) {
        tableViewcell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    //    DetaDHNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellD"];
    //
    //    if (!cell) {
    //        cell = [[DetaDHNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellD"];
    //    }else{
    //        while ([cell.contentView.subviews lastObject] != nil) {
    //            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    //        }
    //    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //
    //
    //    tableView.rowHeight = SCREEN_WIDTH*0.25;
    //
    //
    //    cell.titleContent.lineBreakMode = NSLineBreakByTruncatingTail;
    //
    //    [cell.titleImageV sd_setImageWithURL:[NSURL URLWithString:[_listArr[indexPath.row] objectForKey:@"imgurl"]] placeholderImage:LXGetImage(@"loading")];
    //
    //    cell.titleContent.text = [_listArr[indexPath.row] objectForKey:@"title"];
    //
    //    cell.titleContent.lineBreakMode = NSLineBreakByTruncatingTail;
    //    CGSize maximumLabelSize = CGSizeMake(SCREEN_WIDTH*0.75-20, 999);//labelsize的最大值
    //    //关键语句
    //    CGSize expectSize = [cell.titleContent sizeThatFits:maximumLabelSize];
    //    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    //    cell.titleContent.frame = CGRectMake(SCREEN_WIDTH*0.03, SCREEN_WIDTH*0.03, SCREEN_WIDTH*0.75-20, expectSize.height);
    //
    //    cell.contentL.text = [NSString stringWithFormat:@"%@",[_listArr[indexPath.row] objectForKey:@"created"]];
    
    return tableViewcell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.1;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    DetailNewsViewController *detaNews = [[DetailNewsViewController alloc]init];
//    [detaNews setNewsID:[_listArr[indexPath.row] objectForKey:@"id"]];
//    [self.navigationController pushViewController:detaNews animated:YES];
//
//}


#pragma mark - ChildView

- (TopView *)topV{
    if (!_topV) {
        _topV = [[TopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.5+10)];
    }
    return _topV;
}

- (MVPKlineView *)klineV{
    if (!_klineV) {
        _klineV = [[MVPKlineView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topV.frame), SCREEN_WIDTH, SCREEN_WIDTH*0.7)];
    }
    return _klineV;
}




-(void)getBackView:(UIView*)superView

{
    
    if ([superView isKindOfClass:NSClassFromString(@"_UIBarBackground")])
        
    {
        
        _navBackView = superView;
        
        //在这里可设置背景色
        
        _navBackView.backgroundColor = [UIColor clearColor];
        
    }else if ([superView isKindOfClass:NSClassFromString(@"_UIVisualEffectSubview")])
         {
             superView.hidden = YES;
        }
    for (UIView *view in superView.subviews)
        
    {
        
        [self getBackView:view];
        
    }
}

@end
