//
//  Livel003TypeHintingView.m
//  LiveI003
//
//  Created by omni－appple on 2019/5/14.
//  Copyright © 2019年 ZhouYou. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "Livel003TypeHintingView.h"
 

@interface Livel003TypeHintingView ()
@property (nonatomic, weak)  UIImageView * imgType;
//@property (nonatomic, weak)  UILabel * lab_typeName;
@end
@implementation Livel003TypeHintingView

 
 - (instancetype)init
{
    self = [super init];
    if (self) {
        [self init_ui];
 
    }
    return self;
}
 
- (void)setType:(Livel003HintingImgType)type{
	
	switch (type) {
		case   Livel003HintingTypeLive:
			[self setImgTypeName:@"zhibo (1)" labTypeName:@"直播"];
//				self.imgType.hidden  = YES;
			break;
		case   Livel003HintingTypeVideo:
			[self setImgTypeName:@"bofang" labTypeName:@"视频"];
			break;
//		case   Livel003HintingTypeProject:
//			[self setImgTypeName:@"Livel003.bundle/gengduo" labTypeName:@"专题"];
//			break;
//		case   Livel003HintingTypeAtlas:
//			[self setImgTypeName:@"Livel003.bundle/tupian" labTypeName:@"图集"];
//			break;
			
		default:
			self.imgType.hidden  = YES;
			break;
	}

}
-(void) setImgTypeName:(NSString *)name labTypeName:(NSString *)labTypeName{
	self.lab_typeName.text =  labTypeName;  
    self.imgType.image = [UIImage imageNamed:name];
    
    if (name==nil) {
    	[self.lab_typeName  mas_remakeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(12);
	 	make.centerY.mas_equalTo(self);
	 	make.centerX.mas_equalTo(self);
		}];
	}
}
 - (void)init_ui {
     
    UIImageView  * view_type = [[UIImageView alloc ] init];
    view_type.image = [UIImage imageNamed:@"矩形"];
 
	[self addSubview:view_type];
	[view_type mas_makeConstraints:^(MASConstraintMaker *make) {
	 make.edges.equalTo(self);
	}];
 	UIImageView * imgType = UIImageView.alloc.init;
 	[view_type addSubview:imgType];
 	
	[imgType mas_makeConstraints:^(MASConstraintMaker *make) {
	 make.size.mas_equalTo([UIImage imageNamed:@"bofang"].size);
	 make.centerY.mas_equalTo(self);
	 make.left.mas_equalTo(6);
	}];	
 	self.imgType = imgType;
 	
	UILabel * lab_typeName  =  [[UILabel alloc] init];
	lab_typeName.font = [UIFont systemFontOfSize:10];
	lab_typeName.textColor = UIColor.whiteColor;
	[view_type addSubview:lab_typeName];
	
	[lab_typeName mas_makeConstraints:^(MASConstraintMaker *make) {
	 make.height.mas_equalTo(12);
	 make.centerY.mas_equalTo(imgType);
	 make.left.mas_equalTo(imgType.mas_right).offset(2);
	}];	
	self.lab_typeName = lab_typeName;
	
   
}
@end
