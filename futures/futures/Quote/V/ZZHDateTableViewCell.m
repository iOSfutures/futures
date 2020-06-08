//
//  ZZHDateTableViewCell.m
//  futures
//
//  Created by apple on 2020/5/19.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "ZZHDateTableViewCell.h"
#import "ZZHQuoteCalendarVC.h"


@implementation ZZHDateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setCalendarModel:(QuoteCalendarModel *)calendarModel {
    _calendarModel = calendarModel;
    if (calendarModel.affect != nil) {
        self.affectLabel.text = calendarModel.affect;
        if (calendarModel.affect != nil) {
            [self.showBtn setTitle:@"已公布" forState:UIControlStateNormal];
            self.showBtn.selected = NO;
        }
    }
    if (calendarModel.name != nil) {
        self.titleLabel.text = calendarModel.name;
    }
    if (calendarModel.time != nil) {
        NSString *timeString = calendarModel.time.description;
        //将timeString时间戳转为正常格式时间
        NSTimeInterval interval = [timeString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM:dd"];
        NSString *dateString = [formatter stringFromDate:date];
        self.timeLabel.text = dateString;
    }
    if (calendarModel.previous != nil) {
        self.previousLabel.text = calendarModel.previous;
    }
    if (calendarModel.consensus != nil) {
        self.consensusLabel.text = calendarModel.consensus;
    }

}

@end
