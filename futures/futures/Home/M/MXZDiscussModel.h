//
//  MXZDiscussModel.h
//  futures
//
//  Created by Francis on 2020/6/2.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class UserModel;

@interface MXZDiscussModel : BaseModel
@property (nonatomic, copy)NSString *content;
@property (nonatomic, strong)UserModel *user;
@end

NS_ASSUME_NONNULL_END
