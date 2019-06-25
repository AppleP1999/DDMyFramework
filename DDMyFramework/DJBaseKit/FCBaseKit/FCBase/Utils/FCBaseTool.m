//
//  FCBaseTool.m
//  FCBaseKit
//
//  Created by omni－appple on 2018/11/12.
//  Copyright © 2018年 ZhouYou. All rights reserved.
//

#import "FCBaseTool.h"
#import "UIAlertView+FCBlocks.h"
#import "UIAlertController+FCBlocks.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import "FCButtonItem.h"
#import <sys/stat.h>
#import <sys/sysctl.h>
 
@implementation FCBaseTool
 
+ (void)showActionSheetInViewController:(UIViewController *)Vc   cancelText:(NSString*) cancelText otherButtons:(NSArray<NSString*>*)Titles 
	confirmBlaock:(UIAlertControllerCompletionBlock)confirmBlaock  
	

{
//				__weak UIViewController * weakVC = Vc; 
		    [UIAlertController showActionSheetInViewController:Vc
                                             withTitle: nil
                                               message:nil
                                     cancelButtonTitle:cancelText
                                destructiveButtonTitle:nil
                                     otherButtonTitles:Titles
#if TARGET_OS_IOS
                    popoverPresentationControllerBlock:^(UIPopoverPresentationController *popover){
                        popover.sourceView = Vc.view;
//                        popover.sourceRect = sender.frame;
                    }
#endif
                                              tapBlock:confirmBlaock];
}

+ (void)showAlertViewTitle:(NSString *)title  message:(NSString*)message cancelBlaock:(void(^)(void))cancelBlaock confirmBlaock:(void(^)(void))confirmBlaock
{
	  [[[UIAlertView alloc] initWithTitle:title
                                message:message
                       cancelButtonItem:[FCButtonItem itemWithLabel:@"取消" action:cancelBlaock]
                       otherButtonItems:[FCButtonItem itemWithLabel:@"确定" action:confirmBlaock], nil] show];	
}
+ (void)showLoginAlertView:(UIViewController *)from
{
    [[[UIAlertView alloc] initWithTitle:@"未登入"
                                message:@"请先登录"
                       cancelButtonItem:[FCButtonItem itemWithLabel:@"取消" action:^{
    }]
                       otherButtonItems:[FCButtonItem itemWithLabel:@"登录" action:^{
        [FCBaseTool toLoginViewController:from];
    }], nil] show];
}

/**
 push ->SetI001LoginViewControlle
 */
+ (void)toLoginViewController:(UIViewController *)from
{
    if (from)
    {
        UIViewController *vc = [[NSClassFromString(@"SetI001LoginViewController") alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        if (vc)
        {
            if (from.navigationController)
                [from.navigationController pushViewController:vc animated:YES];
            else
                [from presentViewController:vc animated:YES completion:nil];
        }
    }
}


#pragma mark - -------系统或UI相关
+ (UIViewController*)currentViewController
{
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }
        else{
            break;
        }
    }
    return vc;
}

+ (NSString *)deviceModelName{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine
                                                encoding:NSUTF8StringEncoding];
    //simulator
    if ([platform isEqualToString:@"i386"])          return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])        return @"Simulator";
 
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"])     return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])     return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])     return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])     return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])     return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])     return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])     return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])     return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"])     return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])     return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"])     return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])     return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])     return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])     return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])     return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])     return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])     return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])     return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"])     return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])     return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"])     return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])    return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"])    return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"])    return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"])    return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"])    return @"iPhone XS Max";
 
    return platform;
}

+ (UIViewController *)controllerByView:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - ---extern公共方法
//去掉中文字符
extern NSString * ExtractAllChar(NSString *strOri, int type)
{
    NSMutableString *strippedString = [NSMutableString stringWithCapacity:strOri.length];
    
    NSString *extract = nil;
    if (type == 0) {        //字数和字母
        extract = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        
    } else if (type == 1) { //url
        extract = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ./@&%?=[]:*$#!()~-_=+";
    }
    else if (type == 2) {   //字数
        extract = @"0123456789";
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:strOri];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString: extract];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
            
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    return strippedString;
}

extern NSString* stringForDateFormat(NSString* string)
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:string];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //    [dateFormatter release];
    return currentDateStr;
}

extern NSString* documentDir(NSString* strDir)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (strDir) {
        
        NSString *strNewDir = [NSString stringWithFormat:@"%@/%@",[paths objectAtIndex:0],strDir];
        BOOL isDir = NO;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL existed = [fileManager fileExistsAtPath:strNewDir isDirectory:&isDir];
        if ( !(isDir == YES && existed == YES) )
            [fileManager createDirectoryAtPath:strNewDir withIntermediateDirectories:YES attributes:nil error:nil];
        return strNewDir;
    }
    else
        return [paths objectAtIndex:0];
}

extern NSString* fixDocumentDir(NSString* strDir){
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (strDir) {
        
        NSString *strNewDir = [paths objectAtIndex:0];
        NSRange range=[strDir rangeOfString:@"Documents"];
        if (range.length == 0) {
            return strDir;
        }
        NSString *relativePath=[strDir substringFromIndex:range.location+range.length];
        NSString *newPath=[NSString stringWithFormat:@"%@%@",strNewDir,relativePath];
        return newPath;
    }
    return strDir;
}

extern uint64_t fileSizeAtPath(NSString* filePath)
{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}

extern NSString* generateUUID()
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    uuid = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    uuid = [uuid lowercaseString];
    return uuid;
}

extern BOOL isMobileNumber(NSString* mobileNum)
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

extern BOOL validateEmail(NSString* candidate)
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

#pragma mark - ---其他公用方法
+ (NSString *)getTimeFromTimestamp:(NSString *)timestamp formatter:(NSString *)formatterString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: formatterString];
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier: language];
    [formatter setLocale:locale];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue] / 1000];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSDate *)getDateFromTimestamp:(NSString *)timestamp
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue] / 1000];
    return date;
}

+ (NSArray *)jsonStringToArr:(NSString *)json {
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    }
    return [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]])
        return nil;
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)allowedCharactrsUrl:(NSString *)url
{
    NSString *charactersToEscape = @"`#%^{}\"[]|\\<> ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    return [url stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
