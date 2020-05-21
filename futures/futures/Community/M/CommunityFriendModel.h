//
//  CommunityFriendModel.h
//  futures
//
//  Created by Ssiswent on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommunityFriendModel : NSObject

@property (nonatomic, copy)NSString *avatarImgName;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *descript;
@property (nonatomic, assign, getter=isFollowed)BOOL followed;

@end

NS_ASSUME_NONNULL_END
