//
//  CZ_NEWMarketVC.h
//  QiHuoDemoA
//
//  Created by ox Ho on 2019/6/28.
//  Copyright © 2019 ShuoChao. All rights reserved.
//

//#import "ZCBaseViewController.h"

#import "BaseViewController.h"
//#import "ZJScrollPageViewDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZ_NEWMarketVC :BaseViewController<JXCategoryListContentViewDelegate>

// <ZJScrollPageViewChildVcDelegate>

@property (nonatomic, copy) NSString *navTitle;
@end

NS_ASSUME_NONNULL_END
