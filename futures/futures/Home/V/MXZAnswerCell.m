//
//  MXZAnswerCell.m
//  futures
//
//  Created by Francis on 2020/5/22.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZAnswerCell.h"
#import "ZKCycleScrollView.h"
#import "MXZAnswerWeekItem.h"
#import "MXZQuestionWeekItem.h"
#import "MXZAnswerTomorrowItem.h"

@interface MXZAnswerCell()<ZKCycleScrollViewDelegate, ZKCycleScrollViewDataSource>
@property(strong, nonatomic) NSArray *engWeek;
@property(strong, nonatomic) NSArray *chWeek;
@end

@implementation MXZAnswerCell

- (NSArray *)engWeek{
    if(_engWeek == nil){
        _engWeek = [[NSArray alloc]initWithObjects:@"Mo", @"Tu", @"We", @"Th", @"Fr", @"Sa", @"Su", nil];
    }
    return _engWeek;
}

- (NSArray *)chWeek{
    if(_chWeek == nil){
        _chWeek = [[NSArray alloc]initWithObjects:@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", nil];
    }
    return _chWeek;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self creatCyclView:self.contentView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//用collectionView设置轮播图
-(void)creatCyclView:(UIView *)fView{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 178, SCREEN_WIDTH, 372)];
    ZKCycleScrollView *cycleScrollView = [[ZKCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 372)];
    cycleScrollView.delegate = self;
    cycleScrollView.dataSource = self;
    cycleScrollView.hidesPageControl = YES;
    //停止自动滚动
    cycleScrollView.autoScroll = NO;
    //banner之间的间距
    cycleScrollView.itemSpacing = ((SCREEN_WIDTH - 312)/2)*0.6;
    //缩放
    cycleScrollView.itemZoomScale = 1.0;
    cycleScrollView.itemSize = CGSizeMake(312, cycleScrollView.bounds.size.height);
    //注册
    [cycleScrollView registerCellNib:[UINib nibWithNibName:@"MXZAnswerWeekItem" bundle:nil] forCellWithReuseIdentifier:@"MXZAnswerWeekItem"];
    [cycleScrollView registerCellNib:[UINib nibWithNibName:@"MXZQuestionWeekItem" bundle:nil] forCellWithReuseIdentifier:@"MXZQuestionWeekItem"];
    [cycleScrollView registerCellNib:[UINib nibWithNibName:@"MXZAnswerTomorrowItem" bundle:nil] forCellWithReuseIdentifier:@"MXZAnswerTomorrowItem"];
    [backView addSubview:cycleScrollView];
    [fView addSubview:backView];
}

- (NSInteger)numberOfItemsInCycleScrollView:(ZKCycleScrollView *)cycleScrollView
{
    return 7;
}

- (__kindof UICollectionViewCell *)cycleScrollView:(ZKCycleScrollView *)cycleScrollView cellForItemAtIndex:(NSInteger)index
{
    if(index != 1 && index != 2){
        MXZAnswerWeekItem *cell = [cycleScrollView dequeueReusableCellWithReuseIdentifier:@"MXZAnswerWeekItem" forIndex:index];
        cell.engWeekLabel.text = self.engWeek[index];
        cell.chWeekLabel.text = self.chWeek[index];
        if(index == 3){
            cell.isSuccessLabel.text  = @"答题失败";
            cell.subSuccessLabel.text = @"抱歉答题失败 明天继续加油！";
            cell.bgImageView.image = [UIImage imageNamed:@"AnsweredSuccessfullyBackground-1"];
        }
        else{
            cell.isSuccessLabel.text  = @"答题成功";
            cell.subSuccessLabel.text = @"恭喜你答题成功 继续加油！";
            cell.bgImageView.image = [UIImage imageNamed:@"AnsweredSuccessfullyBackground"];
        }
        return cell;
    }
    else if(index == 1){
        MXZQuestionWeekItem *cell = [cycleScrollView dequeueReusableCellWithReuseIdentifier:@"MXZQuestionWeekItem" forIndex:index];
        return cell;
    }
    else if (index == 2){
        MXZQuestionWeekItem *cell = [cycleScrollView dequeueReusableCellWithReuseIdentifier:@"MXZAnswerTomorrowItem" forIndex:index];
        return cell;
    }
    return nil;
}



@end
