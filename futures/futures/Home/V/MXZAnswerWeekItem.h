//
//  MXZAnswerWeekItem.h
//  futures
//
//  Created by Francis on 2020/5/22.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXZAnswerWeekItem : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *engWeekLabel;
@property (weak, nonatomic) IBOutlet UILabel *chWeekLabel;
@property (weak, nonatomic) IBOutlet UILabel *isSuccessLabel;
@property (weak, nonatomic) IBOutlet UILabel *subSuccessLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

NS_ASSUME_NONNULL_END
