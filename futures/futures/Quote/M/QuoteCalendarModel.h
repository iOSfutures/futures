//
//  QuoteCalendarModel.h
//  futures
//
//  Created by apple on 2020/6/6.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuoteCalendarModel : BaseModel
@property (nonatomic, copy)NSString *affect;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *previous;
@property (nonatomic, copy)NSString *consensus;
@property (nonatomic, assign)NSNumber *star;
@property (nonatomic, assign)NSNumber *time;
//@property (nonatomic, assign)NSNumber *id;

@end

NS_ASSUME_NONNULL_END
