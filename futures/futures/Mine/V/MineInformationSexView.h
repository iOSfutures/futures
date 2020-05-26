//
//  MineInformationSexView.h
//  futures
//
//  Created by Ssiswent on 2020/5/25.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MineInformationSexView;

@protocol MineInformationSexViewDelegate <NSObject>

@optional

- (void)mineInformationSexViewDidClickCancelBtn:(MineInformationSexView *)mineInformationSexView;
- (void)mineInformationSexViewDidClickConfirmBtn:(MineInformationSexView *)mineInformationSexView;


@end

@interface MineInformationSexView : UIView

@property (nonatomic, weak)id<MineInformationSexViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
