//
//  FCViewControllerProtocol.h
//  ShoppingGuide
//
//  Created by dengjie on 2017/2/16.
//  Copyright © 2017年 com.business.facedaogou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FCViewModelProtocol;

@protocol FCViewControllerProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <FCViewModelProtocol>)viewModel;

- (void)uc_bindViewModel;
- (void)uc_addSubviews;
- (void)uc_layoutNavigation;
- (void)uc_getNewData;

@end
