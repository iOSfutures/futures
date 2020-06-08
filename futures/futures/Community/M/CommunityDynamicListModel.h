//
//  CommunityTopicListModel.h
//  futures
//
//  Created by Ssiswent on 2020/6/8.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "BaseModel.h"

@class CommunityDynamicModel;

NS_ASSUME_NONNULL_BEGIN

@interface CommunityDynamicListModel : BaseModel

@property (nonatomic, assign) BOOL hasMore;

@property (nonatomic, strong) NSArray <CommunityDynamicModel*>*dynamicsArray;

@end

NS_ASSUME_NONNULL_END
