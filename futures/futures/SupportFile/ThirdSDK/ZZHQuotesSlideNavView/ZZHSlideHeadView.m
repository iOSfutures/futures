//
//  SlideHeadView.m
//  futures
//
//  Created by apple on 2020/5/14.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "ZZHSlideHeadView.h"
#import "UIView+Extension.h"

@interface ZZHSlideHeadView ()
@property(nonatomic,assign,getter=isTranslucent) BOOL translucent NS_AVAILABLE_IOS(3_0) UI_APPEARANCE_SELECTOR; // Default is NO on iOS 6 and earlier. Always YES if barStyle is set to UIBarStyleBlackTranslucent
@end

/** 文字高度  */
static CGFloat const titleH = 44;
/** 选中文字放大  */
static CGFloat const MaxScale = 1.0;


@implementation ZZHSlideHeadView

/** 标签按钮  */
- (NSMutableArray *)buttons
{
    if (!_buttons)
    {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

//-(id)init{
//    if (self = [super init])
//    {
//
//
//    }
//    return self;
//}

-(void)setSlideHeadView{

    [self setTitleScrollView];        /** 添加文字标签  */
    
    [self setContentScrollView];      /** 添加scrollView  */
    
    [self setupTitle];                /** 设置标签按钮 文字 背景图  */
    
    //设置setContentScrollView属性
    self.contentScrollView.contentSize = CGSizeMake(self.titlesArr.count * SCREEN_WIDTH, 0);
    self.contentScrollView.pagingEnabled = YES;
    // 水平滚动指示器
    self.contentScrollView.showsHorizontalScrollIndicator  = NO;
    self.contentScrollView.delegate = self;
    // 弹跳
    self.contentScrollView.bounces = NO;
}

- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target = sourceView;
    while (target) {
        //像一个响应者的目标赋值给target
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

#pragma mark - PRIVATE

-(void)addChildViewController:(UIViewController *)childVC title:(NSString *)vcTitle{
    UIViewController *superVC = [self findViewController:self];
    childVC.title = vcTitle;
    [superVC addChildViewController:childVC];
    
}
-(void)setTitleScrollView{
     UIViewController *superVC = [self findViewController:self];
 
    CGRect rect  = CGRectMake(0, 88, SCREEN_WIDTH, titleH + 40);
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
//    self.titleScrollView.backgroundColor = UIColor.redColor;
    self.titleScrollView.backgroundColor = UIColorWithRGBA(254, 162, 3, 1);
    [superVC.view addSubview:self.titleScrollView];
    
}
-(void)setContentScrollView{
    UIViewController *superVC = [self findViewController:self];
    //修改导航栏为rgba(254, 162, 3, 1)颜色
//    设置一个透明的图片
//    [superVC.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [superVC.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    superVC.navigationController.navigationBar.translucent = YES;
//    superVC.navigationController.navigationBar.backgroundColor = UIColorWithRGBA(254, 162, 3, 1);
//    superVC.navigationController.navigationBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGFloat y  = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect rect  = CGRectMake(0, y, SCREEN_WIDTH, SCREEN_HEIGHT - titleH);
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    [superVC.view addSubview:self.contentScrollView];
    
    
}
/** 设置标签按钮 文字 背景图  */
-(void)setupTitle{
    UIViewController *superVC = [self findViewController:self];
    
    NSUInteger count = superVC.childViewControllers.count;
    CGFloat x = -7.5;
    //文字间距
    CGFloat w = 102;
    CGFloat h = titleH;
    /** 选中图片 */
//    self.imageBackView  = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 102-10, titleH-10)];
    self.imageBackView  = [[UIImageView alloc] initWithFrame:CGRectMake(40 + 10, titleH - 5, 10, 2)];
    self.imageBackView.image = [UIImage imageNamed:@""];
    self.imageBackView.backgroundColor = [UIColor whiteColor];
    self.imageBackView.userInteractionEnabled = YES;
    [self.titleScrollView addSubview:self.imageBackView];
    
    
    for (int i = 0; i < count; i++)
    {
        UIViewController *vc = superVC.childViewControllers[i];
        
        x = i * w;
        CGRect rect = CGRectMake(x, 0, w, h);
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
        
        btn.tag = i;
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        
        [self.buttons addObject:btn];
        [self.titleScrollView addSubview:btn];
        
        
        if (i == 0)
        {
            [self click:btn];
        }
        
    }
    
    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
}
-(void)click:(UIButton *)sender{
    
    [self selectTitleBtn:sender];
    NSInteger i = sender.tag;
    CGFloat x  = i * SCREEN_WIDTH;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
    [self setUpOneChildController:i];
    
    
}

/** 选中按钮 */
-(void)selectTitleBtn:(UIButton *)btn{
    
    
    [self.selectedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.selectedBtn.transform = CGAffineTransformIdentity;
    
    
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(MaxScale, MaxScale);
    self.selectedBtn = btn;
    
    [self setupTitleCenter:btn];
    
}

-(void)setupTitleCenter:(UIButton *)sender
{
    
    CGFloat offset = sender.center.x - SCREEN_WIDTH * 0.5;
    if (offset < 0) {
        offset = 0;
    }
    
    CGFloat maxOffset  = self.titleScrollView.contentSize.width - SCREEN_WIDTH;
    if (offset > maxOffset && maxOffset>0) {
        offset = maxOffset;
    }

//    NSLog(@"%lf,%lf,%ld",offset,maxOffset,sender.tag);
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
}

-(void)setUpOneChildController:(NSInteger)index{
    UIViewController *superVC = [self findViewController:self];
    
    CGFloat x  = index * SCREEN_WIDTH;
    UIViewController *vc  =  superVC.childViewControllers[index];
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(x, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.contentScrollView.frame.origin.y);
    [self.contentScrollView addSubview:vc.view];
    
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger i  = self.contentScrollView.contentOffset.x / SCREEN_WIDTH;
    [self selectTitleBtn:self.buttons[i]];
    [self setUpOneChildController:i];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX  = scrollView.contentOffset.x;
    NSInteger leftIndex  = offsetX / SCREEN_WIDTH;
    NSInteger rightIdex  = leftIndex + 1;
    
    UIButton *leftButton = self.buttons[leftIndex];
    UIButton *rightButton  = nil;
    if (rightIdex < self.buttons.count) {
        rightButton  = self.buttons[rightIdex];
    }
    CGFloat scaleR  = offsetX / SCREEN_WIDTH - leftIndex;
    CGFloat scaleL  = 1 - scaleR;
    CGFloat transScale = MaxScale - 1;
    
    self.imageBackView.transform  = CGAffineTransformMakeTranslation((offsetX*(self.titleScrollView.contentSize.width / self.contentScrollView.contentSize.width)), 0);
    
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
    
    UIColor *rightColor = [UIColor colorWithRed:(174+66*scaleR)/255.0 green:(174-71*scaleR)/255.0 blue:(174-174*scaleR)/255.0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:(174+66*scaleL)/255.0 green:(174-71*scaleL)/255.0 blue:(174-174*scaleL)/255.0 alpha:1];
    
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    
}

@end
