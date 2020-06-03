
//
//  MacroStringHeader.h
//  SCRBProject1
//
//  Created by zdh on 2019/6/25.
//  Copyright © 2019 zdh. All rights reserved.
//

#ifndef MacroStringHeader_h
#define MacroStringHeader_h
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)


#define kIsIPhoneX_Series [CodeTool isIPhoneXSeries]
#define kSafeBottomHeight (kIsIPhoneX_Series ? 34 : 0)

#define BUTTONMarginX    10
#define BUTTONMarginUP   0
#define NAVBUTTON_WIDTH  44
#define NAVBUTTON_HEIGHT 44
#define NAVIGATION_BAR_HEIGHT 44
#define CUSTOMNAVIGATION_HEIGHT (getStatusHight + 44)
#define UIToolbarHeight 49
#define UIStatusBarHeight 20
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
//颜色

#define UIColorFromRGB(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f]
#define UIColorFromRGBA(rgbValue,a)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:a]
#define UIColorWithRGBA(r,g,b,a)        [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define UIImageWithName(_Name) ([UIImage imageNamed:_Name])

//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:_Name]]

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif


#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (SCREEN_WIDTH/320))
#define kScale_iPhone5_Desgin(_X_) ((_X_ * SCREEN_WIDTH)/320)
#define kScaleFrom_iPhone6_Desgin(_X_) (_X_ * (SCREEN_WIDTH/375))
#define kScaleFrom_iPad_Desgin(_X_) (_X_ * (SCREEN_WIDTH/768))
#define kScaleFrom_invitationView_Desgin(_X_) (_X_ * ((CGFloat)(SCREEN_WIDTH - 157)/375))

//判断空字符串
#define  IsEmptyStr(string) ([string isKindOfClass:[NSNull class]] || string == nil || string == NULL || [string isEqualToString:@""] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
//sdwebSetImage
#define SDWEBIMAGE(OBJ,imageUrl,PLH) [OBJ sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:PLH]]


#define KgetUserValueByParaName(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]

#define KsetUserValueWithParaName(value,key) [[NSUserDefaults standardUserDefaults] setValue:value forKey:key]


#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

#define WeakObj(o) try{}@finally{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#define PlaceHolderWithHead UIImageWithName(@"placeHolderHead")
#define PlaceHolderWithWidth UIImageWithName(@"pic_jiazaitu")
#define PlaceHolderWithHeight UIImageWithName(@"")
#define DELAYTiME 1.5

#define SavedUser [CodeTool getOBJCWithSavekey:@"saveUser"]

#define PresentLoginViewController(obj) [obj presentViewController:[TLLUserLoginVC new] animated:YES completion:nil];


#pragma mark - time

#define TimeForMatterStr @"yyyy-MM-dd HH:mm:ss"
#endif /* MacroStringHeader_h */
