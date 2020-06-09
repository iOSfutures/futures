//
//  MXZFeedbackSecondCell.h
//  futures
//
//  Created by Francis on 2020/5/26.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXZFeedbackSecondCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *addPicBtn;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *picImage;

@property (copy, nonatomic) void (^textBlock)(NSString *);
@property (copy, nonatomic) void (^addImgBlock)(MXZFeedbackSecondCell *selfCell);

@end

NS_ASSUME_NONNULL_END
