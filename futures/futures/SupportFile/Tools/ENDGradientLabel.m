//
//  ENDGradientLabel.m
//  ENDJProject
//
//  Created by sea on 2019/8/28.
//  Copyright © 2019 SCRB. All rights reserved.
//

#import "ENDGradientLabel.h"

@implementation ENDGradientLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName : self.font}];
    CGRect textRect = (CGRect){0, 0, textSize};
   
    // 画文字(不做显示用, 主要作用是设置 layer 的 mask)
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.textColor set];
    [self.text drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:NULL];
    
    // 坐标(只对设置后的画到 context 起作用, 之前画的文字不起作用)
    CGContextTranslateCTM(context, 0.0f, rect.size.height - (rect.size.height - textSize.height) * .5);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    CGImageRef alphaMask = CGBitmapContextCreateImage(context);
    CGRect newRect = CGRectMake(rect.origin.x, rect.origin.y+10, rect.size.width, rect.size.height +10);
    CGContextClearRect(context, newRect); // 清除之前画的文字
    
    // 设置mask
    CGContextClipToMask(context, rect, alphaMask);
    
    // 画渐变色
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)self.colors, NULL);
    CGPoint startPoint = CGPointMake(textRect.origin.x,
                                     textRect.origin.y);
    CGPoint endPoint = CGPointMake(textRect.origin.x + textRect.size.width,
                                   textRect.origin.y + textRect.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    // 释放内存
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    CFRelease(alphaMask);
}

-(void)setColors:(NSArray *)colors{
    if (_colors != colors) {
        _colors = colors;
    }
    [self layoutIfNeeded];
}

@end
