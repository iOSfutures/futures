//
//  SigninModel.h
//  SCRBProject1
//
//  Created by zdh on 2019/7/3.
//  Copyright © 2019 zdh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class signinLittleModel;
@interface SigninModel : BaseModel

@property (nonatomic, strong) NSMutableArray <signinLittleModel *>*dataList;


@end

@class DateModel;
@interface signinLittleModel : BaseModel
@property (nonatomic, strong) NSNumber *continueTimes;

@property (nonatomic, strong) NSNumber *modelId;

@property (nonatomic, strong) NSNumber *timeStamp;

@property (nonatomic, strong) NSNumber *userId;

@property (nonatomic, strong) DateModel *date;

//continueTimes = 1;
//id = 24;
//time = 1562147304000;
//userId = 102;
@end

NS_ASSUME_NONNULL_END
