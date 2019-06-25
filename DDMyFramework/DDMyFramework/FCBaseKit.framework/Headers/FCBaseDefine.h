//
//  FCBaseDefine.h
//  FCBaseKit
//
//  Created by ZhouYou on 2018/11/22.
//  Copyright © 2018 ZhouYou. All rights reserved.
//

#ifndef FCBaseDefine_h
#define FCBaseDefine_h

//根据RGB值获取颜色
#define FCColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//根据RGB值和alpha值获取颜色
#define FCCOLOR_RGB_ALPHA(rgbValue,i) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:(i)]



#define FCRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]



//debug日志信息
#define FCLog(msg, ...)\
{\
NSLog(@"[ %@:(%d)] %@<-- %@ -->",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,[NSString stringWithUTF8String:__FUNCTION__], [NSString stringWithFormat:(msg), ##__VA_ARGS__]);\
}

#define KWeakSelf __weak __typeof(self)weakSelf = self
//#define WS(weakSelf)        __weak __typeof(&*self)weakSelf = self;

//weak self
#define FCWS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define FCSRECT     [UIScreen mainScreen].bounds
#define FCSWIDTH     [UIScreen mainScreen].bounds.size.width
#define FCSHEIGHT   [UIScreen mainScreen].bounds.size.height

//设计切图计算比例
#define SCALAE FCSWIDTH/375.0/2.0

#define FCFORMAT(fmt,...)[NSString stringWithFormat:fmt,##__VA_ARGS__]

#define FCBundle(bundle)    [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:(bundle) ofType:@"bundle"]]

//-------------------单例化一个类-------------------------//
/*.h类 实现*/
#define DEFINE_SINGLETON_INTERFACE(className) \
+ (className *)shared##className;

/*.m类 实现*/
#define DEFINE_SINGLETON_IMPLEMENTATION(className) \
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

#define  kGETIMG(a) [UIImage imageNamed:a]

#endif /* FCBaseDefine_h */
