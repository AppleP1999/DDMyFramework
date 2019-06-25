//
//  Livel003VideoCollectionCell.m
//  DDMyFramework
//
//  Created by omni－appple on 2019/5/13.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import "Livel003VideoCollectionCell.h"
#import <Masonry/Masonry.h>
#import "Livel003TypeHintingView.h"
@interface Livel003VideoCollectionCell ()
/**
 标题图片
 */
@property (nonatomic,weak)UIImageView  *iconView;
@property(nonatomic,weak)Livel003TypeHintingView *view_type;
@end
@implementation Livel003VideoCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
        [self   testData];
    }
    return self;
}
- (void)testData{
	self.lab_date.text = @"1小时前";
	self.lab_content.text = @"高新夜话.大咖成立数字化城市科技公司";
	self.view_type.lab_typeName.text = @"23:00";
}
- (void)loadUI {
	 UIImageView * iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = UIColor.redColor;
//    iconView.image  = [UIImage imageNamed:@"拍摄相机选择"];
    [self addSubview:iconView];
    self.iconView = iconView;
    
	Livel003TypeHintingView * view_type = [[Livel003TypeHintingView alloc] init];
	view_type.type = Livel003HintingTypeVideo;
    [self addSubview:view_type];    
    
	self.view_type = view_type;
    
    UILabel * lab_content =  [self lab_publicWithFontSize:14];
//    lab_content.textColor = TMColorFromRGB(0x000000);
    lab_content.numberOfLines = 2;
    [self addSubview:lab_content];
    self.lab_content = lab_content;
    
    UILabel  * lab_date =  [self lab_publicWithFontSize:12];
    //#CEC3C3 
    [self addSubview:lab_date];
    self.lab_date = lab_date;	
}
-(UILabel * ) lab_public {
    UILabel * lab = [[UILabel alloc] init];
    //#101010 
//    lab.textColor = TMColorFromRGB(0x9B9B9B);
    return lab;
}
-(UILabel *)lab_publicWithFontSize:(CGFloat)szie{
    UILabel * lab =  [self  lab_public];
    lab.font   = [UIFont systemFontOfSize:szie];
     return lab ;
}
-(void)layoutSubviews{
	 [super layoutSubviews];
	 [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self);
		make.left.equalTo(@0);
		make.right.equalTo(@-0);
		make.height.equalTo(@105);
	 }];
	  [self.lab_content mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.equalTo(self.iconView);
 
		make.top.equalTo(self.iconView.mas_bottom).offset(9);	
	 }];
	  [self.lab_date mas_makeConstraints:^(MASConstraintMaker *make) {
	   	make.left.right.equalTo(self.iconView);
		make.bottom.equalTo(@-5);
		make.height.equalTo(@12);
	 }];
	 
	[self.view_type mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([UIImage imageNamed:@"矩形"].size);
        make.right.equalTo(self.iconView.mas_right).offset(-12);
		make.bottom.equalTo(self.iconView.mas_bottom).offset(-12);
    }];
}
@end
