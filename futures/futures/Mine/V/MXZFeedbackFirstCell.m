//
//  MXZFeedbackFirstCell.m
//  futures
//
//  Created by Francis on 2020/5/26.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZFeedbackFirstCell.h"

@interface MXZFeedbackFirstCell()
@property(strong, nonatomic) NSArray *btnArray;

@end

@implementation MXZFeedbackFirstCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        NSMutableArray *saveBtn = [NSMutableArray array];
        MXZFeedbackBtn *btnA = [[MXZFeedbackBtn alloc]init];
        [self.contentView addSubview:btnA];
        self.btnA = btnA;
        [saveBtn addObject:btnA];
        
        MXZFeedbackBtn *btnB = [[MXZFeedbackBtn alloc]init];
        [self.contentView addSubview:btnB];
        self.btnB = btnB;
        [saveBtn addObject:btnB];
        
        MXZFeedbackBtn *btnC = [[MXZFeedbackBtn alloc]init];
        [self.contentView addSubview:btnC];
        self.btnC = btnC;
        [saveBtn addObject:btnC];
        self.btnArray = saveBtn;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat lrSpace = 15;
    CGFloat btnWidth = 95;
    CGFloat btnHeight = 29;
    CGFloat centerSpace = (SCREEN_WIDTH - lrSpace*2 - btnWidth*3)/2;
    
    
    _btnA.frame = CGRectMake(lrSpace, 0, btnWidth, btnHeight);
    [self setBtnColor:_btnA];
    [_btnA addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _btnB.frame = CGRectMake(CGRectGetMaxX(_btnA.frame) + centerSpace, 0, btnWidth, btnHeight);
    [_btnB addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _btnC.frame = CGRectMake(CGRectGetMaxX(_btnB.frame) + centerSpace, 0, btnWidth, btnHeight);
    [_btnC addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 39);
}

-(void)setBtnColor:(MXZFeedbackBtn *)fBtn{
    fBtn.backgroundColor = [UIColor colorWithRed:251/255.0 green:206/255.0 blue:68/255.0 alpha:1.0];
    [fBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = fBtn.bounds;
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:251/255.0 green:206/255.0 blue:68/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:246/255.0 green:147/255.0 blue:18/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(1.0)];
//    gl.cornerRadius = 14.5;
//    //在layer底层插入
//    [fBtn.layer insertSublayer:gl atIndex:0];
}

-(void)resetBtnColor:(MXZFeedbackBtn *)fBtn{
    fBtn.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [fBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
//    [fBtn.layer.sublayers[0] removeFromSuperlayer];
}


-(void)btnClick:(MXZFeedbackBtn *)fBtn{
    for (MXZFeedbackBtn *tempBtn in _btnArray) {
        [self resetBtnColor:tempBtn];
    }
    [self setBtnColor:fBtn];
}

@end
