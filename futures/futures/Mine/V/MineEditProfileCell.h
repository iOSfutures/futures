//
//  MineEditProfileCell.h
//  futures
//
//  Created by Ssiswent on 2020/5/27.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UserModel,MineEditProfileCell;

@protocol MineEditProfileCellDelegate <NSObject>

@optional

- (void)mineEditProfileCellDidEndEditing:(MineEditProfileCell *)mineEditProfileCell changedSignature:(NSString *)changedSignature;

@end

@interface MineEditProfileCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *signatureTextF;

@property (nonatomic, strong)UserModel *user;

@property (nonatomic, weak)id<MineEditProfileCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
