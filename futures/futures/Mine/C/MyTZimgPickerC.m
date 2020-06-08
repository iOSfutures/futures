//
//  MyTZimgPickerC.m
//  futures
//
//  Created by Ssiswent on 2020/6/8.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MyTZimgPickerC.h"

@interface MyTZimgPickerC ()

@end

@implementation MyTZimgPickerC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}


@end
