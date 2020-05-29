//
//  StringAndLabelDealTool.m
//  SCRBProject1
//
//  Created by zdh on 2019/6/27.
//  Copyright © 2019 zdh. All rights reserved.
//

#import "StringAndLabelDealTool.h"

@implementation StringAndLabelDealTool

+(NSAttributedString *)setPlaceHolderWithFont:(CGFloat)font Color:(UIColor *)color Text:(NSString *)text{
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:text attributes:@{
                                                                                                  NSForegroundColorAttributeName:color,
                                                                                                  NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    return attrString;
}


//获取字符串的宽度
+(float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];
    //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.width;
    
}
//获得字符串的高度
+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
    
}


@end
