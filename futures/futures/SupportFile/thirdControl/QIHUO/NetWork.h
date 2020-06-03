//
//  NetWork.h
//  STOCKS
//
//  Created by apple on 2019/4/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HttpSuccess)(NSDictionary *dic);
typedef void(^HttpFailure)(NSError *error);

@interface NetWork : NSObject

+(void)requestGet:(NSString *)path Success:(HttpSuccess)allData ERROR:(HttpFailure)errorL;

@end

NS_ASSUME_NONNULL_END
