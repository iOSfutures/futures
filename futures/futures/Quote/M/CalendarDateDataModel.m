
//
//  CalendarDateDataModel.m
//  SCRBProject1
//
//  Created by zdh on 2019/7/2.
//  Copyright © 2019 zdh. All rights reserved.
//

#import "CalendarDateDataModel.h"

@implementation CalendarDateDataModel

-(instancetype)initWithDateRangeArr:(NSArray<NSString *>*)arr{
    self = [super init];
    if (self) {
        _DateRangeArr = arr;
        _dateList = @[].mutableCopy;
        [self getDateList];
    }
    return self;
}


-(void)getDateList{
    NSArray *dateArr = [TimerTool getDatesWithStartDate:_DateRangeArr[0] endDate:_DateRangeArr[1]];
    DateModel *nowModel = [DateModel new];
    [nowModel now];
    for (NSDate *date in dateArr) {
        DateModel *model = [DateModel new];
        model.date = date;
        [_dateList addObject:model];
        if ([nowModel.year isEqualToString: model.year] && [nowModel.month isEqualToString: model.month] && [nowModel.day isEqualToString: model.day]) {
            _nowDay = model;
            model.selected = YES;
        }
    }
}

@end

@implementation DateModel
-(instancetype)init{
    self = [super init];
    [self addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    return self;
}
-(void)setDate:(NSDate *)date{
    if (_date != date) {
        _date = date;
    }
    NSDateComponents * comps = [TimerTool getCurrentDateTimeWithDate:date];
    
    [self getPropertyWithComps:comps];
}

-(void)now{
    NSDateFormatter *dateFormatterStr = [[NSDateFormatter alloc]init];
    [dateFormatterStr setDateFormat:TimeForMatterStr];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    self.date = date;
    [self getPropertyWithComps:[TimerTool getCurrentDateTimeWithDate:date]];
}

-(void)otherTimeString:(NSString *)timeString{
    if (timeString.length == 16) {
        timeString = [NSString stringWithFormat:@"%@:00",timeString];
    }
    NSDateFormatter *dateFormatterStr = [[NSDateFormatter alloc]init];
    [dateFormatterStr setDateFormat:TimeForMatterStr];
    NSDate *date = [dateFormatterStr dateFromString:timeString];
    [self getPropertyWithComps:[TimerTool getCurrentDateTimeWithDate:date]];
}

-(void)getPropertyWithComps:(NSDateComponents*)comps{
    self.comps = comps;
    self.year = [NSString stringWithFormat:@"%ld",comps.year];
    self.month = [NSString stringWithFormat:@"%ld",comps.month];
    self.day = [NSString stringWithFormat:@"%ld",comps.day];
    self.hour = [NSString stringWithFormat:@"%ld",comps.hour];
    self.minute = [NSString stringWithFormat:@"%ld",comps.minute];
    self.second = [NSString stringWithFormat:@"%ld",comps.second];
    NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSString *weekStr = weekArray[comps.weekday-1];
    self.weakDay = weekStr;
}

-(void)setDay:(NSString *)day{
    if (day.integerValue <10) {
        day = [NSString stringWithFormat:@"0%ld",day.integerValue];
    }
    _day = day;
}
-(void)setMonth:(NSString *)month{
    if (month.integerValue < 10) {
        month = [NSString stringWithFormat:@"0%ld",month.integerValue];
    }
    _month = month;
}

-(void)setHour:(NSString *)hour{
    if (hour.integerValue < 10) {
        hour = [NSString stringWithFormat:@"0%ld",hour.integerValue];
    }
    _hour = hour;
}

-(void)setMinute:(NSString *)minute{
    if (minute.integerValue < 10) {
        minute = [NSString stringWithFormat:@"0%ld",minute.integerValue];
    }
    _minute = minute;
}
-(void)setSecond:(NSString *)second{
    if (second.integerValue < 10) {
        second = [NSString stringWithFormat:@"0%ld",second.integerValue];
    }
    _second = second;
}

-(NSString *)endTimeString{
    NSString *endTime;
    if (_affterNowDays ==0) {
        endTime = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",_year,_month,_day,_hour,_minute,_second];
    }else {
        endTime = [TimerTool getDateStringBeforOrAffterNowDays:15];
    }
  
    return endTime;
}
-(NSString *)startTimeString{
    NSString *startTime;
    if (_beforNowDays == 0) {
        startTime = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",_year,_month,@"01",@"00",@"00",@"00"];
    }else{
        startTime = [TimerTool getDateStringBeforOrAffterNowDays:-_beforNowDays];
    }
    return startTime;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    DLog(@"%@",change);
    if (_selectBlock) {
        _selectBlock([change[@"new"] boolValue]);
    }
}






@end

