//
//  UCTableViewProtocol.h
//  ShoppingGuide
//
//  Created by dengjie on 2017/2/20.
//  Copyright © 2017年 com.business.facedaogou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FCTableViewModelProtocol;

@protocol FCTableViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <FCTableViewModelProtocol>)viewModel;

@property (nonatomic,strong) UITableView *ucTableView;

- (void)uc_setupViews;

@end
