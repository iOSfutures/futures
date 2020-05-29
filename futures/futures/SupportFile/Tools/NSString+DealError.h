//
//  NSString+DealError.h
//  SCRBProject1
//
//  Created by zdh on 2019/6/25.
//  Copyright © 2019 zdh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DealError)
- (NSString *)fileAppend:(NSString *)appendStr;
- (NSString *)isNullClassOrNot;
- (NSString *)decodeFromPercentEscapeString: (NSString *) input;
- (BOOL)isHaveIllegalChar:(NSString *)str;
- (BOOL)isChinese;
- (BOOL)includeChinese;
@end

NS_ASSUME_NONNULL_END
