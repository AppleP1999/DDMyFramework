//
//  FCRollingView.m
//  DDMyFramework
//
//  Created by omni－appple on 2019/6/20.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//
#define kWINDOW  [[UIApplication sharedApplication].windows lastObject]
#define ScreenWidth UIScreen.mainScreen.bounds.size.width
#define Screenheight UIScreen.mainScreen.bounds.size.height
#import "FCRollingView.h"
#import <MJRefresh/MJRefresh.h>
#import "FCCycleView.h"
@interface FCRollingView ()
@property(weak, nonatomic) UIView *bgView;
@property(nonatomic, assign) CGSize firstSize;
@property(nonatomic, assign) BOOL isEx;
@property (nonatomic, strong) FCCycleView * tb_cycleView;

@property(nonatomic,weak) UIButton *btn_stop;
@property(nonatomic,weak) UIButton *btn_next;
@property(nonatomic,weak) UIButton *btn_last;
@property(nonatomic,weak) UIButton *btn_exit;
 

@end

@implementation FCRollingView

+ (FCRollingView* ) rollingWithButtomView:(UIView*)buttomView size:(CGSize)size
{
    FCRollingView *  btn  = [[FCRollingView alloc] initWithFrame:CGRectMake(10, 74, size.width, size.height)];
    btn.firstSize = size;
    btn.bgView = buttomView;
    
    return btn;
}

- (void)drawProgress:(CGFloat )progress
{
	 [self.tb_cycleView drawProgress:progress];
}

- (void)takeBack
{
    
    if (!_isEx) {
        return;
    }
    
    _isEx = NO;
    CGRect r = self.frame;
//    r.size.width = self.firstSize.width;
    r.size = self.firstSize;
	self.tb_cycleView.mj_origin = CGPointMake(0, 0);
	self.img_bgView.mj_origin = CGPointMake(3,3);
	

    if (self.frame.origin.x > ScreenWidth/2 - self.mj_w/2) {
        r.origin.x = ScreenWidth - self.firstSize.width - 15 ;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
	[self set_all_button_status:YES];
        self.frame = r;
        
    } completion:^(BOOL finished) {
        
        self.layer.shadowColor = [UIColor clearColor].CGColor;
    }];
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = UIColor.whiteColor;
        UITapGestureRecognizer *img_bgTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBut:)];
        
        [self addGestureRecognizer:img_bgTapGestureRecognizer];
        
        [self addSubview:self.tb_cycleView];
        [self addSubview:self.img_bgView];
        //点击移动
        //    [[UIPanGestureRecognizer alloc]initWithTarget:@selector(handlePan:) ];
        UIPanGestureRecognizer *panTouch = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:) ];
        [self addGestureRecognizer:panTouch];
        // 长按隐藏
        UILongPressGestureRecognizer *longPressGR =
        [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        longPressGR.minimumPressDuration = 1.5;
        [self addGestureRecognizer:longPressGR];
        
        
 
      
		UIButton * btn_last = [[UIButton  alloc] init];
        [btn_last setImage:[UIImage imageNamed:@"上一首 上一个"] forState:0];
        CGFloat  w = 14;
        CGFloat  margin = 16;
        CGFloat  y = (self.mj_w - w)/2;
        btn_last.frame = CGRectMake(self.img_bgView.mj_w + self.img_bgView.mj_x + 13,  y, w, w);
        btn_last.hidden = YES;
        [btn_last addTarget:self action:@selector(click_next) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btn_last];
		self.btn_last = btn_last;
		
		UIButton * btn_stop = [[UIButton  alloc] init];
        btn_stop.frame = CGRectMake(btn_last.mj_w  + btn_last.mj_x + margin, y, w, w);
        btn_stop.hidden = YES;
 		[btn_stop setImage:[UIImage imageNamed:@"暂停"] forState:0];
        [self addSubview:btn_stop];
        self.btn_stop = btn_stop;
        
		UIButton * btn_next = [[UIButton  alloc] init];
        btn_next.frame = CGRectMake(btn_stop.mj_w  + btn_stop.mj_x + margin, y, w, w);
        [btn_next setImage:[UIImage imageNamed:@"上一首 上一个 拷贝"] forState:0];
        btn_next.hidden = YES;
		[self addSubview:btn_next];
        self.btn_next = btn_next;
        
		UIButton * btn_exit = [[UIButton  alloc] init];
		[btn_exit setImage:[UIImage imageNamed:@"关  闭 拷贝"] forState:0];
        btn_exit.frame = CGRectMake(btn_next.mj_w + btn_next.mj_x + margin,  y, w, w);
        btn_exit.hidden = YES;
		[self addSubview:btn_exit];
		self.btn_exit = btn_exit;
    }
    return self;
}
#pragma mark -- lazyLoading
- (UIImageView *)img_bgView
{
    if (!_img_bgView)
    {
        _img_bgView = [[UIImageView alloc ] init] ;
        CGRect r = self.frame;
        _img_bgView.frame = CGRectMake(3,3,r.size.width -6,r.size.height-6);
        _img_bgView.layer.borderWidth = 1;
        _img_bgView.layer.cornerRadius = (r.size.height-6 )/2 ;
        _img_bgView.layer.masksToBounds = YES;
        _img_bgView.userInteractionEnabled = YES;
    }
    
    return _img_bgView;
}

