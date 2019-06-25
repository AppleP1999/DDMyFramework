//
//  ApiResultModel.h
//  TaoShop
//
//  Created by u1city01 on 14-7-30.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCApiResultModel : NSObject
@property(strong,nonatomic)NSString *method;
@property(strong,nonatomic)NSString *code;
@property(strong,nonatomic)NSString *message;
@property(strong,nonatomic)NSDictionary *returndata;

-(id)initWithDict:(NSDictionary *)dict;//构造方法

//接口返回错误数据模型
- (id)initWithInterfaceError;

//无网络数据模型
- (id)initWithEnableNet;

//没过时间间隔不允许访问接口
- (id)initWithNotAllowRequest;

@end
