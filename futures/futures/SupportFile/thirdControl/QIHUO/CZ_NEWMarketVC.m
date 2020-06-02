//
//  CZ_NEWMarketVC.m
//  QiHuoDemoA
//
//  Created by ox Ho on 2019/6/28.
//  Copyright © 2019 ShuoChao. All rights reserved.
//

#import "CZ_NEWMarketVC.h"
//#import "MVPBunnerView.h"
#import "ZCMakeTableViewCell.h"
//#import "KTDropdownMenuView.h"
#import "QHDetailViewController.h"
#import "QHLoctionModel.h"
#import "QHDetailViewController.h"
#import "NetWork.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define ColorBlue [UIColor colorWithRed:113/255.0 green:103/255.0 blue:252/255.0 alpha:1/1.0]
@interface CZ_NEWMarketVC ()<UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate>{
    QHLoctionModel *loM;
    
    NSInteger pageIndex;
    
}

@property(nonatomic,strong)UITableView *makeTbv;
//@property(nonatomic,strong)MVPBunnerView *headBunner;
@property(nonatomic,copy)NSArray *dataArr;

@property (nonatomic, strong) UIView *navBackView;
@end

@implementation CZ_NEWMarketVC
static NSString *cellid = @"cellID";
#pragma mark - 懒加载主视图列表
- (UITableView *)makeTbv{
    if (!_makeTbv) {
        _makeTbv = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _makeTbv.delegate = self;
        _makeTbv.dataSource = self;
        _makeTbv.backgroundColor = [UIColor colorWithHexString:@"#FEF7E7"];
//        _makeTbv.backgroundColor = TNColor.main_bg_color;
//        _makeTbv.backgroundColor = RGB(0, 0, 0);
        //隐藏垂直滚动条
        _makeTbv.showsVerticalScrollIndicator = NO;
        _makeTbv.showsHorizontalScrollIndicator = NO;
        //除掉UITableView分割线
        _makeTbv.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        _makeTbv.tableHeaderView = self.headBunner;
        
        //设置回调（一旦你进入刷新状态，然后调用target的动作，即调用[self NewsData]）
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(NewsData)];
        
        //设置标题
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"即将刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
        
        // 设置header
        _makeTbv.mj_header = header;
    }
    return _makeTbv;
}
#pragma mark - 列表子控件
//- (MVPBunnerView *)headBunner{
//    if (!_headBunner) {
//        _headBunner = [[MVPBunnerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.4)];
//    }
//    return _headBunner;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view bringSubviewToFront:self.makeTbv];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];
//    [self getBackView:self.navigationController.navigationBar];
    _dataArr = [NSArray array];
    loM = [[QHLoctionModel alloc]init];
    
//    self.navigationController.navigationBar.hidden = YES;
    
    self.title = _navTitle;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FEF7E7"];
    pageIndex = 2;

    [self.view addSubview:self.makeTbv];
    [self.makeTbv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(10);
        if ([self->_navTitle isEqualToString:@"实时行情"]) {
           
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kSafeBottomHeight);
        }else{
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);
        }
    }];
    self.title = @"行情列表";
//    [self.view addSubview:self.topDown];
    
//    [super backNavigationStyle:RGB(150, 174, 255)];
//    [super setTitle:_navTitle titleColor:UIColorFromRGB(0xFFFFFF)];
//    if ([_navTitle isEqualToString:@"行情"]) {
//         [self setLeftButtonWithImageName:@"" bgImageName:@""];
//    }else{
//
//
//    }
//    [self setLeftButtonWithImageName:@"back_white" bgImageName:@""];
//    self.title = @"行情";
    [self regetData:loM.urlList[2]];
    
//    http://data.api51.cn/apis/integration/rank/?market_type=index&limit=38&order_by=desc&fields=prod_name%2Cprod_code%2Clast_px%2Cpx_change%2Cpx_change_rate%2Chigh_px%2Clow_px%2Cupdate_time&token=3f39051e89e1cea0a84da126601763d8
//    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGB(255, 255, 255)] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = nil;
    
}
- (UIImage*)createImageWithColor:(UIColor*)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.whiteColor}];
    self.tabBarController.delegate = self;


//    [self navigationSetUp];

}

