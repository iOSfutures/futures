//
//  MXZSignPopView.m
//  futures
//
//  Created by Francis on 2020/5/21.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZSignPopView.h"

@interface MXZSignPopView ()

@end

@implementation MXZSignPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *tempView = [[NSBundle mainBundle]loadNibNamed:@"MXZSignPopView" owner:self options:nil].firstObject;
        [self addSubview:tempView];
    }
    return self;
}



@end
