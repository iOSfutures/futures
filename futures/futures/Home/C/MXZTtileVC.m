//
//  MXZTtileVC.m
//  futures
//
//  Created by Francis on 2020/5/19.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZTtileVC.h"
#import "JXCategoryTitleView.h"

@interface MXZTtileVC ()
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation MXZTtileVC

- (void)viewDidLoad {
    if (self.titles == nil) {
        self.titles = @[@"上海", @"主力", @"大连", @"上期能源" ];
    }

    [super viewDidLoad];

    self.myCategoryView.titles = self.titles;
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}


@end
