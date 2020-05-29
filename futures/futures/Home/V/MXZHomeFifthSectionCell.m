//
//  MXZHomeFifthSectionCell.m
//  futures
//
//  Created by Francis on 2020/5/15.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZHomeFifthSectionCell.h"
#import "MXZRecommandTalkModel.h"

@interface MXZHomeFifthSectionCell()
@property(nonatomic, strong) NSArray *infoArray;

@end
@implementation MXZHomeFifthSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self getInfo];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)getInfo{
    WEAKSELF
    [ENDNetWorkManager getWithPathUrl:@"/user/talk/getRecommandTalk" parameters:nil queryParams:nil Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.infoArray = [MTLJSONAdapter modelsOfClass:[MXZRecommandTalkModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf Message:@"请求话题失败" afterHideTime:DELAYTiME];
    }];
}

@end
