//
//  HomeIndustryVC.h
//  futures
//
//  Created by Francis on 2020/5/12.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXZHomeIndustryVC : ContentBaseViewController <JXCategoryListContentViewDelegate>

@property (nonatomic, assign, getter=isTabBarHidden)BOOL tabBarHidden;

@end

NS_ASSUME_NONNULL_END
