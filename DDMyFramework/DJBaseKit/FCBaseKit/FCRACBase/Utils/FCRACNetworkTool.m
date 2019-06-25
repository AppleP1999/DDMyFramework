//
//  FCRACNetworkTool.m
//  DJBase
//
//  Created by dengjie on 17/1/13.
//  Copyright © 2017年 u1city01. All rights reserved.
//
#define kBaseURL @"http://www.baidu.com"
#import "FCRACNetworkTool.h"
//#import <TMSDK/TMSDK.h>
//#import "NSDate+Extension.h"
#define baseURLString @""
@implementation FCRACNetworkTool

DEFINE_SINGLETON_IMPLEMENTATION(FCRACNetworkTool)

- (void)setUp {
    self.netType = WiFiNet;
    [[self startMonitoringNet] subscribeNext:^(id x) {
        
    }];
}

/**
 创建检查网络信号
 
 @return <#return value description#>
 */
- (RACSignal *)startMonitoringNet {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    KWeakSelf;
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case -1:
                    weakSelf.netType = NONet;
                    break;
                case 0:
                    weakSelf.netType = NONet;
                    break;
                case 1:
                    weakSelf.netType = OtherNet;
                    break;
                case 2:
                    weakSelf.netType = WiFiNet;
                    break;
                    
                default:
                    break;
            }
            [subscriber sendNext:(weakSelf.netType==NONet?@"0":@"1")];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

/**
 创建网络请求管理类单例对象
 
 @return <#return value description#>
 */
+ (AFHTTPSessionManager *)sharedAFHTTPSessionManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO//如果是需要验证自建证书，需要设置为YES
        securityPolicy.allowInvalidCertificates = NO;
        //validatesDomainName 是否需要验证域名，默认为YES；
        securityPolicy.validatesDomainName = NO;
        manager.securityPolicy = securityPolicy;
    });
    return manager;
}

/**
 GET响应式请求
 
 @param parameters 参数
 @param parameters method 接口地址
 @return <#return value description#>
 */
+ (RACSignal *)racGETWithParameters:(NSDictionary *)parameters method:(NSString *)method
{
    
    if ([FCRACNetworkTool sharedFCRACNetworkTool].netType == NONet) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:[[FCApiResultModel alloc] initWithEnableNet]];
            [subscriber sendCompleted];
            return nil;
        }];
    }
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    			
        NSURLSessionDataTask *task = [[FCRACNetworkTool sharedAFHTTPSessionManager] GET:method parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [subscriber sendNext:[[FCApiResultModel alloc] initWithDict:responseObject]];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendNext:[[FCApiResultModel alloc] initWithInterfaceError]];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

/**
 GET响应式请求
 
 @param parameters 参数
 @param intervals 时间间隔
 @return <#return value description#>
 */
+ (RACSignal *)racGETWithParameters:(NSDictionary *)parameters intervals:(int)intervals  method:(NSString *)method{
    
//    if (![ApiTokenHelper isRequestVerifyWithMethod:parameters[@"method"] withPostTime:parameters[@"postTime"] intervals:intervals])
//    {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:[[FCApiResultModel alloc] initWithNotAllowRequest]];
            [subscriber sendCompleted];
            return nil;
        }];
//    }
    return [FCRACNetworkTool racGETWithParameters:parameters method:method] ;
}

/**
 POST响应式请求
 
 @param parameters 参数
 @return <#return value description#>
 */
+ (RACSignal *)racPOSTWithParameters:(NSDictionary *)parameters method:(NSString *)method 
{
    
    if ([FCRACNetworkTool sharedFCRACNetworkTool].netType == NONet) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:[[FCApiResultModel alloc] initWithEnableNet]];
            [subscriber sendCompleted];
            return nil;
        }];
    }
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
        NSURLSessionDataTask *task = [[FCRACNetworkTool sharedAFHTTPSessionManager] POST:method parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [subscriber sendNext:[[FCApiResultModel alloc] initWithDict:responseObject]];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendNext:[[FCApiResultModel alloc] initWithInterfaceError]];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end
