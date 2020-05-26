//
//  ZZHTimeLineTableViewCell.h
//  futures
//
//  Created by apple on 2020/5/22.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZHTimeLineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel;

@end

NS_ASSUME_NONNULL_END
