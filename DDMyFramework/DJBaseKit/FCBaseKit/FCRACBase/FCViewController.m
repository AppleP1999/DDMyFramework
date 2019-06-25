//
//  FCViewController.m
//  ShoppingGuide
//
//  Created by dengjie on 2017/2/16.
//  Copyright © 2017年 com.business.facedaogou. All rights reserved.
//

#import "FCViewController.h"
//#import "JKPromptView.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface FCViewController ()

@property (nonatomic,assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic,assign) BOOL statusBarHidden;
@property (nonatomic,assign) BOOL changeStatusBarAnimated;

@end

@interface FCViewController ()

@end

@implementation FCViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    FCViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController uc_addSubviews];
        [viewController uc_bindViewModel];
        [viewController uc_layoutNavigation];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewDidAppear:)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController uc_getNewData];
    }];
    return viewController;
}

- (instancetype)initWithViewModel:(id<FCViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//     self.native = YES;
    [self setIsReturnSlip:YES];
    self.view.backgroundColor = UIColor.whiteColor;
}

#pragma mark - system

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if (self.statusBarStyle) {
        
        return self.statusBarStyle;
    } else {
        
        return UIStatusBarStyleLightContent;
    }
}

- (BOOL)prefersStatusBarHidden {
    
    return self.statusBarHidden;
}

- (void)dealloc {
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

#pragma mark - private

- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

- (void)setIsKeyboardManagerEnable:(BOOL)isKeyboardManagerEnable {
    
//    [IQKeyboardManager sharedManager].enable = isKeyboardManagerEnable;
}

- (void)initializeSelfVCSetting {
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//        self.edgesForExtendedLayout=UIRectEdgeNone;
//    }
}

- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated {
    
    self.statusBarStyle=statusBarStyle;
    self.statusBarHidden=statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideNavigationBar:(BOOL)isHide
                 animated:(BOOL)animated{
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden=isHide;
        }];
    }
    else{
        self.navigationController.navigationBarHidden=isHide;
    }
}


/**
 弹出警告提示框
 
 @param message 提示的信息内容
 @param imageType 提示框样式，使用枚举：PromptOK，PromptAlert，PromptDel
 */
- (void)showPromptMessage:(NSString *)message andImageNameType:(int)imageType {
//    NSString *strImageName=@"";
//    if (imageType==PromptOK) {
//        strImageName=@"picker_ok_sigh";
//    }else if (imageType==PromptAlert){
//        strImageName=@"picker_alert_sigh";
//    }else if (imageType==PromptDel){
//        strImageName=@"picker_del_sigh";
//    }
//    [JKPromptView showWithImageName:strImageName message:message];
}

#pragma mark - 屏幕旋转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

#pragma mark - layzLoad

#pragma mark - RAC
/**
 *  添加控件
 */
- (void)uc_addSubviews {}

/**
 *  绑定
 */
- (void)uc_bindViewModel {}

/**
 *  设置navation
 */
- (void)uc_layoutNavigation {}

/**
 *  初次获取数据
 */
- (void)uc_getNewData {}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
