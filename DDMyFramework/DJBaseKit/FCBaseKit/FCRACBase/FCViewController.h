//
//  FCViewController.h
//  ShoppingGuide
//
//  Created by dengjie on 2017/2/16.
//  Copyright © 2017年 com.business.facedaogou. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <TMSDK/TMSDK.h>
//#import "BaseViewController.h"
#import "FCViewControllerProtocol.h"
//#import "CustomNavigationBar.h"
//#import "UIViewController+Extension.h"
//#import "IQKeyboardManager.h"
//#import "IQKeyboardReturnKeyHandler.h"
 
@interface FCViewController : UIViewController<FCViewControllerProtocol>

/**
 是否允许侧滑返回
 */
@property (nonatomic,assign) BOOL isReturnSlip;

/**
 VIEW是否渗透导航栏
 (YES_VIEW渗透导航栏下／NO_VIEW不渗透导航栏下)
 */
@property (nonatomic,assign) BOOL isExtendLayout;

/**
 是否启用键盘管理
 */
@property (nonatomic,assign) BOOL isKeyboardManagerEnable;

/**
 设置修改StatusBar

 @param statusBarStyle StatusBar样式
 @param statusBarHidden 是否隐藏StatusBar
 @param animated 是否动画过渡
 */
- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated;

/**
 隐藏显示导航栏

 @param isHide 是否隐藏导航栏
 @param animated 是否有动画过渡
 */
- (void)hideNavigationBar:(BOOL)isHide
                 animated:(BOOL)animated;


/**
 弹出警告提示框
 
 @param message 提示的信息内容
 @param imageType 提示框样式，使用枚举：PromptOK，PromptAlert，PromptDel
 */
- (void)showPromptMessage:(NSString *)message
         andImageNameType:(int)imageType;

@end
