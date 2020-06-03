//
//  ViewController.h
//  SCRBProject1
//
//  Created by zdh on 2019/6/25.
//  Copyright © 2019 zdh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentBaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : ContentBaseViewController
-(void)setTitle:(NSString *)titleName titleColor:(UIColor *)titleColor;
/**
 靠左导航标题

 @param titleName 标题名
 @param titleColor 标题颜色
 */
-(void)setLeftTitle:(NSString *)titleName titleColor:(UIColor *)titleColor;
- (void)setLeftButtonWithImageName:(NSString*)imageName bgImageName:(NSString*)bgImageName;
- (void)setRightButtonWithTitle:(NSString*)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage rect:(CGRect)rect;
-(void)setNavigationStyle:(UIColor *)NavColor;
-(void)backNavigationStyle:(UIColor *)navColor;
#pragma mark - 控件边线设置
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;
-(void)getBackView:(UIView*)superView;
-(void)leftButtonPressed:(UIButton *)btn;

@property (nonatomic, copy) void(^pushToNextVCBlcok)(BaseViewController *VC,id info);
@property (nonatomic, copy) void(^presentToNextVCBlcok)(BaseViewController *VC,id info);
-(void)showNoDataViewWithImageName:(NSString *)imageName Frame:(CGRect)frame;
-(void)hiddenNoDataView;

- (void)setRightButtonWithTitle:(NSString*)title;
-(void)rightButtonPressed:(UIButton *)btn;


#pragma mark - textFied响应
-(void)sendButtonClicked:(UIButton *)btn;
- (void)showCommentText;
-(void)showRightUserBtn;//显示右侧用户中心按钮


@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, strong) UIButton *tmptRightBtn;
@end

NS_ASSUME_NONNULL_END
