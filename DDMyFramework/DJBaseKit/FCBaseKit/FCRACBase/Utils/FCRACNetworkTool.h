//
//  FCRACNetworkTool.h
//
//
//  Created by dengjie on 17/1/13.
//  Copyright © 2017年 u1city01. All rights reserved.
//
#import <AFHTTPSessionManager.h> 
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "FCApiResultModel.h"
#import "FCBaseDefine.h"
#import <ReactiveObjC/ReactiveObjC.h>

typedef NS_ENUM(NSInteger, NetType) {
    NONet,
    WiFiNet,
    OtherNet,
};

@interface FCRACNetworkTool : NSObject
@property(nonatomic, assign) NSInteger netType;

DEFINE_SINGLETON_INTERFACE(FCRACNetworkTool);
 
/**
 创建检查网络信号
 
 @return <#return value description#>
 */
- (RACSignal *)startMonitoringNet;

/**
 GET响应式请求
 
 @param parameters 参数
 @return <#return value description#>
 */
+ (RACSignal *)racGETWithParameters:(NSDictionary *)parameters method:(NSString *)method ;

/**
 GET响应式请求
 
 @param parameters 参数
 @param intervals 时间间隔
 @return <#return value description#>
 */
+ (RACSignal *)racGETWithParameters:(NSDictionary *)parameters intervals:(int)intervals method:(NSString *)method;
/**
 POST响应式请求
 
 @param parameters 参数
 @return <#return value description#>
 */
+ (RACSignal *)racPOSTWithParameters:(NSDictionary *)parameters method:(NSString *)method ;

@end
