//
//  QHDetailViewController.h
//  FuturesPass
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 FuturesPass. All rights reserved.
//

//#import "ZCBaseViewController.h"
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface QHDetailViewController : BaseViewController

-(void)getId:(NSString *)futID;

-(void)getZhangD:(float)colorType forName:(NSString *)futName;

@end

NS_ASSUME_NONNULL_END
