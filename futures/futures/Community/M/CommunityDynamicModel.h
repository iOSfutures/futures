//
//  CommunityDynamicModel.h
//  futures
//
//  Created by Ssiswent on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class UserModel;

@interface CommunityDynamicModel : BaseModel


@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *picture1;
@property (nonatomic, copy)NSString *picture2;
@property (nonatomic, strong)UserModel *user;

@end

NS_ASSUME_NONNULL_END
