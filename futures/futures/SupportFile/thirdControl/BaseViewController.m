 
//
//  ViewController.m
//  SCRBProject1
//
//  Created by zdh on 2019/6/25.
//  Copyright © 2019 zdh. All rights reserved.
//

#import "BaseViewController.h"
//#import "ENDLoginViewController.h"
//#import "ENDGradientLabel.h"
//#import "ENDNewMineViewController.h"
@interface BaseViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) UIButton *baseBackBtn;

@property (nonatomic, strong) UIView *noDataBackView;

@property (nonatomic, strong) UIImageView *nodataImageView;

@property (nonatomic, strong) UIView *talkFunctionView,*talkToobarView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITextView *talkToolbarText;


@end

@implementation BaseViewController
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.delegate = self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}
- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = UIColorFromRGB(0x1F2635);
//    [self setNavigation];
//    [self getBackView:self.navigationController.navigationBar];
//    [self.tabBarController.tabBar setShadowImage:[UIImage new]];
    
//    [self.tabBarController.tabBar setBackgroundImage:[EGHViewsTool GetImageWithColor:[UIColor clearColor] andHeight:kSafeBottomHeight + UIToolbarHeight]];
    
//    [self getBackView:self.tabBarController.tabBar];
    
//    [self setLeftButtonWithImageName:@"icon_renturn" bgImageName:@""];
   
//    if (!IsEmptyStr(_titleString)) {
//        [self setTitle:_titleString titleColor:UIColorFromRGB(0xFFFFFF)];
//    }
    // Do any additional setup after loading the view.
}
-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
}
-(void)setNavigation{
    _baseBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_baseBackBtn addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_baseBackBtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    
    _baseBackBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20,0, 0);
    _baseBackBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 0,12,0);
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    UIBarButtonItem *item =  [[UIBarButtonItem alloc] initWithCustomView:_baseBackBtn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,item];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :UIColorFromRGB(0x333333), NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:18]}];
}


