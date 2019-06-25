//
//  DDRollingBoutton.h
//  EasyShop
//
//  Created by DengOC on 2018/7/3.
//  Copyright © 2018年 u1city01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDRollingBoutton : UIButton

@property(weak,nonatomic) UIView * view;
+(DDRollingBoutton* ) bouttonRollingWithButtomView:(UIView*)buttomView;

@end

