//
//  ParadigmRecomItem.h
//  ParadigmSDK
//
//  Created by Jiang Shiju on 2018/9/12.
//  Copyright © 2018年 Xi Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParadigmRecomItem : NSObject

@property (nonatomic, copy) NSString *itemId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *categoryId;

@property (nonatomic, copy) NSString *publisherId;

@property (nonatomic, assign) NSTimeInterval publishTime;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *coverUrl;

@property (nonatomic, copy) NSString *context;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