//设置导航左边的button的图片名和背景图片名
- (void)setLeftButtonWithImageName:(NSString*)imageName bgImageName:(NSString*)bgImageName
{
    UIButton *tmpLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tmpLeftButton.frame = CGRectMake(0, 0, 20, 44);//CGRectMake(0, BUTTONMarginUP, NAVBUTTON_WIDTH, NAVBUTTON_HEIGHT);
    tmpLeftButton.showsTouchWhenHighlighted = NO;
    tmpLeftButton.exclusiveTouch = YES; //add by ljj 修改push界面问题
    tmpLeftButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10,0, 0);
    tmpLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -12,0, 0);
    if (bgImageName)//设置button的背景
    {
        [tmpLeftButton setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    
    [tmpLeftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tmpLeftButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tmpLeftButton];
    
//    if ([LCPSystemFactory isSystemVersionIs7])//左边button的偏移量，从左移动13个像素
//    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;
        [self.navigationItem setLeftBarButtonItems:@[negativeSeperator, leftButtonItem]];
//    }
//    else
//    {
//        [self.navigationItem setLeftBarButtonItem:leftButtonItem];
//    }
}

- (void)setRightButtonWithTitle:(NSString*)title
{
    
    CGRect rectSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
    if (rectSize.size.width<60) {
        rectSize.size.width = 60;
    }
    else
    {
        rectSize.size.width+=6;
    }
    UIButton *tmpRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tmpRightButton.frame = CGRectMake(self.view.frame.size.width-NAVBUTTON_WIDTH-BUTTONMarginX, BUTTONMarginUP, rectSize.size.width, 30);
    
    tmpRightButton.showsTouchWhenHighlighted = NO;
    tmpRightButton.exclusiveTouch = YES;//add by ljj 修改push界面问题
    
    [tmpRightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [tmpRightButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [tmpRightButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [tmpRightButton setTitle:title forState:UIControlStateNormal];
    
    [tmpRightButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateDisabled];
    
    [tmpRightButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateHighlighted];
    //    [tmpRightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tmpRightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
//    if ([LCPSystemFactory isSystemVersionIs7])//左边button的偏移量，从左移动13个像素
//    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;
        [self.navigationItem setRightBarButtonItems:@[negativeSeperator, rightButtonItem]];
//    }
//    else
//    {
//        [self.navigationItem setRightBarButtonItem:rightButtonItem];
//    }
//    _tmptRightBtn =  tmpRightButton;
}
//-(void)rightButtonPressed:(UIButton *)btn{
//    if (!SavedUser) {
//        PresentLoginViewController(self);
//    }else{
//        ENDNewMineViewController *mineVC = [ENDNewMineViewController new];
//        [self.navigationController pushViewController:mineVC animated:YES];
//    }
//    //右侧按钮有需要的就重写按钮方法，没需要的直接跳转
//
//}
#pragma mark - 设置导航条样式
-(void)setTitle:(NSString *)titleName titleColor:(UIColor *)titleColor{
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleL.text = titleName;
    titleL.font = [EGHViewsTool setLabelFont:22 Weight:UIFontWeightBold];
    titleL.textColor = titleColor;
    titleL.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleL;
    
}//添加标题

//#pragma mark - 设置偏左导航栏标题
//-(void)setLeftTitle:(NSString *)titleName titleColor:(UIColor *)titleColor{
//
//    ENDGradientLabel *titleL = [[ENDGradientLabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 22)];
//
//    titleL.font = [EGHViewsTool setLabelFont:22 Weight:UIFontWeightBold];
//    titleL.textAlignment = NSTextAlignmentLeft;
//    titleL.text = titleName;
//    titleL.colors = GradientLabelColors;
//    self.navigationItem.titleView = titleL;
//
//}//添加标题

-(void)setNavigationStyle:(UIColor *)NavColor{
    self.navigationController.navigationBar.barTintColor = NavColor;
}
-(void)leftButtonPressed:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)backNavigationStyle:(UIColor *)navColor{
    
    int backH = (([[UIApplication sharedApplication] statusBarFrame].size.height == 44.0f) ? 88:64);
    
    UIView *backNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, backH)];
    
    backNav.backgroundColor = navColor;
    
    [self.view addSubview:backNav];
    
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
-(void)showRightUserBtn{
[self setRightButtonWithTitle:nil titleColor:nil titleFont:12 normalImage:@"tit_user" selectedImage:nil rect:CGRectMake(0, 0, 44, 44)];
}
//隐藏navigationbar上面的_UIVisualEffectSubview的superView
-(void)getBackView:(UIView*)superView
{
    
    if ([superView isKindOfClass:NSClassFromString(@"_UIBarBackground")])
        
    {
        if (superView.frame.size.height  == 49 + kSafeBottomHeight) {
            superView.backgroundColor = UIColorFromRGB(0x252D40);
        }
     
    }else if ([superView isKindOfClass:NSClassFromString(@"_UIVisualEffectSubview")])
    {
        superView.hidden = YES;
    }
    
    
    for (UIView *view in superView.subviews)
        
    {
        
        [self getBackView:view];
        
    }
}
-(void)hideBackBtn{
    
}
- (void)setRightButtonWithTitle:(NSString*)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage rect:(CGRect)rect{
    UIButton *rightBtn = [[UIButton alloc] init];
    if (CGRectIsNull(rect)) {
        [rightBtn setFrame:CGRectMake(0, 0, 44, 44)];
    }else {
        [rightBtn setFrame:rect];
    }
    if (title) {
        [rightBtn setTitle:title forState:UIControlStateNormal];
        
        if (titleColor) {
            [rightBtn setTitleColor:titleColor forState:UIControlStateNormal];
        }else {
            [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if (titleFont > 0) {
            rightBtn.titleLabel.font = [UIFont systemFontOfSize:titleFont];
        }
    }
    
    if (normalImage) {
        [rightBtn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    }
    
    if (selectedImage) {
        [rightBtn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    
    [rightBtn addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -10;
    [self.navigationItem setRightBarButtonItems:@[ rightItem,negativeSeperator]];
    _tmptRightBtn = rightBtn;
    
}


-(void)showNoDataViewWithImageName:(NSString *)imageName Frame:(CGRect)frame{
    _noDataBackView = [UIView new];
    _noDataBackView.frame = frame ;
    [self.view addSubview:_noDataBackView];
    _noDataBackView.backgroundColor = self.view.backgroundColor;
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = _noDataBackView.bounds;
//    gradient.colors = @[(id)UIColorFromRGB(0xAB82FF).CGColor,(id)UIColorFromRGB(0x5D478B).CGColor];
//    gradient.startPoint = CGPointMake(.5, 0);
//    gradient.endPoint = CGPointMake(.5, 1);
//    [_noDataBackView.layer addSublayer:gradient];
    
    _nodataImageView = [UIImageView new];
    [_noDataBackView addSubview:_nodataImageView];
    _nodataImageView.image = UIImageWithName(imageName);
    [_nodataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self->_noDataBackView);
        make.size.mas_equalTo(CGSizeMake(187, 196));
    }];
}
-(void)hiddenNoDataView{
    [_noDataBackView removeFromSuperview];
}

- (void)showCommentText {
    [self createTalkToobarView];
    
    [_talkToobarView becomeFirstResponder];//再次让textView成为第一响应者（第二次）这次键盘才成功显示
    [_talkToolbarText becomeFirstResponder];
}
- (void)createTalkToobarView {
    
    [self.view.window addSubview:self.bgView];
    [self.bgView setHidden:NO];
    [self addTapGesture];
    
    if (!_talkToobarView) {
        
        _talkToobarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   self.view.bounds.size.height - 40.0f,
                                                                   self.view.bounds.size.width,
                                                                   40.0f)];
        _talkToobarView.backgroundColor = [UIColor whiteColor];
        
        _talkToolbarText = [[UITextView alloc] initWithFrame:CGRectMake(10.0f,
                                                                        6.0f,
                                                                        _talkToobarView.bounds.size.width - 20.0f - 68.0f,
                                                                        30.0f)];
        _talkToolbarText.layer.borderColor   = [UIColorWithRGBA(212.0, 212.0, 212.0, 1) CGColor];
        _talkToolbarText.layer.borderWidth   = 1.0;
        _talkToolbarText.layer.cornerRadius  = 2.0;
        _talkToolbarText.layer.masksToBounds = YES;
        
        
        _talkToolbarText.inputAccessoryView  = _talkToobarView;
        _talkToolbarText.backgroundColor     = [UIColor clearColor];
        _talkToolbarText.returnKeyType       = UIReturnKeyDefault;
        //        _talkToolbarText.delegate            = self;
        _talkToolbarText.font                = [UIFont systemFontOfSize:15.0];
        
        [_talkToobarView addSubview:_talkToolbarText];
        
        UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(sendButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        sendButton.frame = CGRectMake(_talkToobarView.bounds.size.width - 68.0f,
                                      6.0f,
                                      58.0f,
                                      29.0f);
        [_talkToobarView addSubview:sendButton];
    }
    _talkToobarView.hidden = NO;
    [self.view.window addSubview:_talkToobarView];//添加到window上或者其他视图也行，只要在视图以外就好了
    dispatch_async(dispatch_get_main_queue(), ^{
        [self becomeFirstResponder];
        if (@available(iOS 9.0, *)) {
            [self.talkToolbarText isFocused];
        } else {
            // Fallback on earlier versions
        }
    });
    
    //让textView成为第一响应者（第一次）这次键盘并未显示出来，（个人觉得这里主要是将commentsView设置为commentText的inputAccessoryView,然后再给一次焦点就能成功显示）
}
- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.bgView addGestureRecognizer:tap];
}

- (void)tapGesture:(UIGestureRecognizer *)gesture {
    [self resignResponder];
}
- (UIView *)bgView {
    if (!_bgView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [view setBackgroundColor:[UIColor clearColor]];
        _bgView = view;
    }
    return _bgView;
    
}
- (void)resignResponder {
    if (_talkToolbarText) {
        [_talkToolbarText resignFirstResponder];
        _talkToolbarText = nil;
    }
    if (_talkToobarView) {
        [_talkToobarView resignFirstResponder];
        _talkToobarView.hidden = YES;
        _talkToobarView = nil;
    }
    [self.view endEditing:YES];
    [self.bgView setHidden:YES];
    self.bgView = nil;
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
