//
//  ZZHCollectionViewCell.m
//  futures
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "ZZHCollectionViewCell.h"
#import "UIColor+Hex.h"

#import "ZZHNewsImageModel.h"

@interface ZZHCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel;

@end

@implementation ZZHCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bottomView.backgroundColor = [UIColor colorWithHexString:@"#151723"];
}

- (void) setImageModel:(ZZHNewsImageModel *)imageModel
{
    _imageModel = imageModel;
    self.avatarImgView.image = [UIImage imageNamed:imageModel.avatarImgName];
    self.newsLabel.text = imageModel.name;
}

@end
