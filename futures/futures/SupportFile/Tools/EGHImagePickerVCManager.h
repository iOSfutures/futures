//
//  BaseImagePickerViewController.h
//  
//
//  Created by zdh on 2019/7/17.
//  Copyright © 2019 SCRB. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
NS_ASSUME_NONNULL_BEGIN

@interface EGHImagePickerVCManager : NSObject
/// 创建这样一个管理类对象
- (instancetype)initWithViewController:(UIViewController *)VC;

///选择图片的回调block
@property (nonatomic,copy) void(^didSelectImageBlock) (BOOL image,id data);

/// 相册选择器对象
@property (nonatomic,strong) UIImagePickerController *imagePicker;

///最大视频时长
@property (nonatomic,assign) NSTimeInterval videoMaximumDuration;

@property (nonatomic,assign) BOOL isVideo;

#pragma mark- 快速创建一个图片选择弹出窗
- (void)quickAlertSheetPickerImage ;

#pragma mark- 打开相机
- (void)openCamera;

#pragma mark- 打开相册
- (void)openPhoto ;

@property (nonatomic, strong) NSArray *mediaTypes;
@end

NS_ASSUME_NONNULL_END
