//
//  Livel003DjHeaderView.h
//  VideoList
//
//  Created by DengOC on 2018/9/23.
//  Copyright © 2018年 COM.Sobey. All rights reserved.
// Livel003MainStyle2Cell

#import <UIKit/UIKit.h>

typedef void(^action_block)(NSString * title);
typedef void(^action_rightblock)(NSInteger  action);
//Livel003Header
@interface Livel003DjHeaderView : UIView
@property(nonatomic,copy) action_block  action ;
@property(nonatomic,copy) action_rightblock right_action ;// 右边 buttton 点击事件

@property(nonatomic,weak) UILabel * lab_title;
@property(nonatomic,                                                                                                                                                                                                                                                                                                       )  NSInteger section;
/** 设置有 两个button */
-(void) set_stylebutton;
//设置半月圆角
-(void) set_styleRound;
@end
