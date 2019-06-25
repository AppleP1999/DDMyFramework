//
//  NewsI004GYLMainView.m
//  NewsI004
//
//  Created by omni－appple on 2019/5/21.
//  Copyright © 2019年 ZhouYou. All rights reserved.
//

#import "NewsI004GYLMainView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <TMSDK/TMSDK.h>
#import <Masonry/Masonry.h>
 

@interface NewsI004GYLMainView()
@property(nonatomic,assign)NewsI004GYLMainStyle style;

/**
	所属分类名字
 */
@property (nonatomic,weak)UILabel *lab_categoryName;
/**
 标题图片
 */
@property (nonatomic,weak)UIImageView  *iconView;
/**
 主要内容
 */
@property (nonatomic,weak)UILabel *lab_content;

/**f
 日期
 */
@property (nonatomic,weak)UILabel *lab_date;
/**
 栏目名称
 */
@property (nonatomic,weak)UILabel *lab_Column;
@property(nonatomic,weak)UIImageView *bg_type;

/**
  标题图片1
 */
@property (nonatomic,weak)UIImageView  *iconView1;
/**
 标题图片2
 */
@property (nonatomic,weak)UIImageView  *iconView2;
@property (nonatomic,weak)UIView *view_line;
@property (nonatomic,strong) UILabel * top_laber;


@end

