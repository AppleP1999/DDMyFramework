//
//  CreateLiveHeader.h
//  DDMyFramework
//
//  Created by omni－appple on 2019/2/22.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#ifndef CreateLiveHeader_h
#define CreateLiveHeader_h
//#define kHeight(h) ([UIScreen mainScreen].bounds.size.height / 667.0 * h)
//#define kWidth(w) ([UIScreen mainScreen].bounds.size.width / 375.0 * w)

//-------------------单例化一个类-------------------------//
#define DD_DEFINE_SINGLETON_INTERFACE(className) \
+ (className *)shared##className;


#define DD_DEFINE_SINGLETON_IMPLEMENTATION(className) \
static className *shared##className = nil; \
static dispatch_once_t pred; \
\
+ (className *)shared##className { \
dispatch_once(&pred, ^{ \
shared##className = [[super allocWithZone:NULL] init]; \
if ([shared##className respondsToSelector:@selector(setUp)]) {\
[shared##className setUp];\
}\
}); \
return shared##className; \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
return [self shared##className];\
} \
\
- (id)copyWithZone:(NSZone *)zone { \
return self; \
}
//-------------------单例化一个类-------------------------//

#define DDWS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define DDFORMAT(fmt,...)[NSString stringWithFormat:fmt,##__VA_ARGS__]
 #endif /* CreateLiveHeader_h */
