//
//  DestinationModel.h
//  
//
//  Created by apple-jd33 on 15/11/23.
//  Copyright © 2015年 HansRove. All rights reserved.
//

#import "FYBaseModel.h"
/**
 *  最终目的地,选集列表
 */
@class DAlbum,DTracks,DTracks_List;
@interface DestinationModel : FYBaseModel

@property (nonatomic, strong) DTracks *tracks;

@property (nonatomic, strong) DAlbum *album;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger ret;

@end

@interface DAlbum : FYBaseModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *title;
/** 返回专辑标签数组 */
@property (nonatomic, copy) NSString *tags;
/** 返回专辑图片链接地址 */
@property (nonatomic, copy) NSString *coverMiddle;
/** 返回专辑昵称 */
@property (nonatomic, copy) NSString *nickname;
 /**  返回专辑说明  */
@property (nonatomic, copy) NSString *intro;
/** 返回专辑头像地址 */
@property (nonatomic, copy) NSString *coverLarge;
/** 返回专辑头像地址 */
@property (nonatomic, copy) NSString *avatarPath;

@property (nonatomic, assign) NSInteger serialState;

@property (nonatomic, copy) NSString *categoryName;

@property (nonatomic, copy) NSString *coverWebLarge;
 

@property (nonatomic, assign) NSInteger shares;
 

@property (nonatomic, assign) BOOL hasNew;

@property (nonatomic, assign) long long createdAt;

@property (nonatomic, assign) BOOL isVerified;
 

@property (nonatomic, assign) NSInteger albumId;

@property (nonatomic, assign) long long updatedAt;

@property (nonatomic, copy) NSString *coverSmall;
 

@property (nonatomic, copy) NSString *coverOrigin;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, copy) NSString *introRich;

@property (nonatomic, assign) NSInteger zoneId;

@property (nonatomic, assign) NSInteger tracks;

@property (nonatomic, assign) BOOL isFavorite;

@property (nonatomic, assign) NSInteger serializeStatus;

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, assign) NSInteger playTimes;

@end

@interface DTracks : FYBaseModel

@property (nonatomic, assign) NSInteger maxPageId;

@property (nonatomic, strong) NSArray<DTracks_List *> *list;

@property (nonatomic, assign) NSInteger pageId;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger totalCount;

@end

@interface DTracks_List : FYBaseModel

@property (nonatomic, assign) NSInteger status;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 播放时长 */
@property (nonatomic, assign) CGFloat duration;
/** 通过行数, 返回创作人(来源) */
@property (nonatomic, copy) NSString *nickname;
/**  播放地址 */
@property (nonatomic, copy) NSString *playUrl64;
@property (nonatomic, assign) NSInteger userSource;

@property (nonatomic, assign) NSInteger processState;
 

@property (nonatomic, assign) NSInteger likes;

@property (nonatomic, copy) NSString *coverMiddle;

@property (nonatomic, assign) NSInteger shares;

@property (nonatomic, copy) NSString *playPathAacv224;

@property (nonatomic, assign) long long createdAt;

@property (nonatomic, copy) NSString *smallLogo;

@property (nonatomic, copy) NSString *albumTitle;

@property (nonatomic, copy) NSString *albumImage;

@property (nonatomic, assign) NSInteger albumId;

@property (nonatomic, copy) NSString *downloadAacUrl;
 

@property (nonatomic, assign) NSInteger orderNum;

@property (nonatomic, copy) NSString *playPathAacv164;

@property (nonatomic, copy) NSString *playUrl32;

@property (nonatomic, assign) NSInteger uid;
/** 返回集数图片（小）地址 */
@property (nonatomic, copy) NSString *coverSmall;

@property (nonatomic, copy) NSString *coverLarge;
/** 通过行数, 返回播放次数 */
@property (nonatomic, assign) NSInteger playtimes;

@property (nonatomic, assign) NSInteger downloadSize;

@property (nonatomic, assign) NSInteger downloadAacSize;

@property (nonatomic, copy) NSString *downloadUrl;

@property (nonatomic, assign) NSInteger comments;
/**  返回播放ID */
@property (nonatomic, assign) NSInteger trackId;

@property (nonatomic, assign) NSInteger opType;

@property (nonatomic, assign) BOOL isPublic;

@end

