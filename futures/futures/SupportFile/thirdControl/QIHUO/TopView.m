//
//  TopView.m
//  FuturesPass
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 FuturesPass. All rights reserved.
//

#import "TopView.h"
#import "QHDataCollectionViewCell.h"
#import "NetWork.h"
@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        loM = [[QHLoctionModel alloc]init];
        
        [self addSubview:self.headV];
        
        [self addSubview:self.dataColl];
    }
    return self;
}

-(void)getDataL:(NSString *)code{
    WEAKSELF
    [NetWork requestGet:[NSString stringWithFormat:@"http://data.api51.cn/apis/integration/real/?prod_code=%@&fields=prod_code%%2Cprod_name%%2Cupdate_time%%2Copen_px%%2Chigh_px%%2Clow_px%%2Clast_px%%2Cpreclose_px%%2Cbid_grp%%2Coffer_grp%%2Cweek_52_low%%2Cweek_52_high%%2Cpx_change%%2Cpx_change_rate%%2Cmarket_value%%2Ccirculation_value%%2Cdyn_pb_rate%%2Cdyn_pe%%2Cturnover_ratio%%2Cturnover_volume%%2Cturnover_value%%2Camplitude%%2Ctrade_status%%2Cbusiness_amount_in%%2Cbusiness_amount_out%%2Cbps&token=3f39051e89e1cea0a84da126601763d8",code] Success:^(NSDictionary * _Nonnull dic) {
        
        NSDictionary *snapshot = [[dic objectForKey:@"data"] objectForKey:@"snapshot"];
        
        self->dataArr = [snapshot objectForKey:code];
        
        [weakSelf.dataColl reloadData];
        [weakSelf setheadChildView];
    } ERROR:^(NSError * _Nonnull error) {
        
        return;
        
    }];
    
}

- (UIView *)headV{
    if (!_headV) {
        _headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.2)];
        _headV.backgroundColor = [UIColor clearColor];
        [super setBorderWithView:_headV top:NO left:NO bottom:YES right:NO borderColor:RGB(244, 244, 244) borderWidth:1.0f];
        
        lastPic = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.25, 10, SCREEN_WIDTH*0.5, SCREEN_WIDTH*0.1)];
        lastPic.textAlignment = NSTextAlignmentCenter;
        lastPic.font = NumFont(40);
        lastPic.textColor = RGB(60, 60, 60);
        [_headV addSubview:lastPic];
        
        ZDE = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lastPic.frame), SCREEN_WIDTH*0.45, SCREEN_WIDTH*0.1)];
        ZDE.textAlignment = NSTextAlignmentRight;
        ZDE.font = NumFont(18);
        ZDE.textColor = RGB(60, 60, 60);
        [_headV addSubview:ZDE];
        
        ZDF = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.55, CGRectGetMaxY(lastPic.frame), SCREEN_WIDTH*0.45, SCREEN_WIDTH*0.1)];
        ZDF.font = NumFont(18);
        ZDF.textColor = RGB(60, 60, 60);
        [_headV addSubview:ZDF];
        
        [self setheadChildView];
    }
    return _headV;
}

-(void)setheadChildView{
    
    if (dataArr.count == 0) {
        lastPic.text = @"--";
        ZDE.text = @"--";
        ZDF.text = @"--%";
    }else{
        lastPic.text = [NSString stringWithFormat:@"%.2f",[dataArr[6] floatValue]];
        ZDE.text = [NSString stringWithFormat:@"%.2f",[dataArr[12] floatValue]];
        ZDF.text = [NSString stringWithFormat:@"%.2f%%",[dataArr[13] floatValue]];
        
        if ([ZDF.text floatValue] < 0) {
            self.backgroundColor = Rise;
        }else if ([ZDF.text floatValue] > 0){
            self.backgroundColor = Fall;
        }else{
            self.backgroundColor = [UIColor whiteColor];
        }
        
    }
    
}

- (UICollectionView *)dataColl{
    if (!_dataColl) {
        //UICollectionViewLayout  --流水布局对象
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/3 , (self.frame.size.height-SCREEN_WIDTH*0.2)/3);
        //设滚动方向
        //UICollectionViewScrollDirectionVertical(垂直)
        //UICollectionViewScrollDirectionHorizontal(水平)
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置最小的行间距
        layout.minimumLineSpacing = 0;
        //设置最小的列间距
        layout.minimumInteritemSpacing = 0;
        
        _dataColl = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headV.frame), SCREEN_WIDTH, self.frame.size.height-SCREEN_WIDTH*0.2) collectionViewLayout:layout];
        
        _dataColl.backgroundColor = [UIColor clearColor];
        
        _dataColl.scrollEnabled = NO;
        
        //注册cell
        [_dataColl registerClass:[QHDataCollectionViewCell class] forCellWithReuseIdentifier:@"cellD"];
        
        //设置代理
        _dataColl.delegate = self;
        //设置数据源
        _dataColl.dataSource = self;
    }
    return _dataColl;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    QHDataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellD" forIndexPath:indexPath];
    
    cell.backgroundColor = ClearColor;
    
    cell.nameL.text = loM.nameArr[indexPath.row];
    if (dataArr.count == 0) {
        cell.contL.text = @"--";
    }else{
        if (dataArr[indexPath.row + 3]) {
             cell.contL.text = [NSString stringWithFormat:@"0.00"];
        }else{
             cell.contL.text = [NSString stringWithFormat:@"%.2f",[dataArr[indexPath.row + 3] floatValue]];
        }
       
    }
    
    
    return cell;
}

@end
