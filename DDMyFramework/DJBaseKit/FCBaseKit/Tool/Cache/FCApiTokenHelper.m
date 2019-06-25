//
//  FCApiTokenHelper.m
//  DJBaseKit
//
//  Created by omni－appple on 2019/5/10.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//
#import "FCCacheTool.h"
#import "FCApiTokenHelper.h"
#import "NSDate+FCExtension.h"
@implementation FCApiTokenHelper

/**
 接口访问时间间隔验证
 
 @param method 接口名称
 @param postTime 调用时间
 @param intervals 时间间隔，单位分钟
 @return 是否发起请求
 */
+ (BOOL)isRequestVerifyWithMethod:(NSString *)method withPostTime:(NSString *)postTime intervals:(int)intervals 
{
    
    BOOL isResult = NO;
    
    NSMutableDictionary *dict = [FCCacheTool readPlist:@"net.plist" dataClass:[NSMutableDictionary class]];
    
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
    }
    
    if ([dict objectForKey:method]) {
        
        NSDate *lastDate = [NSDate dateWithDateString:[dict objectForKey:method] datetype:1];
        NSDate *thisDate = [NSDate dateWithDateString:postTime datetype:1];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSCalendarUnitMinute;
        
        NSDateComponents *d = [cal components:unitFlags fromDate:lastDate toDate:thisDate options:0];
        int minute = (int)[d minute];
        if (minute >= intervals) {
            
            [dict setObject:postTime forKey:method];
            
            isResult = YES;
        }
        
    } else {
        
        [dict setObject:postTime forKey:method];
        
        isResult = YES;
    }
    
    if (isResult) {
        [FCCacheTool savePlist:@"net.plist" dataObj:dict];
    }
    
    return isResult;
}

@end
