

//
//  BaseImagePickerViewController.m
//  
//
//  Created by zdh on 2019/7/17.
//  Copyright © 2019 SCRB. All rights reserved.
//

#import "EGHImagePickerVCManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface EGHImagePickerVCManager ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) UIViewController *orginViewController;
/// 取出的图片
@property (nonatomic,strong) UIImage *tempImage;


@end

@implementation EGHImagePickerVCManager{
    NSURL *videoUrl;
}

- (UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        /// 转场动画方式
        //      _imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePicker.allowsEditing = YES; //允许编辑
        _imagePicker.videoMaximumDuration = 15 ; //视频时长默认15s
        _imagePicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }
    return _imagePicker;
}


- (void)setIsVideo:(BOOL)isVideo{
    _isVideo = isVideo;
    if (isVideo == YES) {
        /// 媒体类型
        _imagePicker.mediaTypes = @[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie];
    }else{
        /// 媒体类型
        _imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    }
}

- (instancetype)initWithViewController:(UIViewController *)VC{
    self = [super init];
    if (self) {
        self.orginViewController = VC;
    }
    return self;
}

#pragma mark- 快速创建一个图片选择弹出窗
- (void)quickAlertSheetPickerImage{
    UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    [sheetView showInView:self.orginViewController.view];
}

#pragma mark-<UIActionSheetDelegate>
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"---%ld",buttonIndex);
    if (buttonIndex == 0) {
        ///相册
        [self openPhoto];
    }else if (buttonIndex == 1){
        /// 拍照
        [self openCamera];
    }
}


#pragma mark- 打开相机
- (void)openCamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return ;
    }
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制的类型 图片 视频
   self.imagePicker.mediaTypes = _mediaTypes;
    [self.orginViewController presentViewController: self.imagePicker animated:YES completion:^{
        NSLog(@"相机");
    }];
}

#pragma mark- 打开相册
- (void)openPhoto{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return ;
    }
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
   
    self.imagePicker.mediaTypes = _mediaTypes;
    [self.orginViewController presentViewController: self.imagePicker animated:YES completion:^{
        NSLog(@"相册");
    }];
}


#pragma mark- <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    DLog(@"%@",info);
  
    WEAKSELF
     NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
//   return;
     if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
    UIImage *orginImage = info[UIImagePickerControllerOriginalImage];
    self.tempImage = [self fixOrientation: orginImage];
    
    /// 选择的图片
    if(self.didSelectImageBlock){
        self.didSelectImageBlock(YES,self.tempImage);
    }
    ///拍到的照片顺带保存到相册
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [self saveImageToSystemPhotosAlbum];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
     
     }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
         [picker dismissViewControllerAnimated:YES completion:^{
             //文件管理器
//             NSFileManager* fm = [NSFileManager defaultManager];
//
//             //创建视频的存放路径
//             NSString * path = [NSString stringWithFormat:@"%@/tmp/video%.0f.merge.mp4", NSHomeDirectory(), [NSDate timeIntervalSinceReferenceDate] * 1000];
//             NSURL *mergeFileURL = [NSURL fileURLWithPath:path];
//             videoUrl = mergeFileURL;
//
//             //通过文件管理器将视频存放的创建的路径中
//             [fm copyItemAtURL:[info objectForKey:UIImagePickerControllerMediaURL] toURL:mergeFileURL error:nil];
//
//             if (self.didSelectImageBlock) {
//                 self.didSelectImageBlock(NO, <#id  _Nonnull data#>)
//             }
//
//
//             //根据AVURLAsset得出视频的时长
//             CMTime   time = [asset duration];
//             int seconds = ceil(time.value/time.timescale);
//             NSString *videoTime = [NSString stringWithFormat:@"%d",seconds];
             
//             可以根据需求判断是否需要将录制的视频保存到系统相册中
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            NSURL *recordedVideoURL= [info objectForKey:UIImagePickerControllerMediaURL];
             
             if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:recordedVideoURL]) {
                 [library writeVideoAtPathToSavedPhotosAlbum:recordedVideoURL
                                             completionBlock:^(NSURL *assetURL, NSError *error){
                                                 if (assetURL) {
                                                  [self getVideoPhotoWithURL:assetURL];
                                                 }
                                             }];
             }
             
         }];
     }
}

-(void)getVideoPhotoWithURL:(NSURL *)assetURL{
    WEAKSELF
    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
    [lib assetForURL:assetURL resultBlock:^(ALAsset *asset) {
        UIImage *image = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
        NSDictionary *dic = @{@"Image":image,@"url":assetURL};
        if (weakSelf.didSelectImageBlock) {
            weakSelf.didSelectImageBlock(NO,dic);
        }
    } failureBlock:^(NSError *error) {
        [Toast makeText:weakSelf.orginViewController.view Message:@"获取资源失败" afterHideTime:DELAYTiME];
    }];
}

#pragma mark- 拍的照片保存到系统相册
- (void)saveImageToSystemPhotosAlbum{
    UIImageWriteToSavedPhotosAlbum(self.tempImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

/// 系统指定的回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    NSLog(@"%@",msg);
    //  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    //  [[UIApplication sharedApplication].keyWindow.rootViewController showViewController:alert sender:nil];
}
-(void)setMediaTypes:(NSArray *)mediaTypes{
    if (_mediaTypes != mediaTypes) {
        _mediaTypes = mediaTypes;
    }
}

///矫正图片方向
- (UIImage*)fixOrientation:(UIImage*)aImage
{
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.height, aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.width, aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage* img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
