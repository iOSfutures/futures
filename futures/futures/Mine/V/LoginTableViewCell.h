//
//  LoginTableViewCell.h
//  futures
//
//  Created by apple on 2020/5/29.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginTableViewCell : UITableViewCell

@property (nonatomic, copy)NSString *labelStr;
@property (nonatomic, strong)UIColor *bgColor;
@property (nonatomic, strong)UIColor *labelColor;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextF;

@property (nonatomic, assign) BOOL isPwd;
@property (weak, nonatomic) IBOutlet UIButton *forgetpwdBtn;

@property (weak, nonatomic) IBOutlet UIView *timeBgView;

@end

NS_ASSUME_NONNULL_END
