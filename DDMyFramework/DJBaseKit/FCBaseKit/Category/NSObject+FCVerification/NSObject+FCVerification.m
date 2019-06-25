//
//  NSObject+FCVerification.m
//  DJBaseKit
//
//  Created by omni－appple on 2019/5/9.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import "NSObject+FCVerification.h"

@implementation NSObject (FCVerification)

/**
 判断字符串是否为空

 @param obj 要判断的值
 @return null或者nil或者空 返回 YES 其他返回 NO
 */
+ (BOOL)ldy_isEmpty:(id)obj {
    if (obj==nil || [obj isEqual:[NSNull null]]) return YES;
    
    if ([obj isKindOfClass:[NSString class]]) {
        if ([obj isEqualToString:@""]) return YES;

        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [obj stringByTrimmingCharactersInSet:set];
        if ([trimedString length]==0) return YES;
    }
    
    return NO;
}

/**
 判断数字是否大于0

 @param obj 要判断的值
 @return 大于0返回 YES 其他返回 NO
 */
+ (BOOL)ldy_isNumberBigZero:(id)obj {
    if ([NSObject ldy_isEmpty:obj]) return NO;

    if ([obj isKindOfClass:[NSNumber class]]) {
        if ([obj intValue]>0) return YES;
    }
    
    return NO;
}

/**
 返回非nil和NULL字符串

 @param obj 输入参数
 @return 返回非nil和NULL字符串
 */
+ (NSString *)ldy_returnNoEmpty:(id)obj {
    NSString *result = @"";
    if (obj!=nil && ![obj isEqual:[NSNull null]]) {
        result = [NSString stringWithFormat:@"%@", obj];
    }
    return result;
}

/**
 返回非nil和NSNULL字符串，如果为空有传默认值，就返回默认值。没有就返回@“”
 
 @param value 要判断的值
 @param str 默认值
 @return <#return value description#>
 */
+ (NSString *)ldy_toString:(id)value defaultStr:(NSString *)defaultStr {
    NSString *returnString = @"";
    if (value != nil && ![value isKindOfClass:[NSNull class]] && ![value isEqual:[NSNull null]]) {
        NSString *val = [NSString stringWithFormat:@"%@",value];
        if ([NSObject ldy_isNonEmptyString:val]) {
            returnString = val;
        }
    }
    if ([returnString isEqualToString:@""] && [NSObject ldy_isNonEmptyString:defaultStr]) {
        returnString = [NSString stringWithFormat:@"%@",defaultStr];
    }
    return returnString;
}

/**
 将距离转换为字符串(50公里)
 
 @param distance 距离
 @return <#return value description#>
 */
+ (NSString *)ldy_formatDistance:(CGFloat)distance {
    NSString *distanceStr = @"";
    if (distance == 0) {
        distanceStr = @"";
    }else{
        if (distance >= 1000 && distance < 50000) {//公里
            distanceStr = [NSString stringWithFormat:@"%.2lf公里",distance/1000.00];
        } else if (distance >= 50000) {
            distanceStr = @"超过50公里";
        } else{//米
            distanceStr = [NSString stringWithFormat:@"%.0lf米",distance];
        }
    }
    return distanceStr;
}

/**
 是否能拨打电话或发送短信

 @return <#return value description#>
 */
+ (BOOL)ldy_isCanCallPhomeOrSendSms {
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"]) {
        return NO;
    }
    return YES;
}

/**
 URL解码

 @return <#return value description#>
 */
- (NSString*)ldy_urlDecodedString {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)(NSString *)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    return result;
}

/**
 是否是非空字符串

 @param obj 要判断数据
 @return YES 是 NO 否
 */
+ (BOOL)ldy_isNonEmptyString:(id)obj {
    //是否字符串
    if (![obj isKindOfClass:[NSString class]]) return NO;
    //字符串是否为空
    if ([NSObject ldy_isEmpty:obj]) return NO;
    //非空字符串
    return YES;
}

/**
 是否字典类型

 @param obj 要判断数据
 @return YES 是 NO 否
 */
+ (BOOL)ldy_isDictionary:(id)obj {
    //是否nil或NULL
    if (self==nil || [self isEqual:[NSNull null]]) return NO;
    //是否字典类型
    if (![obj isKindOfClass:[NSDictionary class]]) return NO;
    
    if (((NSDictionary *)obj).count == 0) return NO;
    
    return YES;
}

/**
 返回非nil和NSNULL字符串

 @return <#return value description#>
 */
- (NSString *)ldy_toString {
    if (self != nil && ![self isKindOfClass:[NSNull class]]) {
        return [NSString stringWithFormat:@"%@",self];
    } else {
        return @"";
    }
}

/**
 返回非nil和NSNULL字符串

 @param defaulrStr 默认返回字符串
 @return <#return value description#>
 */
- (NSString *)ldy_toString:(NSString *)defaulrStr {
    if (self != nil && ![self isKindOfClass:[NSNull class]]) {
        return [NSString stringWithFormat:@"%@",self];
    } else {
        return defaulrStr;
    }
}

/**
 返回NSInteger类型数字 只判断 NSNumber 和 NSSString 其他返回-1

 @return <#return value description#>
 */
- (int)ldy_toIntValue {
    if (([self isKindOfClass:[NSNumber class]] || [self isKindOfClass:[NSString class]])
        && self != nil
        && ![self isKindOfClass:[NSNull class]]) {
        return [[NSString stringWithFormat:@"%@",self] intValue];
    } else {
        return -1;
    }
}

@end
