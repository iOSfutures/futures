//
//  MXZHomeFifthSectionCell.h
//  futures
//
//  Created by Francis on 2020/5/15.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXZRecommandTalkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXZHomeFifthSectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentPic;
@property (strong, nonatomic) MXZRecommandTalkModel *recommandModel;
@end

NS_ASSUME_NONNULL_END
