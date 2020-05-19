//
//  MXZIndustryTableViewCell.h
//  futures
//
//  Created by Francis on 2020/5/18.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXZIndustryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;

@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (assign, nonatomic) BOOL nonSubtitle;
@end

NS_ASSUME_NONNULL_END
