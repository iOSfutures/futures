//
//  MIneCodeView.h
//  futures
//
//  Created by Ssiswent on 2020/6/1.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MineCodeView;

@protocol MineCodeViewDelegate <NSObject>

@optional

- (void)MineCodeViewDidClickCancelBtn:(MineCodeView *)mineCodeView;
- (void)MineCodeViewDidClickConfirmBtn:(MineCodeView *)mineCodeView inputCode:(NSString *)inputCode;
- (void)MineCodeViewDidClickChangeBtn:(MineCodeView *)mineCodeView;
- (void)MineCodeViewDidClickCodeImgView:(MineCodeView *)mineCodeView;

@end

@interface MineCodeView : UIView

@property (nonatomic, weak)id<MineCodeViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *codeImgView;

@end

NS_ASSUME_NONNULL_END
