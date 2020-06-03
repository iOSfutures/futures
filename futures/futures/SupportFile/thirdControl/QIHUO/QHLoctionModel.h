//
//  QHLoctionModel.h
//  FuturesPass
//
//  Created by apple on 2019/5/31.
//  Copyright © 2019 FuturesPass. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QHLoctionModel : NSObject

@property(nonatomic,strong)NSArray *bunnerText,*bunnerImg,*nameArr,*keyArr,*urlList,*headTitle,*dateArr,*apiAll,*allTitle,*allKey;

+(NSString *)tranDate:(NSString *)tran;

@end

NS_ASSUME_NONNULL_END
