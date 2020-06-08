//
//  MyImgPickerC.m
//  futures
//
//  Created by Ssiswent on 2020/6/8.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MyImgPickerC.h"

@interface MyImgPickerC ()

@end

@implementation MyImgPickerC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

@end
