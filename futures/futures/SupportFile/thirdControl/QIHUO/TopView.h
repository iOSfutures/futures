//
//  TopView.h
//  FuturesPass
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 FuturesPass. All rights reserved.
//

#import "ZCBaseView.h"
#import "QHLoctionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopView : ZCBaseView<UICollectionViewDelegate,UICollectionViewDataSource>{
    QHLoctionModel *loM;
    NSArray *dataArr;
    UILabel *lastPic,*ZDE,*ZDF;
}

@property(nonatomic,strong)UIView *headV;

@property(nonatomic,strong)UICollectionView *dataColl;

-(void)getDataL:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
