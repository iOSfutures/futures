//
//  ZCManage.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZCManage : NSObject

#pragma mark - plist文件存储类

/*
 存入新数据
 dataDic：需要存的数据
 key：数据的key
 plistName：存的plist文件的名称
*/
+(void)WriteData:(NSMutableDictionary *)dataDic forKey:(NSString *)key inPlistName:(NSString *)plistName;

/*
 读取数据
 plistName：读取的plist文件的名称
 */
+(NSMutableDictionary *)readDataThePlist:(NSString *)plistName;

/*
 删除某条数据
 key：需要删除的数据的key
 plistName：指定plist文件的名称
 */
+(void)deleteThePlist:(NSString *)plistName forKey:(NSString *)key;


#pragma mark - 图片存储类
/*
 存图片
 image：需要存的图片
 path：存储的名称
 */
+(void)saveImage:(UIImage *)image inSandboxPath:(NSString *)path;

/*
 获取路径下的图片
 path：图片的名称
 */
+(UIImage *)getSandboxImage:(NSString *)path;

/*
 删除路径下的图片
 path：图片的名称
 */
+(void)deleteSandboxImage:(NSString *)path;


#pragma mark - 常用工具类
/*
 获取时间为周几
 date：需要判断的时间
*/
+(NSString *)getweekDayStringWithDate:(NSDate *)date;

/*
 判断字符串是否是纯数字形式
 strValue：需要判断的字符串
 */
+(BOOL)isNumber:(NSString *)strValue;

/*
 判断字符串是否带有汉字
 string：需要判断的字符串
 */
+(BOOL)checkIsChinese:(NSString *)string;

/*
 获取当前时间
 type：返回形式--
 0 - 当前时间戳
 1 - yyyy-MM-dd hh:mm:ss（年-月-日 时:分:秒）
 2 - yyyy-MM-dd hh:mm（年-月-日 时:分）
 3 - yyyy-MM-dd hh（年-月-日 时）
 4 - yyyy-MM-dd（年-月-日）
 5 - yyyy-MM（年-月）
 6 - yyyy（年）
 7 - MM（月）
 8 - hh:mm:ss（时:分:秒）
 9 - hh:mm（时:分）
 */
+(NSString *)getDate:(NSInteger)type;

/*
 随机整数
 fromNum：区间头
 toNum：区间尾
 */
+(NSString *)arcIntNumber:(int)fromNum toSome:(int)toNum;

/*
 随机小数（返回小数点后六位）
 fromNum：区间头
 toNum：区间尾
 */
+(NSString *)arcFloatNumber:(float)fromNum toSome:(float)toNum;


+(NSString *)getZZwithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
