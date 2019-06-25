//
//  bottomListModel.h
//  Video01
//
//  Created by Higgses on 2018/2/7.
//  Copyright © 2018年 Higgses. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BottomListData;

@interface bottomListModel : NSObject
@property (nonatomic, assign)BOOL ret;
@property (nonatomic, strong) NSMutableArray <BottomListData *> *data;

@end

@interface BottomListData : NSObject
@property (nonatomic, assign) NSInteger cateid;
@property (nonatomic, assign) NSInteger parent_id;
@property (nonatomic, assign) NSInteger station_id;
@property (nonatomic, assign) NSInteger channel_id;
@property (nonatomic, copy) NSString *name;
;
@end
