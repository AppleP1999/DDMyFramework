//
//  UIButton+DDExtensiontEvent.h
//  testDemo001
//
//  Created by DengOC on 2018/6/1.
//  Copyright © 2018年 DDAppleDengjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DDExtensionEventCallBlcok)(UIButton* sender);
@interface UIButton (DDExtensiontEvent)
-(void)add_ddcallBlcokAction:(DDExtensionEventCallBlcok)block forControlEvents:(UIControlEvents)controlEvents;
-(void)add_ddcallBlcokAction:(DDExtensionEventCallBlcok)block;
 +(instancetype)buttonFrame:(CGRect)frame callBlcok:(DDExtensionEventCallBlcok)callBlcok;
@end
