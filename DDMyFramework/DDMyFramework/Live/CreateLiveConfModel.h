//
//  CreateLiveConfModel.h
//  DDMyFramework
//
//  Created by omni－appple on 2019/2/22.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//


 
#import <Foundation/Foundation.h>
#import "CreateLiveHeader.h"
@class UIColor;
@interface CreateLiveConfModel : NSObject
//是否夜间模式
@property (nonatomic, assign)BOOL isNight;

@property(nonatomic, assign )int  member_id;

@property(nonatomic,copy)NSString * siteCode;

@property(nonatomic,copy)NSString * domain;
/*主题颜色，默认wihteColor
一般会在导航组件加载配置后根据配置设定。（可能为空，导航组件加载后才有）
 */
@property (nonatomic, strong) UIColor *themeColor;

+ (instancetype)sharedManager  ;
//DD_DEFINE_SINGLETON_INTERFACE(CreateLiveConfModel);
//+ (instancetype)sharedManager;
@end
