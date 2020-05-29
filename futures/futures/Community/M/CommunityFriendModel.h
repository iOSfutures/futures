//
//  CommunityFriendModel.h
//  futures
//
//  Created by Ssiswent on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommunityFriendModel : BaseModel

@property (nonatomic, copy)NSString *head;
@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, copy)NSString *signature;
@property (nonatomic, assign, getter=isFollowed)BOOL followed;

@end

NS_ASSUME_NONNULL_END
