//
//  SpecialModel.h
//  
//
//  Created by apple-jd33 on 15/11/21.
//  Copyright © 2015年 HansRove. All rights reserved.
//

#import "FYBaseModel.h"
/**
 *  精品听单栏模型
 */
@class SpecialMoreList;
@interface SpecialModel : FYBaseModel

@property (nonatomic, assign) NSInteger pageId;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger maxPageId;

@property (nonatomic, copy) NSString *moduleTitle;

@property (nonatomic, strong) NSArray<SpecialMoreList *> *list;

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, copy) NSString *msg;

@end
@interface SpecialMoreList : FYBaseModel

@property (nonatomic, assign) NSInteger specialId;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy) NSString *coverPathSmall;

@property (nonatomic, assign) NSInteger contentType;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *footnote;

@property (nonatomic, copy) NSString *coverPathBig;

@property (nonatomic, assign) long long releasedAt;

@property (nonatomic, assign) BOOL isHot;

@end

