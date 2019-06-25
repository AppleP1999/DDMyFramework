//
//  UIViewController+FCEmtyView.h
//  LiveI003
//
//  Created by ZhouYou on 2018/9/18.
//  Copyright © 2018年 ZhouYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FCEmtyView)

@property (nonatomic, strong, readonly) UIView *emptyView;

- (void)showEmptyView;

- (void)hiddenEmptyView;

- (void)reloadViewData;

@end
