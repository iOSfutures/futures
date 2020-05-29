//
//  StringAndLabelDealTool.h
//  SCRBProject1
//
//  Created by zdh on 2019/6/27.
//  Copyright © 2019 zdh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StringAndLabelDealTool : NSObject
+(NSAttributedString *)setPlaceHolderWithFont:(CGFloat)font Color:(UIColor *)color Text:(NSString *)text;
//输入字符串以及固定高度 获得宽度
+(float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height;

//输入字符串以及固定宽度 获得高度
+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
@end

NS_ASSUME_NONNULL_END
