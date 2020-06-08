//
//  ZZHDateTableViewCell.h
//  futures
//
//  Created by apple on 2020/5/19.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuoteCalendarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZHDateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *showBtn;
@property (weak, nonatomic) IBOutlet UILabel *affectLabel;
@property (weak, nonatomic) IBOutlet UILabel *previousLabel;
@property (weak, nonatomic) IBOutlet UILabel *consensusLabel;


@property (nonatomic, strong) QuoteCalendarModel *calendarModel;

@end

NS_ASSUME_NONNULL_END
