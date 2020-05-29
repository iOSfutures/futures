//
//  MXZHomeThirdSectionHeadView.m
//  futures
//
//  Created by Francis on 2020/5/28.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZHomeThirdSectionHeadView.h"
#import "MXZHomeIndustryVC.h"

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
- (IBAction)jumpToIndustryVC:(id)sender {
    NSArray *tempArray = self.affairsArray;
    if(_jumpBlock){
        _jumpBlock(tempArray);
    }
//    MXZHomeIndustryVC *industryVC = [[MXZHomeIndustryVC alloc]init];
//    industryVC.affairsArray = self.affairsArray;
//    industryVC.tabBarHidden = YES;
//    [self.navigationController pushViewController:industryVC animated:YES];
}

@end
