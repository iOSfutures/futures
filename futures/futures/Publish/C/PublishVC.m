//
//  PublishVC.m
//  futures
//
//  Created by Ssiswent on 2020/5/11.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "PublishVC.h"
#import "MXZFeedbackFirstCell.h"
#import "MXZFeedbackSecondCell.h"
#import "MXZFeedbackFourthCell.h"
#import "LoginVC.h"

#import <TZImagePickerController.h>

#import "MyImgPickerC.h"
#import "MyTZimgPickerC.h"

@interface PublishVC ()<UITableViewDelegate, UITableViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSString *contentStr;
@property (strong, nonatomic) NSArray *picArray;
@property (copy, nonatomic)  NSString *saveURL;
@property (nonatomic, strong)NSNumber *userId;
@property (nonatomic, assign)BOOL hasUserId;

@property (nonatomic, strong) MyImgPickerC *imagePickerVc;

@property(nonatomic, weak) UIImage *selectedImg;
@property(nonatomic, strong) MXZFeedbackSecondCell *feedbackCell;

@end

@implementation PublishVC

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[MyImgPickerC alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
 
    }
    return _imagePickerVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getUserDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#FEA203"];
    
    self.navigationItem.title = @"发布说说";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _tableView.scrollEnabled = NO;
    //注册
    [self.tableView registerClass:[MXZFeedbackFirstCell class] forCellReuseIdentifier:@"MXZFeedbackFirstCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXZFeedbackSecondCell" bundle:nil] forCellReuseIdentifier:@"MXZFeedbackSecondCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXZFeedbackFourthCell" bundle:nil] forCellReuseIdentifier:@"MXZFeedbackFourthCell"];
    
    self.contentStr = @"";
}

- (void)getUserDefault
{
    //获取用户偏好
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //读取userId
    NSNumber *userId = [userDefault objectForKey:@"userId"];
    if(userId != nil)
    {
        _userId = userId;
        _hasUserId = YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
    MXZFeedbackFirstCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MXZFeedbackFirstCell"];
    [cell.btnA setTitle:@"生活小方针" forState:UIControlStateNormal];
    [cell.btnB setTitle:@"财经顾问" forState:UIControlStateNormal];
    [cell.btnC setTitle:@"周边爆料" forState:UIControlStateNormal];
    return cell;
    }
    else if (indexPath.section == 1){
    MXZFeedbackSecondCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MXZFeedbackSecondCell"];
        self.feedbackCell = cell;
        cell.picImage.hidden = NO;
        cell.addImgBlock = ^(MXZFeedbackSecondCell *selfCell){
            //弹框
            //1.创建控制器
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            //2.创建按钮
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮要执行的方法
                [self takePhoto];
            }];
            WEAKSELF
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮要执行的方法
                [self pushTZImagePickerController];
            }];
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮要执行的方法
            }];
            
            UIColor *alertTextColor = [UIColor colorWithHexString:@"#FEA203"];
            [action1 setValue:alertTextColor forKey:@"titleTextColor"];
            [action2 setValue:alertTextColor forKey:@"titleTextColor"];
            [action3 setValue:[UIColor colorWithHexString:@"#333333"] forKey:@"titleTextColor"];
            
            //3.添加按钮
            [alertC addAction:action1];
            [alertC addAction:action2];
            [alertC addAction:action3];
            
            //4.显示弹窗(相当于show)
            //这种方法，开头必须是控制器
            [self presentViewController:alertC animated:YES completion:nil];
            
            
            
        };
        //设置完成编辑代理监听
        cell.textBlock = ^(NSString * string) {
            NSLog(@"string = %@",string);
            self.contentStr = string;
        };
//        cell.contentTextView.delegate = self;
        NSMutableArray *savePicArray = [NSMutableArray array];
        [savePicArray addObject:cell.picImage.image];
        self.picArray = savePicArray;
    return cell;
    }
    WEAKSELF
    MXZFeedbackFourthCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MXZFeedbackFourthCell"];
    cell.pubulishBlock = ^(){
        //点击提交按钮后,结束编辑
        [self.view endEditing:true];
        //将图片上传到服务器,获得图片的URL
        if(weakSelf.hasUserId)
        {
            [self uploadImg];
        }
        else
        {
            //跳转到登录界面
            LoginVC *loginVC = [LoginVC new];
            [self.navigationController pushViewController:loginVC animated:YES];
            [Toast makeText:loginVC.view Message:@"请先注册或登录" afterHideTime:DELAYTiME];
        }
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 60)];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 25, 70, 15)];
    //设置字体大小和字重
    titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    if(section == 0){
        titleLabel.text = @"分类标签";
    }
    else if (section == 1){
        titleLabel.text = @"发布内容";
    }
    [headView addSubview:titleLabel];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}


//上传图片
-(void)uploadImg{
    WEAKSELF
    NSDictionary *dict = @{
        @"file" : self.picArray[0]
    };
    [NetworkTool.shared postReturnString:@"http://image.yysc.online/upload" fileName:@"testImg" image:self.picArray[0] viewcontroller:self params:dict success:^(id _Nonnull resopnse) {
        self.saveURL = resopnse;
        //上传图片成功后才publishMessage
        [self publishMessage];
    } failture:^(NSError * _Nonnull error) {
        [Toast makeText:weakSelf.view Message:@"上传图片失败" afterHideTime:DELAYTiME];
    }];
}


-(void)publishMessage{
    WEAKSELF
    NSDictionary *dict = @{
        @"userId" : _userId,
        @"content" : self.contentStr,
        @"picture" : self.saveURL
    };
    [ENDNetWorkManager postWithPathUrl:@"/user/talk/publishTalk" parameters:nil queryParams:dict Header:nil success:^(BOOL success, id result) {
        [Toast makeText:weakSelf.view Message:@"发布说说成功" afterHideTime:DELAYTiME];
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.view Message:@"发布说说失败" afterHideTime:DELAYTiME];
        NSLog(@"%@",error);
    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    [self getUserDefault];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photo = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.selectedImg = photo;
    self.feedbackCell.picImage.image = self.selectedImg;
    self.feedbackCell.picImage.hidden = NO;
}

#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    MyTZimgPickerC *imagePickerVc = [[MyTZimgPickerC alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
     imagePickerVc.naviBgColor = [UIColor colorWithHexString:@"#FEA203"];
     imagePickerVc.navigationBar.translucent = NO;
    
    imagePickerVc.isSelectOriginalPhoto = YES;
    imagePickerVc.needShowStatusBar = NO;
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    
//     imagePickerVc.photoWidth = 1600;
//     imagePickerVc.photoPreviewMaxWidth = 1600;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = NO;

//     imagePickerVc.minImagesCount = 3;
//     imagePickerVc.alwaysEnableDoneBtn = YES;

    //裁剪
//    imagePickerVc.allowCrop = YES;
//    //圆形裁剪
//    imagePickerVc.needCircleCrop = YES;
//    // 设置竖屏下的裁剪尺寸
//    NSInteger left = 30;
//    NSInteger widthHeight = self.view.tz_width - 2 * left;
//    NSInteger top = (self.view.tz_height - widthHeight) / 2;
//    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
//    imagePickerVc.scaleAspectFillCrop = YES;
    
    // 你可以通过block或者代理，来得到用户选择的照片.
    WEAKSELF
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        UIImage *selectedImg = photos[0];
        weakSelf.selectedImg = selectedImg;
        self.feedbackCell.picImage.image = self.selectedImg;
        self.feedbackCell.picImage.hidden = NO;
    }];
    
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

@end
