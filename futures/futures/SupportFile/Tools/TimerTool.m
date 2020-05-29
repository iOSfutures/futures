//
//  TimerTool.m
//  SCRBProject1
//
//  Created by zdh on 2019/6/29.
//  Copyright © 2019 zdh. All rights reserved.
//

#import "TimerTool.h"

@implementation TimerTool


+ (NSString *)CertaintimeWithTimeIntervalString:(NSString *)timeString{
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


+(NSString *)getTimeStringWithTimeStampString:(NSString *)timeStamp{
    if (IsEmptyStr(timeStamp)) {
        return [self getNowDate];
    }
     NSMutableString*getTime = [NSMutableString stringWithFormat:@"%@",timeStamp];
    
    [getTime deleteCharactersInRange:NSMakeRange(10,3)];
    
    NSDateFormatter *matter = [[NSDateFormatter alloc]init];
    matter.dateFormat =@"YYYY-MM-dd HH:mm";
     NSDate *date = [NSDate dateWithTimeIntervalSince1970:[getTime intValue]];
     NSString*timeStr = [matter stringFromDate:date];
    return timeStr;
}

+ (NSString *)weekdayStringWithDate:(NSDate *)date {
    //获取周几
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = [componets weekday];//1代表周日，2代表周一，后面依次
    NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSString *weekStr = weekArray[weekday-1];
    return weekStr;
}


+(NSString *)getNowDate{
    //获取当前时间日期
    NSDate *date=[[NSDate alloc]initWithTimeIntervalSinceNow:0];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    
    return dateStr;
}


+ (NSDateComponents *)getCurrentDateTimeWithDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond|NSCalendarUnitWeekday;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    return dateComponent;
}


//获取特定时间段内的日期数组
//https://www.jianshu.com/p/21a868bedd08
+ (NSArray*)getDatesWithStartDate:(NSString *)startDate endDate:(NSString *)endDate {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    
    //字符串转时间
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = TimeForMatterStr;
    NSDate *start = [matter dateFromString:startDate];
    NSDate *end = [matter dateFromString:endDate];
    
    NSMutableArray *componentAarray = [NSMutableArray array];
    NSComparisonResult result = [start compare:end];
    NSDateComponents *comps;
    while (result != NSOrderedDescending) {
        comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitWeekday fromDate:start];
        [componentAarray addObject:start];
        
        //后一天
        [comps setDay:([comps day]+1)];
        start = [calendar dateFromComponents:comps];
        
        //对比日期大小
        result = [start compare:end];
    }
    return componentAarray;
}

+(NSString *)getDateStringBeforOrAffterNowDays:(NSInteger)n{
    
    NSDate*nowDate = [NSDate date];
    
    NSDate* theDate;
    
    if(n!=0){
        
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: oneDay*n ];//initWithTimeIntervalSinceNow是从现在往前后推的秒数
        
    }else{
        
        theDate = nowDate;
    }
    
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    
    return the_date_str;
}


#pragma mark - 将某个时间转化成 时间戳

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}


@end