- (FCCycleView*)tb_cycleView
{
	if (_tb_cycleView == nil) 
	{
		self.tb_cycleView = [[FCCycleView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h)];
	}
	
	return _tb_cycleView;
}

-  (void)handleDis:(UIPanGestureRecognizer *)recognizer
{
    CGRect r = self.frame;
    r.size.width = self.firstSize.width;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = r;
        
    }];
    
}

 
- (void)clickBut:(id ) but
{
  
    if (_isEx) {
    	NSLog(@" 展开后 点击事件");
        return;
    }
    self.isEx = YES;
    CGRect r = self.frame;
    CGFloat spacing = 0;
    r.size.width = 180;
    r.size.height = self.firstSize.height +spacing;
//	self.tb_cycleView.mj_origin = CGPointMake(spacing, spacing);
//	self.img_bgView.mj_origin = CGPointMake(self.img_bgView.mj_x+spacing,self.img_bgView.mj_y+spacing);
    if (self.frame.origin.x > ScreenWidth/2) {
        r.origin.x = ScreenWidth  - 20 - 180;
    }
    
    [UIView animateWithDuration:0.3 animations:^{    
//    self.tb_cycleView.mj_origin = CGPointMake(spacing, spacing);
//	self.img_bgView.mj_origin = CGPointMake(self.img_bgView.mj_x+spacing,self.img_bgView.mj_y+spacing);
        self.frame = r;
    } completion:^(BOOL finished) {
    
	[self set_all_button_status:NO];
	self.layer.shadowColor = [UIColor grayColor].CGColor;

    }];
    
}

 
- (void)click_next 
{
	NSLog(@"click_next");
}

- (void)set_all_button_status:(BOOL) status

{
	self.btn_next.hidden = status;
	self.btn_last.hidden = status;
	self.btn_exit.hidden = status;
	self.btn_stop.hidden = status; 	
}

