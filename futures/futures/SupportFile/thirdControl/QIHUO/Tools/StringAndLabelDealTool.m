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
@end
