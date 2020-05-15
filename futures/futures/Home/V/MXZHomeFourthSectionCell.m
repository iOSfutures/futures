//
//  HomeQuoteFourthSectionCell.m
//  futures
//
//  Created by Francis on 2020/5/14.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZHomeFourthSectionCell.h"
#import "MXZHomeFourthCollectionCell.h"

@interface MXZHomeFourthSectionCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation MXZHomeFourthSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //设置collectionView的代理和数据源
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //注册collectionView
    [_collectionView registerNib:[UINib nibWithNibName:@"MXZHomeFourthCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"homeFourthCollectionCell"];
    _collectionView.contentInset = UIEdgeInsetsMake(10, 15, 10, 15);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MXZHomeFourthCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeFourthCollectionCell" forIndexPath:indexPath];
    cell.cellImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"banner0%d_financial exclusive_home", (int)indexPath.item+1]];
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
