//
//  EGHCodeTool.m
//  SCRBProject1
//
//  Created by zdh on 2019/6/26.
//  Copyright © 2019 zdh. All rights reserved.
//

#import "EGHCodeTool.h"
#import <objc/runtime.h>
#import <dlfcn.h>
@implementation EGHCodeTool
+ (BOOL)isIPhoneXSeries{
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}
+ (BOOL)isNumText:(NSString *)str{
    
    NSString * regex        = @"(/^[0-9]*$/)";
    
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch            = [pred evaluateWithObject:str];
    
    if (isMatch) {
        
        return YES;
        
    }else{
        
        return NO;
        
    }
    
}

+(void)archiveOJBC:(nullable id)objc saveKey:(NSString *)key{
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:objc];
    [[NSUserDefaults standardUserDefaults] setObject:archiveData forKey:key];
}
+(id)getOBJCWithSavekey:(NSString *)key{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    id objc = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return objc;
}

+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize
{
    
    if (maxSize <= 0.0) maxSize = 1024.0;
    if (maxImageSize <= 0.0) maxImageSize = 1024.0;
    
    //先调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }
    
    return imageData;
}


@end
