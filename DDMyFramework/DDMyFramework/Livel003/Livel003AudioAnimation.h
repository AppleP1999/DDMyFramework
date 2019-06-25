//
//  Livel003AudioAnimation.h
//  DDMyFramework
//
//  Created by omni－appple on 2019/5/6.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block_play)(UIButton * btn);
@interface Livel003AudioAnimation : UIView

//@property (strong, nonatomic)  UIButton *playBtn;
@property(nonatomic,copy)block_play  clickCall;
- (void)stop;
- (void)start;
@end
