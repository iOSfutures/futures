//
//  ZCBaseView.h
//  test
//
//  Created by apple on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCBaseView : UIView

- (UIViewController *)viewController;

//控件边线
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;



@end

NS_ASSUME_NONNULL_END
