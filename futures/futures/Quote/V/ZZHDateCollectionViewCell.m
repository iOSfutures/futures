//
//  ZZHDateCollectionViewCell.m
//  futures
//
//  Created by apple on 2020/5/19.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "ZZHDateCollectionViewCell.h"
#import "ZZHQuoteCalendarVC.h"

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

-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#FEF7E7"];
        self.dateLabel.textColor = [UIColor colorWithHexString:@"#FEA203"];
        self.numLabel.textColor = [UIColor colorWithHexString:@"#FEA203"];
        UIView *pointView = [UIView new];
        pointView.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
        pointView.frame = CGRectMake(12.5, 66, 3, 3);
        [self.contentView addSubview:pointView];
    } else {
        self.contentView.backgroundColor = UIColorWithRGBA(255, 255, 255,0);
        self.dateLabel.textColor = UIColor.blackColor;
        self.numLabel.textColor = UIColor.blackColor;
        UIView *pointView = [UIView new];
        pointView.backgroundColor = UIColorWithRGBA(255, 255, 255, 0);
        
        
    }
}
@end
