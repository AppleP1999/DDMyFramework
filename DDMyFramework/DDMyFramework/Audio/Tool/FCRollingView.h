//
//  FCRollingView.h
//  DDMyFramework
//
//  Created by omni－appple on 2019/6/20.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@protocol FCRollingBGViewDelegate <NSObject>
 

@optional

- (void)click_last;
- (void)click_stop_play:(UIButton *)but;
- (void)click_next;
- (void)click_exit;

@end

@interface FCRollingView : UIView
+(FCRollingView* ) rollingWithButtomView:(UIView*)buttomView  size:(CGSize)size;
 
- (void)drawProgress:(CGFloat )progress;
- (void)takeBack;

@property (nonatomic, strong) UIImageView *img_bgView ;
@end



@interface FCRollingBGView : UIView
@property (nonatomic, weak) id<FCRollingBGViewDelegate> delegate;
@property (nonatomic, strong) AVPlayerItem   *currentPlayerItem;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic) BOOL isPlay;
@property (nonatomic,strong) FCRollingView  * topView;
@property (nonatomic, strong) UIButton *btn_bg ;

@end