@implementation NewsI004GYLMainView

 + (instancetype)itemWithStyle:(NewsI004GYLMainStyle)stype 
{
	 NewsI004GYLMainView *imgView  =[[NewsI004GYLMainView  alloc]init];
	 imgView.backgroundColor = UIColor.whiteColor;
	 imgView.style = stype;
	 return imgView;
}
/*
-(void)setData:(NewsI004HomePageInformation_list *)data{


	 _data = data;
    self.lab_date.text =  data.time ?:@"" ;
    self.lab_Column.text = data.resource?:@"";
    NSString *  typeName = [self queriesTypes:data];
    BOOL iSnews_card = self.style  == NewsI004GYLMainStyleNews_card || self.style  == NewsI004GYLMainStyleNews_card_Hidden||self.style  == NewsI004GYLMainStyleThreeFigure_card;
    if (iSnews_card && self.data.top == 1) {
		NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:TMFORMAT(@"置顶   %@",data.resource?:@"")]; 
		[attrString addAttribute:NSFontAttributeName
						   value:[UIFont systemFontOfSize:14.0f]
						   range:NSMakeRange(0, 2)];
		[attrString addAttribute:NSForegroundColorAttributeName value:TMEngineConfig.instance.themeColor range:NSMakeRange(0,2)];
		
		self.lab_Column.attributedText = attrString;
		self.lab_content.text = TMFORMAT(@"%@%@",typeName,data.information_title?:@"");
		
	}else if ((self.style == NewsI004GYLMainStyleDefault||self.style == NewsI004GYLMainStyleOtherNoPic)&&self.data.top == 1){
		self.lab_content.text = TMFORMAT(@"          %@%@",typeName,data.information_title?:@"");
		self.top_laber.hidden = NO;
	}else if (self.style == NewsI004GYLMainStyleBigPictureView&&self.data.top == 1){
			
		self.lab_content.text = TMFORMAT(@"          %@%@",typeName,data.information_title?:@"");
		self.top_laber.hidden = NO;
	} 
	else{
		self.lab_content.text = TMFORMAT(@"%@%@",typeName,data.information_title?:@"")  ;
		self.top_laber.hidden = YES;
	}
 	 	
	
	NSArray *tmpArr =  [data.thumbnail  componentsSeparatedByString :@","];
	if (tmpArr.count == 3){
		self.view_type.hidden = [data.module_name isEqualToString:@"fcinformation"]||data.type == 1;
		[self.iconView sd_setImageWithURL:tmpArr[0]placeholderImage:[UIImage imageNamed:@"NewsI004.bundle/默认占位图2"]];
		[self.iconView1 sd_setImageWithURL:tmpArr[1]placeholderImage:[UIImage imageNamed:@"NewsI004.bundle/默认占位图2"]];
		[self.iconView2 sd_setImageWithURL:tmpArr[2]placeholderImage:[UIImage imageNamed:@"NewsI004.bundle/默认占位图2"]];
		
	}else if (tmpArr.count == 1){
		[self.iconView sd_setImageWithURL:tmpArr.firstObject  placeholderImage:[UIImage imageNamed:@"NewsI004.bundle/默认占位图2"]];
		
	}else if (tmpArr.count == 2){
		[self.iconView sd_setImageWithURL:tmpArr[0] placeholderImage:[UIImage imageNamed:@"NewsI004.bundle/默认占位图2"]];
		[self.iconView1 sd_setImageWithURL:tmpArr[1] placeholderImage:[UIImage imageNamed:@"NewsI004.bundle/默认占位图2"]];
	}
	else{	
		
		[self.iconView sd_setImageWithURL:[NSURL URLWithString:data.thumbnail] placeholderImage:[UIImage imageNamed:@"NewsI004.bundle/默认占位图2"]];
		
	}
	if (data.thumbnail.length < 1) {
    	self.iconView.hidden = YES;
	}
 
}
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
          [self init_ui];
          
    }
    return self;
}
- (void)testData {
	self.lab_date.text = @"1天前";
	self.lab_Column.text = @"央视网新闻";
	self.lab_content.text = @"岁末年初 牢记习近平的这些叮嘱 党政府首";
}
- (void)init_ui {

	
	UIImageView * iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = UIColor.blackColor;
    iconView.image  = [UIImage imageNamed:@"NewsI004.bundle/默认占位图2"];
    [self addSubview:iconView];
    self.iconView = iconView;
    
        UILabel * lab_categoryName =  [self lab_publicWithFontSize:18];
    lab_categoryName.textColor = TMColorFromRGB(0x000000);
    lab_categoryName.numberOfLines = 1;
    [self addSubview:lab_categoryName];
    self.lab_categoryName = lab_categoryName;
    
    UILabel * lab_content =  [self lab_publicWithFontSize:18];
    lab_content.textColor = TMColorFromRGB(0x000000);
    lab_content.numberOfLines = 3;
    [self addSubview:lab_content];
    self.lab_content = lab_content;
    
    
	UILabel  * lab_Column =  [self lab_publicWithFontSize:14];
	[self addSubview:lab_Column];
	self.lab_Column = lab_Column;
	
    UILabel  * lab_date =  [self lab_publicWithFontSize:14];
    [self addSubview:lab_date];
    self.lab_date = lab_date;

	NewsI004TypeHintingView * view_type = [[NewsI004TypeHintingView alloc] init];
    [self addSubview:view_type];
    
    self.view_type = view_type;
//  
	UIView *view_line = UIView.alloc.init;
   	view_line.backgroundColor = TMColorFromRGB(0xEFEFEF);
    [self addSubview:view_line];
    self.view_line = view_line;
      [view_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.height.mas_equalTo(0.5);
		make.bottom.equalTo(self).offset(-0.5);
    }] ;
 
	[self.top_laber mas_makeConstraints:^(MASConstraintMaker *make) {
   	 make.size.mas_offset(CGSizeMake(42, 19));
   	 make.left.top.equalTo(self.lab_content);
	 }];
	UIImageView * iconView1 = [[UIImageView alloc] init];
    iconView1.backgroundColor = UIColor.blackColor;
    iconView1.hidden = YES;
    [self addSubview:iconView1];
    self.iconView1 = iconView1;
    
	UIImageView * iconView2 = [[UIImageView alloc] init];
    iconView2.backgroundColor = UIColor.blackColor;
    iconView2.hidden = YES;
    [self addSubview:iconView2];
    self.iconView2 = iconView2;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


// 隐藏无图
-(void) sethideNoPic
{		//  15 + 15  + 10
	self.iconView.hidden = YES;
//	self.view_type.hidden = YES;
	self.lab_content.numberOfLines = 2;
    [self.lab_content mas_remakeConstraints:^(MASConstraintMaker *make) {
		if (self.style == NewsI004GYLMainStyleNews_card_Hidden) {
			make.left.mas_equalTo(7);
			make.right.mas_equalTo(-7);

		}else{
			make.left.mas_equalTo(15);
			make.right.mas_equalTo(-15);
		}
		make.top.mas_equalTo(15);
 
    }];
 
	[self.lab_Column mas_remakeConstraints:^(MASConstraintMaker *make) {
 
        make.height.mas_equalTo(14);
   		make.left.mas_equalTo(self.lab_content.mas_left);
//        make.width.mas_equalTo(100);
        make.top.equalTo(self.lab_content.mas_bottom).offset(10);
    }];
    [self.lab_date mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.left.equalTo(self.lab_Column.mas_right).offset(5);
        make.top.mas_equalTo(self.lab_Column);
    }];

   
}
- (UILabel *)top_laber
{
	if (!_top_laber) {
		self.top_laber = [[UILabel  alloc] initWithFrame:CGRectZero];
		self.top_laber.textAlignment = NSTextAlignmentCenter;
		self.top_laber.font = [UIFont systemFontOfSize:14];
		self.top_laber.layer.borderWidth = 1;
		self.top_laber.layer.borderColor = TMEngineConfig.instance.themeColor.CGColor;
//		TMColorFromRGB(0xC64238).CGColor; 
		self.top_laber.layer.cornerRadius = 5;
		self.top_laber.textColor = TMEngineConfig.instance.themeColor;
		self.top_laber.layer.masksToBounds = YES;
		self.top_laber.text = @"置顶";
		self.top_laber.hidden = YES;
		[self addSubview:self.top_laber];
	}
	return _top_laber;
}
 

- (void)updateConstraints{
	
	switch (self.style) {
		case NewsI004GYLMainStyleThreeFigure:
			[self threeFigureLayout];
			break;
		case NewsI004GYLMainStyleBigPictureView:
			[self bigPictureViewLayout];
			
			break;
		case NewsI004GYLMainStyleNews_card:
			[self News_cardViewLayout];
			break;
		case NewsI004GYLMainStyleNews_card_Hidden:
			[self sethideNoPic];
			break;
		case NewsI004GYLMainStyleBigPictureView_Hidden:
			[self sethideNoPic];
			break;
		case NewsI004GYLMainStyleThreeFigure_card:
			[self threeFigureLayout_card];
			break;
		case NewsI004GYLMainStyleOtherNoPic:
			[self sethideNoPic];
			break;
		default:
			[self  imgRightViewLayout];
			break;
	}
	[super updateConstraints];
}
// 图片右边布局
- (void) imgRightViewLayout 
{
    [self.iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120*(16/9), 70));
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(10);

    }];
    [self.lab_content mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.equalTo(self.iconView.mas_left).offset(-4);
        make.top.equalTo(self.iconView);
//        make.height.mas_equalTo(42);
    }];
	[self.lab_Column mas_remakeConstraints:^(MASConstraintMaker *make) {
 
        make.height.mas_equalTo(14);
   		make.left.mas_equalTo(self.lab_content.mas_left);
//        make.width.mas_equalTo(100);
        make.bottom.equalTo(self.lab_date.mas_bottom);
    }];
    [self.lab_date mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.left.equalTo(self.lab_Column.mas_right).offset(5);
        make.top.mas_equalTo(self.iconView.mas_bottom);
    }];
   [self.view_type mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([UIImage imageNamed:@"NewsI004.bundle/矩形"].size);
        make.right.equalTo(self.iconView.mas_right).offset(-3.5);
		make.bottom.equalTo(self.iconView.mas_bottom).offset(-2);
    }];
}
- (void) set_shadow{
 
	UIBezierPath *shadowPath = [UIBezierPath     
								bezierPathWithRect:self.bounds];  
	self.layer.masksToBounds = NO;  
	self.layer.shadowColor = [UIColor blackColor].CGColor;  
	self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);  
	self.layer.shadowOpacity = 0.5f;  
	self.layer.shadowPath = shadowPath.CGPath;  
 
}
#pragma mark  ---卡片 大图片 布局
// 卡片 大图片 布局
- (void) News_cardViewLayout  {
 
    
	self.view_line.hidden = YES;
     [self.lab_categoryName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(7);
        make.right.mas_equalTo(-7);
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(5);
        
//        make.height.mas_equalTo(42);
    }];
    
    
    [self.lab_content mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lab_categoryName.mas_right).offset(10);
        make.right.mas_equalTo(-7);
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(5);
        
//        make.height.mas_equalTo(42);
    }];
    
	[self.iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(170*(16/9));
        make.right.mas_equalTo(0);
		make.left.mas_equalTo(0);
        make.top.mas_equalTo(self).offset(0);

    }];
	[self.lab_Column mas_remakeConstraints:^(MASConstraintMaker *make) {
 
        make.height.mas_equalTo(14);
   		make.left.mas_equalTo(self.lab_content.mas_left);
//        make.width.mas_equalTo(100);
        make.top.equalTo(self.lab_content.mas_bottom).offset(5);
    }];
    [self.lab_date mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.left.equalTo(self.lab_Column.mas_right).offset(5);
        make.top.mas_equalTo(self.lab_Column);
    }];
   [self.view_type mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([UIImage imageNamed:@"NewsI004.bundle/矩形"].size);
        make.right.equalTo(self.iconView.mas_right).offset(-12);
		make.bottom.equalTo(self.iconView.mas_bottom).offset(-12);
    }];
 
}
// 单图  大图片 布局
- (void) bigPictureViewLayout  {
	 
    [self.lab_content mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(20);
 
    }];
    
	[self.iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(170*(16/9));
        make.right.mas_equalTo(-16);
		make.left.mas_equalTo(16);
        make.top.mas_equalTo(self.lab_content.mas_bottom).offset(8);

    }];
	[self.lab_Column mas_remakeConstraints:^(MASConstraintMaker *make) {
 
        make.height.mas_equalTo(14);
   		make.left.mas_equalTo(self.lab_content.mas_left);
//        make.width.mas_equalTo(100);
        make.bottom.equalTo(self.lab_date.mas_bottom);
    }];
    [self.lab_date mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.left.equalTo(self.lab_Column.mas_right).offset(5);
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(11);
    }];
   [self.view_type mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([UIImage imageNamed:@"NewsI004.bundle/矩形"].size);
        make.right.equalTo(self.iconView.mas_right).offset(-12);
		make.bottom.equalTo(self.iconView.mas_bottom).offset(-12);
    }];
}
// 三图样式布局
- (void)threeFigureLayout_card{
 	self.iconView2.hidden = NO;
	self.iconView1.hidden = NO;
	[self bringSubviewToFront:self.view_type];
	[self.lab_content mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(7);
        make.right.equalTo(self).offset(-7);
        make.top.mas_equalTo(18);
//        make.height.mas_equalTo(42);
    }];
	  
 		CGFloat  width   = (UIScreen.mainScreen.bounds.size.width -20*2- 7*2)/3;  // 120  *  
	   	 CGFloat  spacing =  5 ;  
       [self.iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, 70));
        make.left.mas_equalTo(7);
        make.top.equalTo(self.lab_content.mas_bottom).offset(4);
        
    	}];
    	
    	[self.iconView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        	make.size.mas_equalTo(CGSizeMake(width, 70));
         	make.top.equalTo(self.iconView);
        	make.left.equalTo(self.iconView.mas_right ).offset(spacing);
     	}];
    	
    	 [self.iconView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, 70));
        make.left.equalTo(self.iconView1.mas_right).offset(spacing);
		make.top.equalTo(self.iconView);
        
    	}];
	[self.lab_Column mas_remakeConstraints:^(MASConstraintMaker *make) {
 
        make.height.mas_equalTo(14);
   		make.left.mas_equalTo(self.lab_content.mas_left);
//        make.width.mas_equalTo(100);
        make.bottom.equalTo(self.lab_date.mas_bottom);
    }];
    [self.lab_date mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.left.equalTo(self.lab_Column.mas_right).offset(5);
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(7.5);
    }];
   [self.view_type mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([UIImage imageNamed:@"NewsI004.bundle/矩形"].size);
        make.right.equalTo(self.iconView2.mas_right).offset(-3.5);
		make.bottom.equalTo(self.iconView2.mas_bottom).offset(-2);
    }];
 
}
// 三图样式布局
- (void)threeFigureLayout
{
	self.iconView2.hidden = NO;
	self.iconView1.hidden = NO;
	[self bringSubviewToFront:self.view_type];
	[self.lab_content mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.equalTo(self).offset(-16);
        make.top.mas_equalTo(18);
//        make.height.mas_equalTo(42);
    }];
	  
 		CGFloat  width   = (UIScreen.mainScreen.bounds.size.width-15*2 -5*2)/3;  // 120  *  
	   	 CGFloat  spacing =  5 ;  
       [self.iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, 70));
        make.left.mas_equalTo(15);
        make.top.equalTo(self.lab_content.mas_bottom).offset(4);
        
    	}];
    	
    	[self.iconView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        	make.size.mas_equalTo(CGSizeMake(width, 70));
         	make.top.equalTo(self.iconView);
        	make.left.equalTo(self.iconView.mas_right ).offset(spacing);
     	}];
    	
    	 [self.iconView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, 70));
        make.left.equalTo(self.iconView1.mas_right).offset(spacing);
		make.top.equalTo(self.iconView);
        
    	}];
	[self.lab_Column mas_remakeConstraints:^(MASConstraintMaker *make) {
 
        make.height.mas_equalTo(14);
   		make.left.mas_equalTo(self.lab_content.mas_left);
//        make.width.mas_equalTo(100);
        make.bottom.equalTo(self.lab_date.mas_bottom);
    }];
    [self.lab_date mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.left.equalTo(self.lab_Column.mas_right).offset(5);
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(7.5);
    }];
   [self.view_type mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([UIImage imageNamed:@"NewsI004.bundle/矩形"].size);
        make.right.equalTo(self.iconView2.mas_right).offset(-3.5);
		make.bottom.equalTo(self.iconView2.mas_bottom).offset(-2);
    }];
}
-(BOOL) iSThumbnail:(NewsI004HomePageInformation_list *) listData
{
	if (listData.thumbnail == nil || [listData.thumbnail isEqualToString:@""]||listData.thumbnail.length<2||[listData.module_name isEqualToString:@"fcinformation"]||listData.type == 1) {
		self.view_type.hidden = YES;
		return YES;
	}	
	return NO;
}
-(NSString *)queriesTypes:(NewsI004HomePageInformation_list *) listData
{
 
    if (listData.type == 1&&![listData.module_name isEqualToString:@"fcvideo"])
    {
		self.view_type.hidden = YES;   
    }
    else if (listData.type == 2)
    {
		self.view_type.type = NewsI004HintingTypeAtlas; 
        if ([self iSThumbnail:listData]) {// 在无图默认和文章类型 才隐藏
//		  self.lab_content.text =  TMFORMAT(@"[图集] %@ ",listData.information_title);
		  //[@"[图集] " stringByAppendingString:self.lab_content.text];
		  return @"[图集]";
		}
		self.view_type.hidden = NO;
     }
    else if ([listData.module_name isEqualToString:@"fcinformation_theme"]) {
		self.view_type.type = NewsI004HintingTypeProject;   
		if ([self iSThumbnail:listData]) {
//			self.lab_content.text = [@"[专题] " stringByAppendingString: listData.information_title];
			return @"[专题]";
		}
 		self.view_type.hidden = NO;

    }else if ([listData.module_name isEqualToString:@"fcvideo"]){
    	self.view_type.type = NewsI004HintingTypeVideo;   
     if (listData.thumbnail == nil || [listData.thumbnail isEqualToString:@""]||listData.thumbnail.length<1) {
 
		  self.lab_content.text = [@"[视频] " stringByAppendingString: listData.information_title];
		  return @"[视频]";
		}
		 
 		self.view_type.hidden = NO;

    }else if ([listData.module_name isEqualToString:@"直播类型"]){
    		self.view_type.type = NewsI004HintingTypeLive;   
    		
    }else if ([listData.module_name isEqualToString:@"fcfind"]){// 服务类型 发现
 
	self.view_type.hidden = YES;
    }
	else if ([listData.module_name isEqualToString:@"fcinformation"]){// 资讯
 
	self.view_type.hidden = YES;   

    }else{
    self.view_type.hidden = YES;
	}
	return @"";
}
-(UILabel * )  lab_public {
    UILabel * lab = [[UILabel alloc] init];
    lab.textColor = TMColorFromRGB(0x9B9B9B);
 
    return lab;
}
-(UILabel *)lab_publicWithFontSize:(CGFloat)szie{
    UILabel * lab =  [self  lab_public];
    lab.font   = [UIFont systemFontOfSize:szie];
     return lab ;
}
- (void)layoutSubviews{
	[super layoutSubviews];
 
} 


@end
