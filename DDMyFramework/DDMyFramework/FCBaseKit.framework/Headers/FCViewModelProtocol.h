//
//  UCViewModelProtocol.h
//  ShoppingGuide
//
//  Created by dengjie on 2017/2/16.
//  Copyright © 2017年 com.business.facedaogou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCRACNetworkTool.h"
//#import "LoginHelper.h"

typedef enum : NSUInteger {
    MJHeaderRefresh_HasMoreData = 1,
    MJHeaderRefresh_HasNoMoreData = 2,
    MJFooterRefresh_HasMoreData = 3,
    MJFooterRefresh_HasNoMoreData = 4,
    MJRefreshError = 5,
    MJRefreshUI = 6,
} MJRefreshDataStatus;

@protocol FCViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;

/**
 *  初始化
 */
- (void)uc_initialize;

@end
