//
//  QHLoctionModel.m
//  FuturesPass
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 FuturesPass. All rights reserved.
//

#import "QHLoctionModel.h"

@implementation QHLoctionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bunnerText = @[@"国内期货",@"国际期货"];
        _bunnerImg = @[@"bunner1",@"bunner2"];
        _nameArr = @[@"开盘价",@"最高价",@"最低价",@"最新价",@"昨收价",@"委买档位",@"委卖档位",@"52周最低价",@"52周最高价"];
        _keyArr = @[@"todayStartPri",@"yestodEndPri",@"nowPri",@"todayMax",@"todayMin",@"competitivePri",@"reservePri",@"traNumber",@"traAmount"];
        
        _urlList = @[//商品金属
                     @"http://data.api51.cn/apis/integration/rank/?market_type=commodity&limit=33&order_by=desc&fields=prod_name%2Cprod_code%2Clast_px%2Cpx_change%2Cpx_change_rate%2Chigh_px%2Clow_px%2Cupdate_time&token=3f39051e89e1cea0a84da126601763d8",
                     //股指期货
                     @"http://data.api51.cn/apis/integration/rank/?market_type=index&limit=38&order_by=desc&fields=prod_name%2Cprod_code%2Clast_px%2Cpx_change%2Cpx_change_rate%2Chigh_px%2Clow_px%2Cupdate_time&token=3f39051e89e1cea0a84da126601763d8",
                     //数字货币
                     @"http://data.api51.cn/apis/integration/rank/?market_type=cryptocurrency&limit=13&order_by=desc&fields=prod_name%2Cprod_code%2Clast_px%2Cpx_change%2Cpx_change_rate%2Chigh_px%2Clow_px%2Cupdate_time&token=3f39051e89e1cea0a84da126601763d8",
                     //外汇
                     @"http://data.api51.cn/apis/integration/rank/?market_type=forex&limit=67&order_by=desc&fields=prod_name%2Cprod_code%2Clast_px%2Cpx_change%2Cpx_change_rate%2Chigh_px%2Clow_px%2Cupdate_time&token=3f39051e89e1cea0a84da126601763d8",
                     //港股
                     @"http://data.api51.cn/apis/integration/rank/?market_type=stock.HK&limit=67&order_by=desc&fields=prod_name%2Cprod_code%2Clast_px%2Cpx_change%2Cpx_change_rate%2Chigh_px%2Clow_px%2Cupdate_time&token=3f39051e89e1cea0a84da126601763d8",
                     //美股
                     @"http://data.api51.cn/apis/integration/rank/?market_type=stock.US&limit=67&order_by=desc&fields=prod_name%2Cprod_code%2Clast_px%2Cpx_change%2Cpx_change_rate%2Chigh_px%2Clow_px%2Cupdate_time&token=3f39051e89e1cea0a84da126601763d8",
                     ];
        
        _headTitle = @[@"1分",@"5分",@"10分",@"60分",@"1日"];
        _dateArr = @[@"60",@"300",@"600",@"3600",@"86400"];
        
        _apiAll = @[@"http://data.api51.cn/apis/symbol/cnfutures/?token=3f39051e89e1cea0a84da126601763d8",@"http://data.api51.cn/apis/symbol/usfutures/?token=3f39051e89e1cea0a84da126601763d8"];
        
        _allTitle = @[@"最新价",@"涨跌额",@"开盘价",@"昨收价",@"最高价",@"最低价"];
        _allKey = @[@"price",@"change",@"open",@"last",@"high",@"low"];
    }
    return self;
}


+(NSString *)tranDate:(NSString *)tran{
    
    // timeStampString 是服务器返回的13位时间戳
    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[tran doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate: date];
    
    return dateString;
}

@end