- (void)longPress:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"开始长按");
        [UIView animateWithDuration:1.5 animations:^{
            sender.view.frame =
            //            self->moveRedPacket.frame =
            CGRectMake(0,0,0,0);
        }];
    }
    else
    {
        NSLog(@"长按手松开");
    }
}
#pragma mark--处理拖动手势
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    //视图前置操作
    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    CGPoint center = recognizer.view.center;
    CGFloat cornerRadius = recognizer.view.frame.size.width / 2;
    CGPoint translation = [recognizer translationInView:self.bgView];
    //NSLog(@"%@", NSStringFromCGPoint(translation));
    recognizer.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.bgView];
    
    if (recognizer.state ==UIGestureRecognizerStateEnded)
    {
        //计算速度向量的长度，当他小于200时，滑行会很短
        CGPoint velocity = [recognizer velocityInView:self.bgView];
        CGFloat magnitude =sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude /200;
        //NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult); //e.g. 397.973175, slideMult: 1.989866
        //基于速度和速度因素计算一个终点
        float slideFactor =0.1 * slideMult;
        
        CGPoint finalPoint =CGPointMake(center.x + (velocity.x * slideFactor),
                                        
                                        center.y + (velocity.y * slideFactor));
        
        //限制最小［cornerRadius］和最大边界值［self.view.bounds.size.width - cornerRadius］，以免拖动出屏幕界限
        
        finalPoint.x = MIN(MAX(finalPoint.x, cornerRadius),
                           
                           self.bgView.bounds.size.width - cornerRadius);
        
        
        finalPoint.y = MIN(MAX(finalPoint.y, cornerRadius),
                           
                           self.bgView.bounds.size.height - cornerRadius);
        
        if (finalPoint.y < 88 +40)
        {
            finalPoint.y = 64 + self.frame.size.height/2 +10;
        }
        //使用 UIView动画使 view滑行到终点 375 -48 = 327  158
        
        if (finalPoint.x < (ScreenWidth - self.mj_w) /2 +30)
        {
            finalPoint.x = 30;
			if (_isEx)
             {
                finalPoint.x =  self.mj_w/2;
             }
        }
        else
        {
            finalPoint.x = ScreenWidth - 30 ;
            if (_isEx)
            {
                finalPoint.x = ScreenWidth - 5 - self.mj_w/2;
            }
        }
        
        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            recognizer.view.center = finalPoint;
            
        } completion:nil];
        
    }
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.masksToBounds = YES;
    [self set_shadow];
}



- (void)set_shadow
{
    self.layer.borderWidth = 0.7f;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.masksToBounds = YES;
    self.layer.shadowColor = [UIColor clearColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2,2);
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOpacity = 0.4f;
    self.layer.masksToBounds = NO;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint redBtnPoint = [self convertPoint:point toView:_btn_stop];

    if ([_btn_stop pointInside:redBtnPoint withEvent:event])
    {
        if ([_btn_stop pointInside:redBtnPoint withEvent:event]){
            return _btn_stop;
        }
        return _btn_stop;
    }


    //如果希望严谨一点，可以将上面if语句及里面代码替换成如下代码
    //UIView *view = [_redButton hitTest: redBtnPoint withEvent: event];
    //if (view) return view;
    return [super hitTest:point withEvent:event];

}

 
@end

@implementation FCRollingBGView
{
    id _timeObserve;
}
- (void)dealloc
{
	 NSLog(@"FCRollingBGView");
}
 
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        self.frame = kWINDOW.bounds;
        [self addSubview:self.topView];
        [kWINDOW addSubview:self];
    }
    return self;
}

