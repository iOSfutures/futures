//
//  ZCManage.m
//

#import "ZCManage.h"

@implementation ZCManage

#pragma mark - plist文件存储类
+(void)WriteData:(NSMutableDictionary *)dataDic forKey:(NSString *)key inPlistName:(NSString *)plistName{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePatch = [path stringByAppendingPathComponent:plistName];
    
    NSMutableDictionary *saveDic;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePatch]) {
        saveDic = [[NSMutableDictionary alloc]init];
    }else{
        saveDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePatch];
    }
    
    [saveDic setObject:dataDic forKey:key];
    
    BOOL tf = [saveDic writeToFile:filePatch atomically:YES];
    
}

+(NSMutableDictionary *)readDataThePlist:(NSString *)plistName{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePatch = [path stringByAppendingPathComponent:plistName];
    
    NSMutableDictionary *dataDic;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePatch]) {
        dataDic = [[NSMutableDictionary alloc]init];
    }else{
        dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePatch];
    }
    
    return dataDic;
}

+(void)deleteThePlist:(NSString *)plistName forKey:(NSString *)key{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:plistName];
    
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    [dataDic removeObjectForKey:key];
    
    [dataDic writeToFile:plistPath atomically:YES];
}


#pragma mark - 图片存储类
+(void)saveImage:(UIImage *)image inSandboxPath:(NSString *)path{
    
    // 创建文件管理对象
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    //拿到图片
    UIImage *imagesave = image;
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_sandox stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",path]];
    // 用来判断要创建的文件是否存在
    BOOL isHave = [fileManage fileExistsAtPath:imagePath];
    if (isHave) {
        //路径下存在该文件则删除原文件
        BOOL isSuccess = [fileManage removeItemAtPath:imagePath error:nil];
    }
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(imagesave) writeToFile:imagePath atomically:YES];
    
}

+(UIImage *)getSandboxImage:(NSString *)path{
    
    // 读取沙盒路径图片
    NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),path];
    
    // 创建文件管理对象
    NSFileManager *fileManage = [NSFileManager defaultManager];
    // 用来判断要创建的文件是否存在
    BOOL isHave = [fileManage fileExistsAtPath:aPath3];
    
    if (!isHave) {
        //文件不存在则返回空image
        return [[UIImage alloc]init];
        
    }
    
    // 拿到沙盒路径图片
    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
    
    return imgFromUrl3;
}

+(void)deleteSandboxImage:(NSString *)path{
    // 创建文件管理对象
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_sandox stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",path]];
    // 用来判断要创建的文件是否存在
    BOOL isHave = [fileManage fileExistsAtPath:imagePath];
    if (isHave) {
        //路径下存在该图片则删除该图片
        BOOL isSuccess = [fileManage removeItemAtPath:imagePath error:nil];
    }
}


#pragma mark - 常用工具类
+ (NSString *) getweekDayStringWithDate:(NSDate *) date{
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    // 1 是周日，2是周一 3.以此类推
    NSNumber * weekNumber = @([comps weekday]);
    
    NSInteger weekInt = [weekNumber integerValue];
    
    NSString *weekDayString = @"(周一)";
    
    switch (weekInt) {
        case 1:{
            weekDayString = @"(周日)";
        }
            break;
            
        case 2:{
            weekDayString = @"(周一)";
        }
            break;
            
        case 3:{
            weekDayString = @"(周二)";
        }
            break;
            
        case 4:{
            weekDayString = @"(周三)";
        }
            break;
            
        case 5:{
            weekDayString = @"(周四)";
        }
            break;
            
        case 6:{
            weekDayString = @"(周五)";
        }
            break;
            
        case 7:{
            weekDayString = @"(周六)";
        }
            break;
            
        default:
            break;
    }
    return weekDayString;
}

+ (BOOL)isNumber:(NSString *)strValue
{
    if (strValue == nil || [strValue length] <= 0)
    {
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (![strValue isEqualToString:filtered])
    {
        return NO;
    }
    return YES;
}

+ (BOOL)checkIsChinese:(NSString *)string{
    for (int i=0; i<string.length; i++) {
        unichar ch = [string characterAtIndex:i];
        if (0x4E00 <= ch  && ch <= 0x9FA5) {
            return YES;
        }
    }
    return NO;
}

+(NSString *)getDate:(NSInteger)type{
    
    //获取当前时间日期
    NSDate *date = [NSDate date];
    
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    
    switch (type) {
        case 0:{
            NSTimeInterval a = [date timeIntervalSince1970];
            
            NSString *timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
            
            return timeString;
        }
            break;
            
        case 1:
            [format1 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            break;
            
        case 2:
            [format1 setDateFormat:@"yyyy-MM-dd hh:mm"];
            break;
            
        case 3:
            [format1 setDateFormat:@"yyyy-MM-dd hh"];
            break;
            
        case 4:
            [format1 setDateFormat:@"yyyy-MM-dd"];
            break;
            
        case 5:
            [format1 setDateFormat:@"yyyy-MM"];
            break;
            
        case 6:
            [format1 setDateFormat:@"yyyy"];
            break;
            
        case 7:
            [format1 setDateFormat:@"MM"];
            break;
            
        case 8:
             [format1 setDateFormat:@"hh:mm:ss"];
            break;
            
        case 9:
            [format1 setDateFormat:@"hh:mm"];
            break;
            
        default:
            break;
    }
    
    NSString *dateStr;
    
    dateStr = [format1 stringFromDate:date];
    
    return dateStr;
}

+(NSString *)arcIntNumber:(int)fromNum toSome:(int)toNum{
    
    int x = arc4random() % (toNum - fromNum + 1) + fromNum;
    
    return [NSString stringWithFormat:@"%d",x];
}

+(NSString *)arcFloatNumber:(float)fromNum toSome:(float)toNum{
    
    int startVal = fromNum*1000000;
    
    int endVal = toNum*1000000;
    
    int randomValue = startVal +(arc4random()%(endVal - startVal));
    
    float num = (float)randomValue/1000000;
    
    return [NSString stringWithFormat:@"%f",num];
    
}

//正则去除网络标签
+(NSString *)getZZwithString:(NSString *)string{
    
    NSRegularExpression *regularExpretion = [NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n" options:0 error:nil];
    
    string = [regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    
    return string;
}

@end
