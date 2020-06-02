//
//  MVPKlineView.m
//  testK
//
//  Created by apple on 2019/4/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MVPKlineView.h"
#import "QHDHHeadCollectionViewCell.h"
#import "NetWork.h"
@implementation MVPKlineView


-(void)setCode:(NSString *)code{
    
    futCode = code;
    page = 0;
    loM = [[QHLoctionModel alloc]init];
    [self setClass:@"60"];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.collV];
        
    }
    return self;
}

-(void)setClass:(NSString *)type{
    
    [SVProgressHUD  show];
    
    kLineUrl = [NSString stringWithFormat:@"http://data.api51.cn/apis/integration/kline/?prod_code=%@&period_type=%@&tick_count=100&fields=tick_at%%2Copen_px%%2Cclose_px%%2Chigh_px%%2Clow_px%%2Cturnover_volume%%2Cturnover_value%%2Cpx_change%%2Cpx_change_rate&token=3f39051e89e1cea0a84da126601763d8",futCode,type];
    
//    NSLog(@"%@",kLineUrl);
    
    WEAKSELF
    
    [NetWork requestGet:kLineUrl Success:^(NSDictionary * _Nonnull dic) {
        
        [SVProgressHUD dismiss];
        
        NSDictionary *data = [dic objectForKey:@"data"];
        
        NSDictionary *candle = [data objectForKey:@"candle"];
        
        NSDictionary *codeDic = [candle objectForKey:self->futCode];
        
        weakSelf.kList = [codeDic objectForKey:@"lines"];
        
        if (weakSelf.kList.count == 0) {
            
            [SVProgressHUD  showErrorWithStatus:@"请求失败，请刷新重试"];
            
            return;
        }
        
        [self getDataArr:weakSelf.kList];
        
    } ERROR:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD  showErrorWithStatus:@"网络开小差了，在刷新试试😢"];
    }];
}

#pragma mark - 选择
- (UICollectionView *)collV{
    
    if (!_collV) {
        
        //UICollectionViewLayout  --流水布局对象
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/5 , 40);
        //设滚动方向
        //UICollectionViewScrollDirectionVertical(垂直)
        //UICollectionViewScrollDirectionHorizontal(水平)
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置最小的行间距
        layout.minimumLineSpacing = 0;
        //设置最小的列间距
        layout.minimumInteritemSpacing = 0;
        
        _collV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) collectionViewLayout:layout];
        
        _collV.backgroundColor = [UIColor whiteColor];
        
        _collV.scrollEnabled = NO;
        
        _collV.allowsMultipleSelection = NO;
        
        //注册cell
        [_collV registerClass:[QHDHHeadCollectionViewCell class] forCellWithReuseIdentifier:@"cellH"];
        
        //设置代理
        _collV.delegate = self;
        //设置数据源
        _collV.dataSource = self;
        
        [super setBorderWithView:_collV top:YES left:NO bottom:YES right:NO borderColor:BackLine borderWidth:1.0];
        
    }
        
    return _collV;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    QHDHHeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellH" forIndexPath:indexPath];
    
    cell.titleL.text = loM.headTitle[indexPath.row];
    
    if (page == indexPath.row) {
        
        cell.lineView.hidden = NO;
        
    }else{
        
        cell.lineView.hidden = YES;
        
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self setClass:loM.dateArr[indexPath.row]];
    
    page = indexPath.row;
    
    [self.collV reloadData];
    
}

#pragma mark - 写入k线数据，添加k线图

-(void)getDataArr:(NSArray *)array{
    
    [self.MVPKlineView removeFromSuperview];
    
    self.MVPKlineView = [[YKLineChartView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_WIDTH*0.7-40)];
    
    [self addSubview:self.MVPKlineView];
    
    self.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray * arrays = [NSMutableArray array];
    
    for (int i = 0; i < array.count ; i++) {
        
        YKLineEntity * entity = [[YKLineEntity alloc]init];
        entity.open = [array[i][0] doubleValue];//开盘价
        entity.close = [array[i][1] doubleValue];//收盘价
        entity.high = [array[i][2] doubleValue];//最高价
        entity.low = [array[i][3] doubleValue];//最低价
        entity.volume = [array[i][5] doubleValue];//成交量
        
        
        entity.ma5 = [array[i][0] floatValue];//5天平均值
        entity.ma10 = [array[i][2] floatValue];//10天平均值
        entity.ma20 = [array[i][3] doubleValue];//20天平均值
        
        entity.date = [QHLoctionModel tranDate:[NSString stringWithFormat:@"%@",array[i][7]]];//时间
        
        [arrays addObject:entity];
    }
    
    [arrays addObjectsFromArray:arrays];
    
    YKLineDataSet * dataset = [[YKLineDataSet alloc]init];
    dataset.data = arrays;
    dataset.highlightLineColor = LabelColor;//选中线
    dataset.highlightLineWidth = 0.7;
    dataset.candleRiseColor = Rise;//涨
    dataset.candleFallColor = Fall;//跌
    dataset.avgLineWidth = 1.f;
    dataset.avgMA10Color = [UIColor colorWithRed:252/255.0 green:85/255.0 blue:198/255.0 alpha:1.0];//十日平均线
    dataset.avgMA5Color = [UIColor colorWithRed:67/255.0 green:85/255.0 blue:109/255.0 alpha:1.0];//五日平均线
    dataset.avgMA20Color = [UIColor colorWithRed:216/255.0 green:192/255.0 blue:44/255.0 alpha:1.0];//20日平均线
    dataset.candleTopBottmLineWidth = 1;
    
    [self.MVPKlineView setupChartOffsetWithLeft:50 top:10 right:10 bottom:10];
    self.MVPKlineView.gridBackgroundColor = [UIColor whiteColor];//格子背景色
    self.MVPKlineView.borderColor = [UIColor colorWithRed:203/255.0 green:215/255.0 blue:224/255.0 alpha:1.0];//网格线颜色
    self.MVPKlineView.borderWidth = .5;//网格线宽度0.5
    self.MVPKlineView.candleWidth = 10;//当天对应线的宽度
    self.MVPKlineView.candleMaxWidth = 30;//最大宽度
    self.MVPKlineView.candleMinWidth = 1;//最小宽度
    self.MVPKlineView.uperChartHeightScale = 0.8;//超图表高度比例
    self.MVPKlineView.xAxisHeitht = 25;
    self.MVPKlineView.delegate = self;
    self.MVPKlineView.highlightLineShowEnabled = YES;
    self.MVPKlineView.zoomEnabled = YES;
    self.MVPKlineView.scrollEnabled = YES;
    [self.MVPKlineView setupData:dataset];
    
}

-(void)chartValueSelected:(YKViewBase *)chartView entry:(id)entry entryIndex:(NSInteger)entryIndex{
    
}

- (void)chartValueNothingSelected:(YKViewBase *)chartView{
    
}

- (void)chartKlineScrollLeft:(YKViewBase *)chartView{
    
}

@end
