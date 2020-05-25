//
//  MXZQuestionWeekItem.m
//  futures
//
//  Created by Francis on 2020/5/22.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZQuestionWeekItem.h"
#import "MXZAnswerABCButton.h"

@interface MXZQuestionWeekItem()
@property(strong, nonatomic) NSArray *btnArray;

@end

@implementation MXZQuestionWeekItem

- (void)awakeFromNib {
    [super awakeFromNib];
    NSMutableArray *btnSaveArray = [NSMutableArray array];
    CGFloat spaceH = 21;
    MXZAnswerABCButton *answerA = [[MXZAnswerABCButton alloc]initWithFrame:CGRectMake(30, 216, 266, 30)];
    [answerA setTitle:@"A .《深圳证券交易所股票期权试点交易规则》" forState:UIControlStateNormal];
    [answerA addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:answerA];
    [btnSaveArray addObject:answerA];
    
    MXZAnswerABCButton *answerB = [[MXZAnswerABCButton alloc]initWithFrame:CGRectMake(30, answerA.frame.origin.y + 30 + spaceH, 266, 30)];
    [answerB setTitle:@"B .《成都证券交易所股票期权试点交易规则》" forState:UIControlStateNormal];
    answerB.isRight = true;
    [answerB addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:answerB];
    [btnSaveArray addObject:answerB];
    
    MXZAnswerABCButton *answerC = [[MXZAnswerABCButton alloc]initWithFrame:CGRectMake(30, answerB.frame.origin.y + 30 + spaceH, 266, 30)];
    [answerC setTitle:@"C .《广东证券交易所股票期权试点交易规则》" forState:UIControlStateNormal];
    [answerC addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:answerC];
    [btnSaveArray addObject:answerC];
    
    _btnArray = btnSaveArray;
}

-(void)btnClick:(MXZAnswerABCButton *)fBtn{
    for (MXZAnswerABCButton *btn in _btnArray) {
        if(btn.isRight == true){
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        [btn setEnabled:NO];
    }
    [fBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fBtn setBackgroundColor:[UIColor colorWithRed:52/255.0 green:166/255.0 blue:44/255.0 alpha:1.0]];
}

@end
