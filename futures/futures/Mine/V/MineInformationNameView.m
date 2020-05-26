//
//  MineInformationView.m
//  futures
//
//  Created by Ssiswent on 2020/5/25.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MineInformationNameView.h"

@interface MineInformationNameView()
@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation MineInformationNameView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
    
    [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#FEA203"] forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    
    [_cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"#FDF0DA"]];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,CGRectGetWidth(_confirmBtn.frame),CGRectGetHeight(_confirmBtn.frame));
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:252/255.0 green:189/255.0 blue:38/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:88/255.0 blue:33/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0f),@(1.0f)];
    [_confirmBtn.layer addSublayer:gl];
}

- (IBAction)cancelBtnClicked:(id)sender {
    if([self.delegate respondsToSelector:@selector(mineInformationNameViewDidClickCancelBtn:)])
    {
        [self.delegate mineInformationNameViewDidClickCancelBtn:self];
    }
}
- (IBAction)confirmBtnClicked:(id)sender {
    if([self.delegate respondsToSelector:@selector(mineInformationNameViewDidClickCancelBtn:)])
    {
        [self.delegate mineInformationNameViewDidClickConfirmBtn:self];
    }
}

@end
