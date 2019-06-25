//
//  FCTableViewCellProtocol.h
//  ShoppingGuide
//
//  Created by dengjie on 2017/2/22.
//  Copyright © 2017年 com.business.facedaogou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FCTableViewCellProtocol <NSObject>
@optional

- (void)uc_setupViews;
- (void)uc_bindViewModel;

@end
