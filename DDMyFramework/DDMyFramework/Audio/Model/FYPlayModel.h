//
//  FYPlayModel.h
//  DDMyFramework
//
//  Created by DengOC on 2019/6/25.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class FYPlayModelList;
@interface FYPlayModel : NSObject

@property(nonatomic,copy) NSArray <FYPlayModelList *>* list;

@end

@interface FYPlayModelList : NSObject

@property(nonatomic,copy) NSString *name;

@property (nonatomic, assign) NSInteger status;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 播放时长 */
@property (nonatomic, assign) CGFloat duration;
/** 通过行数, 返回创作人(来源) */
@property (nonatomic, copy) NSString *nickname;
/**  播放地址 */
@property (nonatomic, copy) NSString *playUrl64;
/** 返回集数图片（小）地址 */
@property (nonatomic, copy) NSString *coverSmall;

@property (nonatomic, copy) NSString *coverLarge;
/** 通过行数, 返回播放次数 */
@property (nonatomic, assign) NSInteger playtimes;
/** 通过行数, 返回创建时间 */
@property (nonatomic, assign) long long createdAt;
@end


NS_ASSUME_NONNULL_END
