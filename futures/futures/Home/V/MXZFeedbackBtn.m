//
//  MXZFeedbackBtn.m
//  futures
//
//  Created by Francis on 2020/5/26.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZFeedbackBtn.h"

@implementation MXZFeedbackBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        MXZFeedbackBtn *selfBtn = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
        selfBtn.frame = frame;
        self = selfBtn;
        self.layer.cornerRadius = 14.5;
        
        self.layer.shadowColor = [UIColor colorWithRed:135/255.0 green:175/255.0 blue:214/255.0 alpha:0.2].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,0);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 8;
    }
    return self;
}

@end
