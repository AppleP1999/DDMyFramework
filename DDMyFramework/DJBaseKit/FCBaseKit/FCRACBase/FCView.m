//
//  FCView.m
//  ShoppingGuide
//
//  Created by dengjie on 2017/2/16.
//  Copyright © 2017年 com.business.facedaogou. All rights reserved.
//
#import <ReactiveObjC/ReactiveObjC.h>
#import "FCView.h"
//#import "AppDelegate.h"

@implementation FCView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self uc_setupViews];
        [self uc_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<FCViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        
        [self uc_setupViews];
        [self uc_bindViewModel];
    }
    return self;
}

- (void)uc_setupViews {}

- (void)uc_bindViewModel {}

//- (void)uc_addReturnKeyBoard {
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
//    tap.numberOfTapsRequired = 1;
//    tap.numberOfTouchesRequired = 1;
//    [tap.rac_gestureSignal subscribeNext:^(id x) {
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        [appDelegate.window endEditing:YES];
//    }];
//    [self addGestureRecognizer:tap];
//}

@end
