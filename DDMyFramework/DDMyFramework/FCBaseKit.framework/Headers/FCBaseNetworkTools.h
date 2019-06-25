//
//  FCBaseNetworkTools.h
//  FCBaseKit
//
//  Created by omni－appple on 2018/11/19.
//  Copyright © 2018年 ZhouYou. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    FCBaseNetworkHttpGet,
    FCBaseNetworkHttpPost,
} FCBaseNetworkType;

@interface FCBaseNetworkTools : NSObject

+ (void)httpRequest:(NSString *)url param:(id)param type:(FCBaseNetworkType)type complete:(void(^)(id response,NSString *error))result;


@end
