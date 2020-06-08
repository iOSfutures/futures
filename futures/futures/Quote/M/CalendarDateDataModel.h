//
//  CalendarDateDataModel.h
//  SCRBProject1
//
//  Created by zdh on 2019/7/2.
//  Copyright © 2019 zdh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class DateModel;

@interface CalendarDateDataModel : BaseModel

/**
 数组第一位元素表示起始 第二位表示结束
 */
@property (nonatomic, strong) NSArray <NSString *>*DateRangeArr;

@property (nonatomic, strong) NSMutableArray <DateModel *>*dateList;

@property (nonatomic, strong) DateModel *nowDay;
/**
 初始化方法

 @param arr 范围arr
 @return 返回值
 */
-(instancetype)initWithDateRangeArr:(NSArray<NSString *>*)arr;
@end



@interface DateModel : BaseModel

@property (nonatomic, copy) NSString *second;
@property (nonatomic, copy) NSString *minute;
@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *weakDay;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, strong) NSDateComponents *comps;
@property (nonatomic, copy) NSString *endTimeString;

@property (nonatomic, copy) NSString *startTimeString;

@property (nonatomic, assign) NSInteger beforNowDays;
@property (nonatomic, assign) NSInteger affterNowDays;


@property (nonatomic, assign) BOOL selected;

@property (nonatomic, copy) void(^selectBlock)(BOOL selected);
-(void)now;
-(void)otherTimeString:(NSString *)timeString;




@end
NS_ASSUME_NONNULL_END
