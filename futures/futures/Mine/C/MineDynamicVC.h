//
//  MineDynamicVC.h
//  futures
//
//  Created by Ssiswent on 2020/5/21.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UserModel;

@interface MineDynamicVC : UIViewController

@property (nonatomic, copy)NSString *avatarStr;
@property (nonatomic, copy)NSString *nameStr;
@property (nonatomic, copy)NSString *signatureStr;
@property (nonatomic, copy)NSString *followCountStr;
@property (nonatomic, copy)NSString *fanCountStr;

@end

NS_ASSUME_NONNULL_END
