//
//  QuoteCalendarVC.m
//  futures
//
//  Created by apple on 2020/5/14.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "ZZHQuoteCalendarVC.h"
#import "ZZHDateCollectionViewCell.h"
#import "ZZHDateTableViewCell.h"

#import "UIColor+Hex.h"

@interface ZZHQuoteCalendarVC () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *dateCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *weekDayArray;
// 数据数组
@property (nonatomic, strong) NSMutableArray *dataArray;
// 选中cell的indexPath
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
// 取消选中的cell，防止由于重用，在取消选中的代理方法中没有设置
@property (nonatomic, strong) NSIndexPath *DeselectIndexpath;
@end
static NSString *ID = @"collectionView";
CGFloat wid = 10; //CollectionViewCell整体距离左右的边距
@implementation ZZHQuoteCalendarVC

- (void)viewDidLoad {
//    [super viewDidLoad];
    _weekDayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    self.dateCollectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"calendar blakground.jpg"]];
    
    // 注册cell
    [self.dateCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZZHDateCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    
    self.dateCollectionView.delegate = self;
    self.dateCollectionView.dataSource = self;
    //设置分割线:对tableView的separatorInset, layoutMargins属性的设置
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            self.tableView.separatorInset = UIEdgeInsetsZero;
        }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 94;
    //设置默认选中某个cell
    [self.dateCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)setSelectIndexPath:(NSIndexPath *)selectIndexPath {
    
}

-(UIView *)listView{
    return self.view;
}

#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}

//只有新的cell出现的时候才会调用
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
    ZZHDateCollectionViewCell *cell = [self.dateCollectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//    cell.selectedBackgroundView.backgroundColor = [UIColor redColor];
    return cell;
}
//设置cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(28, 77);
}
//整体边距设置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(53, wid, 2, 20);
}
//设置cell的间距
- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return (SCREEN_WIDTH - 28 * 7 - wid * 2 ) / 8;
}
#pragma mark - UICollectionViewDelegate
//设置是否允许选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//设置是否允许取消选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//选中时的操作
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
}
//取消选中操作
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UITableViewViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"zzh";
    ZZHDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZZHDateTableViewCell" owner:self options:nil]lastObject];
    }
    //对cell的LayoutMargins属性的设置
    //2.调整(iOS8以上)tableView边距
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            cell.preservesSuperviewLayoutMargins = NO;
        }
       //3.调整(iOS8以上)view边距
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    return cell;
}

@end
