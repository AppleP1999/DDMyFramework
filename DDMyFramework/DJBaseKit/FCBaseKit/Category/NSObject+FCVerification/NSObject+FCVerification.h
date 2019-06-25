//
//  NSObject+FCVerification.m
//  DJBaseKit
//
//  Created by omni－appple on 2019/5/9.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSObject (FCVerification)

/**
 判断字符串是否为空
 
 @param obj 要判断的值
 @return null或者nil或者空 返回 YES 其他返回 NO
 */
+ (BOOL)ldy_isEmpty:(id)obj;

/**
 判断数字是否大于0
 
 @param obj 要判断的值
 @return 大于0返回 YES 其他返回 NO
 */
+ (BOOL)ldy_isNumberBigZero:(id)obj;

/**
 返回非nil和NULL字符串
 
 @param obj 输入参数
 @return 返回非nil和NULL字符串
 */
+ (NSString *)ldy_returnNoEmpty:(id)obj;

/**
 返回非nil和NSNULL字符串，如果为空有传默认值，就返回默认值。没有就返回@“”
 
 @param value 要判断的值
 @param str 默认值
 @return <#return value description#>
 */
+ (NSString *)ldy_toString:(id)value defaultStr:(NSString *)defaultStr;

/**
 将距离转换为字符串(50公里)
 
 @param distance 距离
 @return <#return value description#>
 */
+ (NSString *)ldy_formatDistance:(CGFloat)distance;

/**
 是否能拨打电话或发送短信
 
 @return <#return value description#>
 */
+ (BOOL)ldy_isCanCallPhomeOrSendSms;

/**
 URL解码
 
 @return <#return value description#>
 */
- (NSString*)ldy_urlDecodedString;

/**
 是否是非空字符串
 
 @param obj 要判断数据
 @return YES 是 NO 否
 */
+ (BOOL)ldy_isNonEmptyString:(id)obj;

/**
 是否字典类型
 
 @param obj 要判断数据
 @return YES 是 NO 否
 */
+ (BOOL)ldy_isDictionary:(id)obj;

/**
 返回非nil和NSNULL字符串
 
 @return <#return value description#>
 */
- (NSString *)ldy_toString;

/**
 返回非nil和NSNULL字符串
 
 @param defaulrStr 默认返回字符串
 @return <#return value description#>
 */
- (NSString *)ldy_toString:(NSString *)defaulrStr;

/**
 返回int类型数字 只判断 NSNumber 和 NSSString 其他返回-1
 
 @return <#return value description#>
 */
- (int)ldy_toIntValue;

@end
