//
//  MXZFullDisplay.h
//  futures
//
//  Created by Francis on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXZRecommandTalkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXZFullDisplay : UIViewController
@property (strong ,nonatomic) MXZRecommandTalkModel *recommandModel;
@property (assign, nonatomic) NSInteger cellNum;
@property (copy, nonatomic) void (^shieldBlock)(NSInteger shieldNum);
@end

NS_ASSUME_NONNULL_END
