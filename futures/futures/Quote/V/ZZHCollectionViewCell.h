//
//  ZZHCollectionViewCell.h
//  futures
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZZHNewsImageModel;

@interface ZZHCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic)ZZHNewsImageModel *imageModel;

@end

NS_ASSUME_NONNULL_END
