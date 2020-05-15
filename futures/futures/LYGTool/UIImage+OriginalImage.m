//
//  UIImage+OriginalImage.m
//  futures
//
//  Created by Ssiswent on 2020/5/11.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "UIImage+OriginalImage.h"

@implementation UIImage (OriginalImage)

+ (UIImage *)originalImageWithName:(NSString *)name
{
    UIImage *originalImage = [UIImage imageNamed:name];
    originalImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return originalImage;
}

@end
