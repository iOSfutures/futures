//
//  QuoteCalendarVC.h
//  futures
//
//  Created by apple on 2020/5/14.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZHQuoteCalendarVC : ContentBaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, assign, getter=isTabBarHidden)BOOL tabBarHidden;

@end

NS_ASSUME_NONNULL_END
