//
//  MXZFullFourthSectionCell.h
//  futures
//
//  Created by Francis on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXZDiscussModel.h"
#import "UserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MXZFullFourthSectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) MXZDiscussModel *discussModel;


@end

NS_ASSUME_NONNULL_END
