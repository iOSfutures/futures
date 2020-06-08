//
//  QuoteNewModel.h
//  futures
//
//  Created by apple on 2020/6/8.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuoteNewModel : BaseModel

@property (nonatomic, copy)NSString *content;
@property (nonatomic, assign)NSNumber *time;
@property (nonatomic, assign)NSNumber *daytime;

@end

NS_ASSUME_NONNULL_END
