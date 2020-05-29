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

@end

NS_ASSUME_NONNULL_END
