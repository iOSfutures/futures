//
//  TimerTool.h
//  SCRBProject1
//
//  Created by zdh on 2019/6/29.
//  Copyright © 2019 zdh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerTool : NSObject

+ (NSString *)CertaintimeWithTimeIntervalString:(NSString *)timeString;

/**
 根据时间戳进行时间字符串计算

 @param timeStamp 时间戳字符串
 @return r返回值
 */
+(NSString *)getTimeStringWithTimeStampString:(NSString *)timeStamp;
/**
 判断日期是周几

 @param date <#date description#>
 @return <#return value description#>
 */
+ (NSString *)weekdayStringWithDate:(NSDate *)date;
/**
 获取当前时间

 @return <#return value description#>
 */
+(NSString *)getNowDate;


/**
 获取 NSDateComponents 时间

 @param date 时间date
 @return 返回
 */
+ (NSDateComponents *)getCurrentDateTimeWithDate:(NSDate *)date;
/**
 获取特定时间段内的时间数组

 @param startDate 起始时间
 @param endDate 结束时间
 @return 返回
 */
+ (NSArray*)getDatesWithStartDate:(NSString *)startDate endDate:(NSString *)endDate;
+(NSString *)getDateStringBeforOrAffterNowDays:(NSInteger)n;
/**
 字符串转时间戳

 @param formatTime 字符串时间
 @param format 日期格式
 @return 返回
 */
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
@end

NS_ASSUME_NONNULL_END
