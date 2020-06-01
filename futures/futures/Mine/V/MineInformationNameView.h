//
//  MineInformationView.h
//  futures
//
//  Created by Ssiswent on 2020/5/25.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MineInformationNameView;

@protocol MineInformationNameViewDelegate <NSObject>

@optional

- (void)mineInformationNameViewDidClickCancelBtn:(MineInformationNameView *)mineInformationNameView;
- (void)mineInformationNameViewDidClickConfirmBtn:(MineInformationNameView *)mineInformationNameView changedName:(NSString *)changedName;

@end

@interface MineInformationNameView : UIView

@property (nonatomic, weak)id<MineInformationNameViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
