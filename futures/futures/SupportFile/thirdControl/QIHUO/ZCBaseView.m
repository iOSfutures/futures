//
//  ZCBaseView.m
//  test
//
//  Created by apple on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ZCBaseView.h"
@implementation ZCBaseView

- (UIViewController *)viewController{
    //获取当前view的superView对应的控制器
    UIResponder *next = [self nextResponder];
    
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
            
        }next = [next nextResponder];
        
    } while (next != nil);
    
    return nil;
    
}

#pragma mark - 控件边线设置
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width{
    
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    
}


@end
