//
//  UCTableViewModelProtocol.h
//  ShoppingGuide
//
//  Created by dengjie on 2017/2/20.
//  Copyright © 2017年 com.business.facedaogou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCRACNetworkTool.h"

typedef enum : NSUInteger {
    LSHeaderRefresh_HasMoreData = 1,
    LSHeaderRefresh_HasNoMoreData,
    LSFooterRefresh_HasMoreData,
    LSFooterRefresh_HasNoMoreData,
    LSRefreshError,
    LSRefreshUI,
} LSRefreshDataStatus;

@protocol FCTableViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;

@property (nonatomic, strong) RACCommand *refreshDataCommand;

@property (nonatomic, strong) RACCommand *nextPageCommand;

@property (nonatomic, strong) RACSubject *refreshUI;

@property (nonatomic, strong) RACSubject *refreshEndSubject;

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSMutableArray *dataArray;

/**
 *  初始化
 */
- (void)uc_initialize;

/**
*  获取数据
*/
- (RACSignal *)uc_getData;

@end
