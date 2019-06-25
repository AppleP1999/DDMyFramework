//
//  Livel003AudioAnimation.m
//  DDMyFramework
//
//  Created by omni－appple on 2019/5/6.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import "Livel003AudioAnimation.h"
#import <Masonry/Masonry.h>
//#import "UIImage+FCExtension.h"
@interface Livel003AudioAnimation ()
@property (nonatomic, strong)  UIImageView * bgImgView;
@property (nonatomic, strong)  UIImageView * centerImgView ;
@property(nonatomic,assign)CGFloat angle;
@property (strong, nonatomic)  UIButton *playBtn;

@property(nonatomic,assign)BOOL is_play;
@end
@implementation Livel003AudioAnimation
- (instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
	self.bgImgView = [[UIImageView alloc] init];
	self.bgImgView.image = [UIImage imageNamed:@"播放背景"];
	[self addSubview:self.bgImgView];
		
	self.centerImgView =[[UIImageView alloc] init];
	self.centerImgView.image = [UIImage imageNamed:@"首帧图"];
	[_bgImgView addSubview:self.centerImgView];
	
	 self.playBtn = [[UIButton alloc] init];
   	self.playBtn.layer.cornerRadius = 20;
 	 self.playBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
	 [self.playBtn setImage:[UIImage imageNamed:@"播放1"] forState:0];
	 [self.playBtn addTarget:self action:@selector(clickbtnCall:) forControlEvents:UIControlEventTouchUpInside];	
	[self addSubview:self.playBtn];

	[self updateConstraintsIfNeeded];
	[self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)clickbtnCall:(UIButton *) btn{
	if (self.clickCall) {
    	self.clickCall(btn);
	}
	
	btn.hidden = YES;
	[self start];
}
-(void)updateConstraints{


	[self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self);
	}];
	
	[self.centerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		 make.centerX.centerY.equalTo(self.bgImgView);
		 make.size.equalTo(self.bgImgView).multipliedBy(0.60) ;
	}];
	
	 [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		 make.centerX.centerY.equalTo(self.bgImgView);
		 make.size.mas_equalTo(CGSizeMake(40, 40));
	}];
	[super updateConstraints];
}
//方法1
-(void) startAnimation
{
	if (_is_play) {
    	return;
	}
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    self.bgImgView.transform = CGAffineTransformMakeRotation(_angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}
- (void)start
{
	_is_play = NO;
	[self startAnimation];
}
- (void)stop
{
	_is_play = YES;;
	if (_is_play) {
		[self startAnimation];
	}
}
-(void)endAnimation
{
    _angle += 2;
    [self startAnimation];
}
 
@end
