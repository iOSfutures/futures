
//
//  MacroQiHuo.h
//  SCRBProject1
//
//  Created by zdh on 2019/7/4.
//  Copyright © 2019 zdh. All rights reserved.
//

#ifndef MacroQiHuo_h
#define MacroQiHuo_h



#define Option @"zixuna.plist"

#define RGB(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]  ///<颜色宏
#define ClearColor [UIColor clearColor]

#define LabelColor RGB(30,30,30) // 普通文字颜色
#define BackLine RGB(245, 246, 247)//背景色,线框色

#define Rise RGB(255,43,61)
#define Fall RGB(34,205,131)
#define defaltColor RGB(248,247,252)
#define MORE (SCREEN_WIDTH/SCREEN_HEIGHT < 0.5 ? 34:0)


#define NameFont(x) [UIFont fontWithName:@"PingFangSC-Light" size:x]//苹方细体
#define NameBFont(x) [UIFont fontWithName:@"PingFangSC-Regular" size:x]//苹方体
#define NumFont(x) [UIFont fontWithName:@"Helvetica Neue" size:x]//数字字体
#define Customize(name,x) [UIFont fontWithName:name size:x]//自定义字体
#define ColorBlue [UIColor colorWithRed:113/255.0 green:103/255.0 blue:252/255.0 alpha:1/1.0]

// View 圆角
#define LXViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// View 边框
#define LXViewBord(View, Color, Width)\
\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:(Color).CGColor]
#endif /* MacroQiHuo_h */
