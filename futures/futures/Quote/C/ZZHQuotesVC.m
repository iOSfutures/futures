//
//  QuoteVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/11.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "ZZHQuotesVC.h"
//#import "ZZHSlideHeadView.h"
#import "ZZHQuoteTimeVC.h"
#import "ZZHQuoteCalendarVC.h"
#import "ZZHQuoteIndustryVC.h"
#import "ZZHQuoteNewsVC.h"

@interface ZZHQuotesVC ()

@property (nonatomic, strong) UIView *customizedStatusBar;
@end

@implementation ZZHQuotesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //1. 初始化SliderHeadView ,加进View
//    ZZHSlideHeadView *slideVC = [[ZZHSlideHeadView alloc] init];
//    [self.view addSubview:slideVC];
//    
//    //titleArr:实时行情 日历数据 行业风暴 7x24快讯
//    NSArray *titleArr = @[@"实时行情",@"日历数据",@"行业风暴",@"7x24快讯"];
//    slideVC.titlesArr = titleArr;
//    
//    //2. 初始化子控制器
//    ZZHQuoteTimeVC *quoteTimeVC = [[ZZHQuoteTimeVC alloc] init];
//    [slideVC addChildViewController:quoteTimeVC title:titleArr[0]];
//    
//    ZZHQuoteCalendarVC *quoteCalendarVC = [[ZZHQuoteCalendarVC alloc] init];
//    [slideVC addChildViewController:quoteCalendarVC title:titleArr[1]];
//    
//    ZZHQuoteIndustryVC *quoteIndustryVC = [[ZZHQuoteIndustryVC alloc] init];
//    [slideVC addChildViewController:quoteIndustryVC title:titleArr[2]];
//    
//    ZZHQuoteNewsVC *quoteNewsVC = [[ZZHQuoteNewsVC alloc] init];
//    [slideVC addChildViewController:quoteNewsVC title:titleArr[3]];
//    
//    
//    //3. 调用setSlideHeadView
//    [slideVC setSlideHeadView];
}

//修改状态栏颜色
//rgba(254, 162, 3, 1)
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self setupStatusBarColor:UIColorWithRGBA(254, 162, 3, 1)];
//}

/*
//设置状态栏颜色
- (void)setupStatusBarColor:(UIColor *)color {
    if (@available(iOS 13.0, *)) {// iOS 13 不能直接获取到statusbar 手动添加个view到window上当做statusbar背景
              if (!self.customizedStatusBar) {
                  //获取keyWindow
                  UIWindow *keyWindow = [self getKeyWindow];
                  self.customizedStatusBar = [[UIView alloc] initWithFrame:keyWindow.windowScene.statusBarManager.statusBarFrame];
                      [keyWindow addSubview:self.customizedStatusBar];
              }
          }
    else {
            self.customizedStatusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
         }
     
          if ([self.customizedStatusBar respondsToSelector:@selector(setBackgroundColor:)]) {
              self.customizedStatusBar.backgroundColor = color;
          }
}

- (UIWindow *)getKeyWindow
{
    // 获取keywindow
    NSArray *array = [UIApplication sharedApplication].windows;
    UIWindow *window = [array objectAtIndex:0];
 
     //  判断取到的window是不是keywidow
    if (!window.hidden || window.isKeyWindow) {
        return window;
    }
 
    //  如果上面的方式取到的window 不是keywidow时  通过遍历windows取keywindow
    for (UIWindow *window in array) {
        if (!window.hidden || window.isKeyWindow) {
            return window;
        }
    }
    return nil;
}
 
//界面销毁时把添加的状态栏从window上移除
- (void)dealloc{
    if (@available(ios 13.0, *)) {
        if (self.customizedStatusBar) {
            [self.customizedStatusBar removeFromSuperview];
            self.customizedStatusBar = nil;
        }
    }
}
*/
@end