-(FCRollingView *)topView
{
    if (!_topView)
    {
        _topView.userInteractionEnabled = YES;
        _topView = [FCRollingView rollingWithButtomView:self size:CGSizeMake(48, 48)];
        [_topView.btn_stop addTarget:self action:@selector(clickBut_stop:) forControlEvents:UIControlEventTouchUpInside];
        [_topView.btn_exit addTarget:self action:@selector(clickBut_exit) forControlEvents:UIControlEventTouchUpInside];
        [_topView.btn_last addTarget:self action:@selector(clickBut_last:) forControlEvents:UIControlEventTouchUpInside];
        [_topView.btn_next addTarget:self action:@selector(clickBut_next:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _topView;
}
#pragma mark - play
- (void)playWithModel:(id )tracks indexPathRow:(NSInteger ) indexPathRow{
    
//    _tracksVM = tracks;
//    _rowNumber = self.tracksVM.rowNumber;
//    _indexPathRow = indexPathRow;

    //缓存播放实现，可自行查找AVAssetResourceLoader资料,或采用AudioQueue实现
    NSURL *musicURL =   [NSURL URLWithString:@""]; // [self.tracksVM playURLForRow:_indexPathRow];
    _currentPlayerItem = [AVPlayerItem playerItemWithURL:musicURL];
    _player = [[AVPlayer alloc] initWithPlayerItem:_currentPlayerItem];

//    [self addMusicTimeMake];
    
    _isPlay = YES;
    [_player play];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_currentPlayerItem];
//    [self setHistoryMusic];
    
}
-(void)addMusicTimeMake{
//    __weak FYPlayManager *weakSelf = self;
//    //监听
//    _timeObserve = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
//        FYPlayManager *innerSelf = weakSelf;
//        
//        [innerSelf updateLockedScreenMusic];//控制中心
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"musicTimeInterval" object:nil userInfo:nil];//时间变化
//        
//    }];
}
#pragma mark - 锁屏时候的设置，效果需要在真机上才可以看到
- (void)updateLockedScreenMusic{
    
    // 播放信息中心
//    MPNowPlayingInfoCenter *center = [MPNowPlayingInfoCenter defaultCenter];
//    
//    // 初始化播放信息
//    NSMutableDictionary *info = [NSMutableDictionary dictionary];
//    // 专辑名称
//    info[MPMediaItemPropertyAlbumTitle] = [self playMusicName];
//    // 歌手
//    info[MPMediaItemPropertyArtist] = [self playSinger];
//    // 歌曲名称
//    info[MPMediaItemPropertyTitle] = [self playMusicTitle];
    // 设置图片
//    info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:[self playCoverImage]];
//    // 设置持续时间（歌曲的总时间）
//    [info setObject:[NSNumber numberWithFloat:CMTimeGetSeconds([self.player.currentItem duration])] forKey:MPMediaItemPropertyPlaybackDuration];
//    // 设置当前播放进度
//    [info setObject:[NSNumber numberWithFloat:CMTimeGetSeconds([self.player.currentItem currentTime])] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    
    // 切换播放信息
//    center.nowPlayingInfo = info;
}

#pragma mark -- button 点击事件

- (void)clickBut_exit
{
	if ([self.delegate respondsToSelector:@selector(click_exit)]) {
		[self.delegate click_exit];
	}
	
	[self removeFromSuperview];	
}

- (void)clickBut_stop:(UIButton *) btn 
{
	
	if ([self.delegate respondsToSelector:@selector(click_stop_play:)]) {
		[self.delegate click_stop_play:btn];
	}
	
}

- (void)clickBut_last:(UIButton *) btn 
{
	if ([self.delegate respondsToSelector:@selector(click_exit)]) {
		[self.delegate click_exit];
	}
}

- (void)clickBut_next:(UIButton *) btn
 {
	if ([self.delegate respondsToSelector:@selector(click_next)]) {
		[self.delegate click_next];
	}
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint redBtnPoint = [self convertPoint:point toView:_topView];
//    CGPoint btn_stopPoint = [self convertPoint:point toView:_topView.btn_stop];
//    CGPoint btn_nextPoint = [self convertPoint:point toView:_topView.btn_next];
//    CGPoint btn_exitPoint = [self convertPoint:point toView:_topView.btn_exit];
//    CGPoint btn_lastPoint = [self convertPoint:point toView:_topView.btn_last];
//    // 暂停事件返回
//    if ([_topView.btn_stop pointInside:btn_stopPoint withEvent:event])
//    {
//        UIView *view = [_topView.btn_stop hitTest: btn_stopPoint withEvent: event];
//        if (view) return view;
//        // return _topView.btn_stop;
//    }
//    else if ([_topView.btn_next pointInside:btn_stopPoint withEvent:event])
//    {
//        UIView *view = [_topView.btn_next hitTest: btn_stopPoint withEvent: event];
//        if (view) return view;
//        // return _topView.btn_stop;
//    }
    
    if ([_topView pointInside:redBtnPoint withEvent:event])
    {
        UIView *view = [_topView hitTest: redBtnPoint withEvent: event];
        if (view) return view;
        //   return _topView;
    }
    
    else{
        
        [self.topView takeBack];
    }
    //如果希望严谨一点，可以将上面if语句及里面代码替换成如下代码
    //    UIView *view = [_topView hitTest: redBtnPoint withEvent: event];
    //    if (view) return view;
    return nil;
    
    
}
@end
