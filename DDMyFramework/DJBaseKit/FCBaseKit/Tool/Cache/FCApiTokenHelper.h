//
//  FCApiTokenHelper.h
//  DJBaseKit
//
//  Created by omni－appple on 2019/5/10.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCApiTokenHelper : NSObject
/**
 接口访问时间间隔验证
 
 @param method 接口名称
 @param postTime 调用时间
 @param intervals 时间间隔，单位分钟
 @return 是否发起请求
 */
+ (BOOL)isRequestVerifyWithMethod:(NSString *)method withPostTime:(NSString *)postTime intervals:(int)intervals;
@end
