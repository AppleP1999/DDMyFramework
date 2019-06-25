//
//  FCBaseTool.h
//  FCBaseKit
//
//  Created by omni－appple on 2018/11/12.
//  Copyright © 2018年 ZhouYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIAlertController+FCBlocks.h"
//#import <TMSDK/TMSDK.h>
#define KISIphoneX (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f, 375.f), [UIScreen mainScreen].bounds.size))
#define kStatusBarHeight (KISIphoneX?(44.f):(20.f))
/*----------------------------------------------------------------------------------
 *                      Block/Block-weak-strong避免循环引用                                *
 ----------------------------------------------------------------------------------*/
#define FCBLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); }

@interface FCBaseTool : NSObject

/**
 
UIAlertControllerStyleActionSheet  的弹框
 @param Vc 当前控制器
 
 @param confirmBlaock buttonIndex >= controller.firstOtherButtonIndex 是
 */
+ (void)showActionSheetInViewController:(UIViewController *)Vc  cancelText:(NSString*)cancelText otherButtons:(NSArray<NSString*>*)Titles 
	confirmBlaock:(UIAlertControllerCompletionBlock)confirmBlaock ;
/**
 弹框是否确认警告框

 @param title 提示信息标题
 @param message 消息内容
 @param cancelBlaock 取消回调
 @param confirmBlaock 确定回调
 */
+ (void)showAlertViewTitle:(NSString *)title  message:(NSString*)message cancelBlaock:(void(^)(void))cancelBlaock confirmBlaock:(void(^)(void))confirmBlaock;
#pragma mark - --组件逻辑相关相关
/**
 是否登入提示框
 */
+ (void)showLoginAlertView:(UIViewController *)from;

/**
 push  进入登入界面
 */
+ (void)toLoginViewController:(UIViewController *)from;


#pragma mark - --系统或UI相关
/**
 获取当前viewcontroller
 */
+ (UIViewController*)currentViewController;

/**
 判断当前机型

 @return 机型名称
 */
+ (NSString *)deviceModelName;

/**
 根据view获取viewcontroller
 
 @return viewcontroller
 */
+ (UIViewController *)controllerByView:(UIView *)view;

#pragma mark - ---extern公共方法
//去掉中文字符
extern NSString* ExtractAllChar(NSString *strOri, int type);
//获取根据时间yyyyMMddHHmmss | yyyy-MM-dd HH:mm:ss
extern NSString* stringForDateFormat(NSString* string);
//获取程序所在Docment目录,形参为在根目录下增加的路径
extern NSString* documentDir(NSString* strDir);

extern NSString* fixDocumentDir(NSString* strDir);
//获取文件大小
extern uint64_t fileSizeAtPath(NSString* filePath);
//随机产生UUID
extern NSString* generateUUID();
//
extern BOOL isMobileNumber(NSString* mobileNum);
//
extern BOOL validateEmail(NSString* candidate);

#pragma mark - --其它公用方法

/**
 得到日期戳
 */
+ (NSString *)getTimeFromTimestamp:(NSString *)timestamp formatter:(NSString *)formatterString;
+ (NSDate *)getDateFromTimestamp:(NSString *)timestamp;
+ (NSArray *)jsonStringToArr:(NSString *)json;
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
/**
 去掉如"`#%^{}\"[]|\\<> "特殊符号
 @return NSString*
 */
+ (NSString *)allowedCharactrsUrl:(NSString *)url;
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
