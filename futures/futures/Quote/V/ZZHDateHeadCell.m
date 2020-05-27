//
//  ZZHDateHeadCell.m
//  futures
//
//  Created by apple on 2020/5/27.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "ZZHDateHeadCell.h"
#import "ZZHDateCollectionViewCell.h"

@interface ZZHDateHeadCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *headCollectionView;

@end

@implementation ZZHDateHeadCell

NSString *dateHeadCellID = @"dateHeadCell";

//CollectionViewCell整体距离左右的边距
CGFloat wid = 10;
- (void)awakeFromNib {
    [super awakeFromNib];
    self.headCollectionView.delegate = self;
    self.headCollectionView.dataSource = self;
    
    self.headCollectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"calendar blakground.jpg"]];
    
    // 注册cell
    [self.headCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZZHDateCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:dateHeadCellID];
    
    //设置默认选中某个cell
    [self.headCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
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
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
    ZZHDateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dateHeadCellID forIndexPath:indexPath];

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

@end
