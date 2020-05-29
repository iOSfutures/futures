//
//  NSString+DealError.m
//  SCRBProject1
//
//  Created by zdh on 2019/6/25.
//  Copyright © 2019 zdh. All rights reserved.
//

#import "NSString+DealError.h"

@implementation NSString (DealError)

- (NSString *)fileAppend:(NSString *)appendStr{
    NSString *extenSion = [self pathExtension];
    NSString *imageName = [self stringByDeletingPathExtension];
    imageName = [imageName stringByAppendingString:appendStr];
    imageName = [imageName stringByAppendingPathExtension:extenSion];
    return imageName;
}

- (NSString *)isNullClassOrNot {
    //    DLog(@" === %@",self);
    if ([self isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return self;
}

- (BOOL)isHaveIllegalChar:(NSString *)str{
    //NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"{}"];
    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
    return range.location<str.length;
}

- (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    NSString *str;
    if ([self IsChinese:outputStr]) {
        NSLog(@"有");
        str = [outputStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else{
        NSLog(@"无");
        str = outputStr;
    }
    return str;
}

-(BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}
- (BOOL)isChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
- (BOOL)includeChinese {
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff)
        {
            return YES;
        }
    }
    return NO;
}


- (NSString *)transformToPinyin{
    
    NSMutableString * mutableString = [NSMutableString stringWithString:self];
    
    CFStringTransform((CFMutableStringRef) mutableString, NULL, kCFStringTransformToLatin, false);
    
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    
    mutableString = [[mutableString stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
    
    return mutableString.lowercaseString;
    
}
- (NSString * )transformToPinyinFirstLetter{
    
    NSMutableString * stringM = [NSMutableString string];
    
    
    
    NSString * temp = nil;
    
    for (int i = 0; i < [self length]; i ++) {
        
        
        
        temp = [self substringWithRange:NSMakeRange(i, 1)];
        
        
        
        NSMutableString * mutableString = [NSMutableString stringWithString:temp];
        
        
        
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
        
        
        
        mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
        
        
        
        mutableString = [[mutableString substringToIndex:1] mutableCopy];
        
        
        
        [stringM appendString:(NSString *)mutableString];
        
    }
    
    return stringM.lowercaseString;
    
}

@end
