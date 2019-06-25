//
//  UCTableViewModel.m
//  ShoppingGuide
//
//  Created by dengjie on 2017/2/20.
//  Copyright © 2017年 com.business.facedaogou. All rights reserved.
//

#import "FCTableViewModel.h"

@implementation FCTableViewModel
@synthesize refreshUI = _refreshUI;
@synthesize refreshEndSubject = _refreshEndSubject;
@synthesize refreshDataCommand = _refreshDataCommand;
@synthesize nextPageCommand = _nextPageCommand;
@synthesize dataArray = _dataArray;
@synthesize pageIndex = _pageIndex;
@synthesize pageSize = _pageSize;
@synthesize total = _total;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    FCTableViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel uc_initialize];
        [viewModel uc_bindViewModel];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(RACSignal *)uc_getData{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@[]];
        return nil;
    }];
}
- (void)uc_initialize {}

- (void)uc_bindViewModel {
    
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *resultData) {
        
        @strongify(self);
        
        self.dataArray = resultData;
        
        if (self.dataArray.count <= self.pageSize && self.total <= self.pageSize) {
            [self.refreshEndSubject sendNext:@(LSFooterRefresh_HasNoMoreData)];
        }
        else {
            [self.refreshEndSubject sendNext:@(LSFooterRefresh_HasMoreData)];
        }
    }];
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            //正在加载
        }
    }];
    
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *resultData) {
        
        @strongify(self);
        
        NSMutableArray *allArray = [[NSMutableArray alloc] initWithArray:self.dataArray];
        for (int i = 0; i<[resultData count]; i++) {
            [allArray addObject:[resultData objectAtIndex:i]];
        }
        self.dataArray = allArray;
        
        if (self.dataArray.count == self.total) {
            [self.refreshEndSubject sendNext:@(LSFooterRefresh_HasNoMoreData)];
        }
        else {
            [self.refreshEndSubject sendNext:@(LSFooterRefresh_HasMoreData)];
        }
    }];
}

- (RACSubject *)refreshUI {
    if (!_refreshUI) {
        
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}

- (RACSubject *)refreshEndSubject {
    if (!_refreshEndSubject) {
        
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            
            self.pageIndex = 1;
            return [self uc_getData];
        }];
    }
    
    return _refreshDataCommand;
}

- (RACCommand *)nextPageCommand {
    
    if (!_nextPageCommand) {
        
        @weakify(self);
        _nextPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            
            self.pageIndex ++;
            return [self uc_getData];
        }];
    }
    
    return _nextPageCommand;
}

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
