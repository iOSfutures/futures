//
//  ZZHTimeLineTableViewCell.m
//  futures
//
//  Created by apple on 2020/5/22.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "ZZHTimeLineTableViewCell.h"
#import "CommunityTopicModel.h"

@interface ZZHTimeLineTableViewCell ()

@end

@implementation ZZHTimeLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //    self.topLine.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setQuoteNewModel:(QuoteNewModel *)quoteNewModel {
    
    if (quoteNewModel.time != nil) {
        NSString *timeString = quoteNewModel.time.description;
        //将timeString时间戳转为正常格式时间
        NSTimeInterval interval = [timeString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM月dd"];
        NSString *dateString = [formatter stringFromDate:date];
        
        NSString *month = [dateString substringWithRange:NSMakeRange(0, 3)];
        NSString *day = [dateString substringWithRange:NSMakeRange(3, 2)];
        self.dayLabel.text = day;
        self.monthLabel.text = month;
    }
    if (quoteNewModel.content != nil) {
        self.newsLabel.text = quoteNewModel.content;
    }
}

@end
