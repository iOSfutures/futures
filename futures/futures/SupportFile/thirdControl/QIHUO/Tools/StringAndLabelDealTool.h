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
@end

NS_ASSUME_NONNULL_END
