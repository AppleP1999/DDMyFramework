//
//  FCBaseNetworkTools.m
//  FCBaseKit
//
//  Created by omni－appple on 2018/11/19.
//  Copyright © 2018年 ZhouYou. All rights reserved.
//

#import "FCBaseNetworkTools.h"
#import <AFNetworking/AFNetworking.h>
@implementation FCBaseNetworkTools
+ (void)httpRequest:(NSString *)url param:(id)param type:(FCBaseNetworkType)type complete:(void(^)(id response,NSString *error))result
{
    if (type == FCBaseNetworkHttpGet)
    {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             if (result)
             {
                 if ([responseObject[@"code"] intValue] == 200)
                 {
                     result(responseObject,nil);
                 }
                 else
                 {
                     result(nil,responseObject[@"msg"]);
                 }
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (result)
             {
                 result(nil, error.localizedDescription);
             }
         }];
    }
    else if (type == FCBaseNetworkHttpPost)
    {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (result)
            {
                if ([responseObject[@"code"] intValue] == 200)
                {
                    result(responseObject,nil);
                }
                else
                {
                    result(nil,responseObject[@"msg"]);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (result)
            {
                result(nil, error.localizedDescription);
            }
        }];
    }
}
@end
