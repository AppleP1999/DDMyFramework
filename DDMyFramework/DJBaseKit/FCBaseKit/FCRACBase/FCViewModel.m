//
//  UCViewModel.m
//  ShoppingGuide
//
//  Created by dengjie on 2017/2/16.
//  Copyright © 2017年 com.business.facedaogou. All rights reserved.
//

#import "FCViewModel.h"

@implementation FCViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    FCViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel uc_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)uc_initialize {}

@end
