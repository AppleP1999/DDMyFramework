//
//  testHeader.h
//  DJTest
//
//  Created by omni－appple on 2019/5/8.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#ifndef testHeader_h
#define testHeader_h
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

typedef void(^LPCodingHandler)(objc_property_t property, NSString * propertyName);

/// 遍历属性列表
#define LPCodingHandlerDef    \
    - (void)codingPropertiesWithHandler:(LPCodingHandler) codingHandler \
    { \
        unsigned int propertyCount; \
        objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);\
        for (int i = 0; i<propertyCount; i++) { \
            \
            objc_property_t property = properties[i];\
            if (codingHandler) {\
                \
                codingHandler(property,[NSString stringWithUTF8String:property_getName(property)]);\
            }\
        }\
        \
        free(properties);\
    }

// 序列化
#define LPEncodeWithCoder \
- (void)encodeWithCoder:(NSCoder *)aCoder \
{ \
    [self codingPropertiesWithHandler:^(objc_property_t property, NSString *propertyName) { \
        [aCoder encodeObject:[self valueForKey:propertyName] forKey:propertyName]; \
    }]; \
}

// 反序列化
#define LPInitWithCoder \
    - (nullable instancetype)initWithCoder:(NSCoder *)aDecoder \
    { \
        self = [super init]; \
        if (self) { \
            [self codingPropertiesWithHandler:^(objc_property_t property, NSString *propertyName) { \
                [self setValue:[aDecoder decodeObjectForKey:propertyName] forKey:propertyName]; \
            }]; \
        } \
        return self; \
    } 

// 遵守NSCoding协议的model只要在.m中加入这句宏定义，即可实现序列化反序列化功能

#define LPCodingPropertyImplementation \
        LPCodingHandlerDef \
        LPEncodeWithCoder \
        LPInitWithCoder

 

#endif /* testHeader_h */
