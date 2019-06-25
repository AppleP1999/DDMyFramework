//
//  Livel003PicFocusView.m
//  DDMyFramework
//
//  Created by omni－appple on 2019/3/18.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "Livel003PicFocusView.h"
#define kItemW 40

@interface Livel003PicFocusView ()
@property(nonatomic,weak)UIImageView * img_pic;
@end
@implementation Livel003PicFocusView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self  loadUI];
    }
    return self;
}
- (void)loadUI{
	 self.backgroundColor = UIColor.clearColor;
	UIView * bgView = [[UIView alloc] init];
	bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
	bgView.layer.masksToBounds = YES;
	bgView.layer.cornerRadius = self.frame.size.height/2;
	
	UIImageView * img_pic = [[UIImageView alloc] init];
	img_pic.layer.cornerRadius = self.frame.size.height/2;;
	img_pic.layer.masksToBounds = YES;
	img_pic.backgroundColor = UIColor.redColor;
	UIButton * btn = [[UIButton alloc] init];
		btn.layer.masksToBounds = YES;
	btn.layer.cornerRadius = ( self.frame.size.height -15)/2;
//	[btn setBackgroundColor:UIColor.redColor ];
	[btn setTitle:@"关注" forState:0];
	btn.titleLabel.font = [UIFont systemFontOfSize:12];
	[btn setBackgroundColor:[UIColor colorWithRed: 239/255.0 green: 66/255.0 blue: 128/255.0 alpha: 1]  ];
	
//	[btn setTitle:@"关注" forState:0];
	[bgView addSubview:img_pic];
	self.img_pic = img_pic;
	[bgView addSubview:btn];
	[self addSubview:bgView];
	
 
		
	 [img_pic mas_makeConstraints:^(MASConstraintMaker *make) {
			  make.width.mas_equalTo(self.mas_height);
			  make.left.top.bottom.equalTo(bgView);
	  }];
	[btn mas_makeConstraints:^(MASConstraintMaker *make) {
			  make.width.mas_equalTo(40);
			  make.height.mas_equalTo(self.frame.size.height -15);
			  
			  make.centerY.equalTo(bgView);
			  make.right.equalTo(@-10);
	  }];
	 [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
			  make.height.equalTo(self);
			  make.left.equalTo(self);
			  make.right.equalTo(self);
			  make.centerY.equalTo(self);
			 	
	  }];
}
@end
