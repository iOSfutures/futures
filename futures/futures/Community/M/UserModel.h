//
//  UserModel.h
//  futures
//
//  Created by Ssiswent on 2020/5/28.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : BaseModel

@property (nonatomic, copy)NSString *head;
@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, strong)NSNumber *followCount;
@property (nonatomic, strong)NSNumber *fansCount;
@property (nonatomic, copy)NSString *signature;
@property (nonatomic, strong)NSNumber *userId;

@end

NS_ASSUME_NONNULL_END
