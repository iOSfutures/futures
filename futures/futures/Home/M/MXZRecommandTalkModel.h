//
//  MXZRecommandTalkModel.h
//  futures
//
//  Created by Francis on 2020/5/29.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MXZRecommandTalkModel : BaseModel

@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *picture;

@property (nonatomic, strong)UserModel *user;
@end

NS_ASSUME_NONNULL_END
