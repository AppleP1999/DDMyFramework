//
//  UCTableView.m
//  ShoppingGuide
//
//  Created by dengjie on 2017/2/20.
//  Copyright © 2017年 com.business.facedaogou. All rights reserved.
//

#import "FCTableView.h"
#import "AppDelegate.h"
#import "FCTableViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "FCBaseDefine.h"
@interface FCTableView ()

@property (nonatomic,strong) FCTableViewModel *viewModel;

@end

@implementation FCTableView
@synthesize ucTableView = _ucTableView;

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self uc_setupViews];
        [self uc_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<FCTableViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        
        self.viewModel = (FCTableViewModel *)viewModel;
        
        [self uc_setupViews];
        [self uc_bindViewModel];
    }
    return self;
}

- (void)uc_setupViews {}

- (void)uc_bindViewModel {
    
    [self.viewModel.refreshDataCommand execute:nil];
    
    @weakify(self);
    
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        
        @strongify(self);
        [self.ucTableView reloadData];
    }];
    
    [self.viewModel.refreshEndSubject subscribeNext:^(id x) {
        @strongify(self);
        
        [self.ucTableView reloadData];
        
        switch ([x integerValue]) {
            case LSHeaderRefresh_HasMoreData: {
                
                [self.ucTableView.mj_header endRefreshing];
                
                if (self.ucTableView.mj_footer == nil) {
                    
                    self.ucTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                        @strongify(self);
                        [self.viewModel.nextPageCommand execute:nil];
                    }];
                }
            }
                break;
            case LSHeaderRefresh_HasNoMoreData: {
                
                [self.ucTableView.mj_header endRefreshing];
                self.ucTableView.mj_footer = nil;
            }
                break;
            case LSFooterRefresh_HasMoreData: {
                
                [self.ucTableView.mj_header endRefreshing];
                [self.ucTableView.mj_footer resetNoMoreData];
                [self.ucTableView.mj_footer endRefreshing];
            }
                break;
            case LSFooterRefresh_HasNoMoreData: {
                [self.ucTableView.mj_header endRefreshing];
                [self.ucTableView.mj_footer endRefreshingWithNoMoreData];
            }
                break;
            case LSRefreshError: {
                
                [self.ucTableView.mj_footer endRefreshing];
                [self.ucTableView.mj_header endRefreshing];
            }
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark - lazyLoad
- (FCTableViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FCTableViewModel alloc] init];
    }
    return _viewModel;
}

- (UITableView *)ucTableView {
    if (!_ucTableView) {
        
        _ucTableView = [[UITableView alloc] initWithFrame:self.bounds];
        _ucTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _ucTableView.backgroundColor = KHEXCOLOR(@"efefef");
        KWeakSelf;
        _ucTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakSelf.viewModel.refreshDataCommand execute:nil];
        }];
        _ucTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf.viewModel.nextPageCommand execute:nil];
        }];
    }
    return _ucTableView;
}

@end
