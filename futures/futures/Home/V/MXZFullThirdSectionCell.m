//
//  MXZFullThirdSectionCell.m
//  futures
//
//  Created by Francis on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZFullThirdSectionCell.h"
#import "MXZFullThirdCollectionCell.h"
@interface MXZFullThirdSectionCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end
@implementation MXZFullThirdSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //设置collectionView的代理和数据源
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //注册collectionView
    [_collectionView registerNib:[UINib nibWithNibName:@"MXZFullThirdCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"MXZFullThirdCollectionCell"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MXZFullThirdCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MXZFullThirdCollectionCell" forIndexPath:indexPath];
    cell.itemImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"14270%d", (int)indexPath.item+1]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

@end
