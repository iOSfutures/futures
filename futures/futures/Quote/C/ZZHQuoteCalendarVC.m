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

@end
static NSString *ID = @"collectionView";
@implementation ZZHQuoteCalendarVC

- (void)viewDidLoad {
//    [super viewDidLoad];
    
    self.dateCollectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"calendar blakground.jpg"]];
    
    // 注册cell
    [self.dateCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZZHDateCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    
    self.dateCollectionView.delegate = self;
    self.dateCollectionView.dataSource = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 94;
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
//    254, 247, 231, 1
//    cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#FEF7E7"];
//    cell.contentView.view
    return cell;
}
//设置cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(28, 77);
}
//整体边距设置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    CGFloat *space = (SCREEN_WIDTH - 28 * 7) / 8;
    return UIEdgeInsetsMake(53, 20, 2, 20);
}
//设置cell的间距
- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
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
    cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#FEF7E7"];
}
//取消选中操作
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColorWithRGBA(255, 255, 255, 0);
}
//选中
- (void)selectItemAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition {
    
}
//非选中
- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    
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
    return cell;
}

@end