#pragma mark - 数据请求
//
//-(void)navigationSetUp{
//    NSArray *titles = @[@"商品金属", @"股指期货", @"数字货币", @"外汇"];
//    KTDropdownMenuView *menuView = [[KTDropdownMenuView alloc] initWithFrame:CGRectMake(0, 0,100, 44) titles:titles];
//
//    WS(weakSelf);
//
//    menuView.selectedAtIndex = ^(int index){
//        self->pageIndex = index;
//        [weakSelf regetData:self->loM.urlList[index]];
//
//    };
//
//    menuView.width = SCREEN_WIDTH;
//    self.navigationItem.titleView = menuView;
//
//}
//进入界面的请求，带加载样式
-(void)regetData:(NSString *)URLStr{
    
    [SVProgressHUD show];
    
    WEAKSELF
    
    [NetWork requestGet:URLStr Success:^(NSDictionary * _Nonnull dic) {
        STRONGSELF
        [strongSelf.makeTbv.mj_header endRefreshing];
        
        [SVProgressHUD dismiss];
        
        NSDictionary *dataD = [dic objectForKey:@"data"];
        
        strongSelf.dataArr = [NSArray arrayWithArray:(NSArray *)dataD[@"candle"]];
        
        if (strongSelf.dataArr.count == 0) {
            [Toast makeText:self.view Message:@"请求失败，请刷新重试" afterHideTime:DELAYTiME];
            [SVProgressHUD  showWithStatus:@"请求失败，请刷新重试"];
            return;
        }
        [strongSelf.makeTbv reloadData];
        
    } ERROR:^(NSError * _Nonnull error) {
        STRONGSELF
        [strongSelf.makeTbv.mj_header endRefreshing];
        [SVProgressHUD dismiss];
//         [Toast makeText:self.view Message:@"网络开小差了，在刷新试试😢" afterHideTime:DELAYTiME];
//        [SVProgressHUD  showWithStatus:@"网络开小差了，在刷新试试😢"];
        
    }];
}
#pragma mark - UItableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZCMakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[ZCMakeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    tableView.rowHeight = SCREEN_WIDTH*0.2;
    
    cell.nameL.text = _dataArr[indexPath.row][0];
    cell.codeL.text = _dataArr[indexPath.row][1];
    
    
    
    cell.picL.text = [NSString stringWithFormat:@"%.2f",[_dataArr[indexPath.row][2] floatValue]];
    cell.changeL.text = [NSString stringWithFormat:@"%.2f%%",[_dataArr[indexPath.row][4] floatValue]];
    cell.changeL.textColor = UIColor.whiteColor;
    if ([cell.changeL.text floatValue] < 0) {
        cell.backV.backgroundColor = defaltColor;
        cell.changeL.backgroundColor = Rise;
    }else if ([cell.changeL.text floatValue] > 0){
        cell.backV.backgroundColor = defaltColor;
        cell.changeL.backgroundColor = Fall;
    }else{
        cell.backV.backgroundColor = [UIColor whiteColor];
        cell.changeL.backgroundColor = LabelColor;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QHDetailViewController *detailVC = [[QHDetailViewController alloc]init];

    [detailVC getId:_dataArr[indexPath.row][1]];

    [detailVC getZhangD:[_dataArr[indexPath.row][4] floatValue] forName:_dataArr[indexPath.row][0]];

    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];//创建一个视图
    
    headerView.backgroundColor = [UIColor colorWithHexString:@"#FEF7E7"];
    
//    [super setBorderWithView:headerView top:NO left:NO bottom:YES right:NO borderColor:RGB(230, 230, 230) borderWidth:0.5];
    
    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, 0, SCREEN_WIDTH*0.3, 40)];
    nameL.font = NameBFont(13);
    nameL.textColor = RGB(188, 196, 224);
    [headerView addSubview:nameL];
    
    UILabel *priceL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameL.frame), 0, SCREEN_WIDTH*0.2, 40)];
    priceL.font = NameBFont(13);
    priceL.textAlignment = NSTextAlignmentRight;
    priceL.textColor = RGB(188, 196, 224);
    [headerView addSubview:priceL];
    
    UILabel *chgL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceL.frame), 0, SCREEN_WIDTH*0.3, 40)];
    chgL.textAlignment = NSTextAlignmentRight;
    chgL.font = NameBFont(13);
    chgL.textColor = RGB(188, 196, 224);
    [headerView addSubview:chgL];
    
    nameL.text = @"名称/编码";
    priceL.text = @"最新价";
    chgL.text = @"涨跌幅";
    
    return headerView;
    
}
-(void)NewsData{
    
    [self regetData:loM.urlList[pageIndex]];
    
}

-(void)getBackView:(UIView*)superView

{

    if ([superView isKindOfClass:NSClassFromString(@"_UIBarBackground")])
        
    {
        _navBackView = superView;
        
        //在这里可设置背景色
        
        _navBackView.backgroundColor = RGB(27, 27, 27);
        
    }else if ([superView isKindOfClass:NSClassFromString(@"_UIVisualEffectSubview")])
    {
        superView.hidden = YES;
    }
    for (UIView *view in superView.subviews)
        
    {
        [self getBackView:view];
    }
}
- (UIView *)listView{
    return self.view;
}
//-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
//    if (index == 3) {
//        FZN_STUserManager *manger = [FZN_STUserManager defaults];
//        if (!manger.isLogin) {
//            FZN_STUserLoginViewController *vc = [FZN_STUserLoginViewController new];
//            [self.navigationController pushViewController:vc animated:YES];
//            return NO;
//        }
//    }
//    return YES;
//}
@end
