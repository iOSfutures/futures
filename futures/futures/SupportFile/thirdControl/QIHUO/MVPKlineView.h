//
//  MVPKlineView.h
//  testK
//
//  Created by apple on 2019/4/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKLineChart.h"
#import "QHLoctionModel.h"
#import "ZCBaseView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MVPKlineView : ZCBaseView<YKLineChartViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    NSString *futCode;
    NSString *kLineUrl;
    QHLoctionModel *loM;
    NSInteger page;
}


@property(nonatomic,strong)UICollectionView *collV;
@property(nonatomic,strong)YKLineChartView *MVPKlineView;

@property(nonatomic,copy)NSArray *kList;

-(void)getDataArr:(NSArray *)array;

-(void)setCode:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
