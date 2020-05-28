//
//  MXZHomeThirdSectionHeadView.m
//  futures
//
//  Created by Francis on 2020/5/28.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZHomeThirdSectionHeadView.h"

@implementation MXZHomeThirdSectionHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self = [[NSBundle mainBundle]loadNibNamed:@"MXZHomeThirdSectionHeadView" owner:self options:nil].firstObject;
    if (self) {
        self.frame = frame;
    }
    return self;
}

@end
