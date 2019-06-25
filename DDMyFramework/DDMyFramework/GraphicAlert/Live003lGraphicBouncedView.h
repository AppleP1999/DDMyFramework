//
//  LIve003lGraphicBouncedView.h
//  DDMyFramework
//
//  Created by omni－appple on 2019/4/2.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickOnCloseBlcok)(void);
@interface Live003lGraphicBouncedView : UIView
@property(nonatomic,copy) clickOnCloseBlcok  clickBlock_call;
+ (void)showVC:(UIViewController *)vc;
@end
