//
//  MineEditVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/25.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MineEditVC.h"
#import "MineInformationModel.h"
#import "UIImage+OriginalImage.h"

#import "MineInformationNameView.h"
#import "MineInformationSexView.h"

@interface MineEditVC ()<UITableViewDataSource, UITableViewDelegate, MineInformationNameViewDelegate, MineInformationSexViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;

@property (nonatomic, strong)NSArray *informationArray;
@property (weak, nonatomic) IBOutlet UITableView *mineEditTableView;

@property (weak, nonatomic)UIView *coverView;
@property (weak, nonatomic)MineInformationNameView *mineInformationNameView;
@property (weak, nonatomic)MineInformationSexView *mineInformationSexView;


@end

@implementation MineEditVC

- (NSArray *)informationArray
{
    if(_informationArray == nil)
    {
        MineInformationModel *informationModel = MineInformationModel.new;
        informationModel.name = @"`电竞...高高手`";
        informationModel.sex = @"女";
        informationModel.birthday = @"1996-02-12";
        
        NSMutableArray *temp = NSMutableArray.new;
        [temp addObject:informationModel];
        _informationArray = temp;
    }
    return _informationArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back "] style:0 target:self action:@selector(backBtnClicked)];
    _avatarImgView.layer.cornerRadius = CGRectGetWidth(_avatarImgView.frame)/2;
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    self.mineEditTableView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
}

- (void)backBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 4;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    MineInformationModel *informationModel = self.informationArray[0];
    if(indexPath.section == 0)
    {
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#FEA203"];
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"昵称";
            cell.detailTextLabel.text = informationModel.name;
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = informationModel.sex;
        }
        else if(indexPath.row == 2)
        {
            cell.textLabel.text = @"生日";
            cell.detailTextLabel.text = informationModel.birthday;
        }
        else
        {
            cell.textLabel.text = @"个人简介";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else
    {
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#F95529"];
        cell.textLabel.text = @"退出登录";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 3)
    {
        return 91;
    }
    else
    {
        return 51;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = UIView.new;
    footerView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        UIView *headerView = UIView.new;
        headerView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
        return headerView;
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 30;
    }
    else
    {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        MineInformationNameView *mineInformationNameView = [[NSBundle mainBundle]loadNibNamed:@"MineInformationNameView" owner:nil options:nil].firstObject;
        mineInformationNameView.delegate = self;
        [self addCoverView:mineInformationNameView];
    }
    else if(indexPath.section == 0 && indexPath.row == 1)
    {
        MineInformationSexView *mineInformationSexView = [[NSBundle mainBundle]loadNibNamed:@"MineInformationSexView" owner:nil options:nil].firstObject;
        mineInformationSexView.delegate = self;
        [self addCoverView:mineInformationSexView];
    }
}

- (void)mineInformationNameViewDidClickCancelBtn:(MineInformationNameView *)mineInformationNameView
{
    [self removeCoverView:mineInformationNameView];
}

- (void)mineInformationNameViewDidClickConfirmBtn:(MineInformationNameView *)mineInformationNameView
{
    [self removeCoverView:mineInformationNameView];
}

- (void)mineInformationSexViewDidClickCancelBtn:(MineInformationSexView *)mineInformationSexView
{
    [self removeCoverView:mineInformationSexView];
}

- (void)mineInformationSexViewDidClickConfirmBtn:(MineInformationSexView *)mineInformationSexView
{
    [self removeCoverView:mineInformationSexView];
}

- (void)removeCoverView:(UIView *)view
{
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        if([view isKindOfClass:[MineInformationNameView class]])
        {
            self.mineInformationNameView.alpha = 0;
            CGRect frame = self.mineInformationNameView.frame;
            frame.size = CGSizeMake(0, 0);
            self.mineInformationNameView.frame = frame;
        }
        else
        {
            self.mineInformationSexView.alpha = 0;
            CGRect frame = self.mineInformationSexView.frame;
            frame.size = CGSizeMake(0, 0);
            self.mineInformationSexView.frame = frame;
        }
    }completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
    }];
}

- (void)addCoverView:(UIView *)view
{
    UIView *coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    view.alpha = 0;
    view.center = coverView.center;
    CGRect frame = view.frame;
    frame.size = CGSizeMake(0, 0);
    view.frame = frame;
    [coverView addSubview:view];
    if([view isKindOfClass:[MineInformationNameView class]])
    {
        _mineInformationNameView = (MineInformationNameView *)view;
    }
    else
    {
        _mineInformationSexView = (MineInformationSexView *)view;
    }
    
    _coverView = coverView;
    
    NSArray *array = [UIApplication sharedApplication].windows;
    UIWindow *keyWindow = [array objectAtIndex:0];
    [keyWindow addSubview:_coverView];
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        if([view isKindOfClass:[MineInformationNameView class]])
        {
            self.mineInformationNameView.alpha = 1;
            CGRect frame = self.mineInformationNameView.frame;
            frame.size = CGSizeMake(340, 181);
            self.mineInformationNameView.frame = frame;
        }
        else
        {
            self.mineInformationSexView.alpha = 1;
            CGRect frame = self.mineInformationSexView.frame;
            frame.size = CGSizeMake(340, 181);
            self.mineInformationSexView.frame = frame;
        }
    }];
}

@end
