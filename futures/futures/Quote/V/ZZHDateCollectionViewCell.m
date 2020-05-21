//
//  ZZHDateCollectionViewCell.m
//  futures
//
//  Created by apple on 2020/5/19.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "ZZHDateCollectionViewCell.h"

@implementation ZZHDateCollectionViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//自定义CollectionViewCell只会调用此方法,不会调用init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        self.dateLabel.text = @"一";
        
        self.numLabel.text = @"01";
    }
    return self;
}
@end
