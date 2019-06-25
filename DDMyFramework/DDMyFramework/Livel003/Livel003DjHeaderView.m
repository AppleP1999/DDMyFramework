//
//  Livel003DjHeaderView.m
//  VideoList
//
//  Created by DengOC on 2018/9/23.
//  Copyright © 2018年 COM.Sobey. All rights reserved.
//
//#import <TMSDK/TMSDK.h>
#import "Livel003DjHeaderView.h"
#import <Masonry/Masonry.h>
@interface Livel003DjHeaderView ()
@property(nonatomic,weak) UIImageView * LeftView;
@property(nonatomic,strong) UIButton * but_1;
@property(nonatomic,strong) UIButton * but_2;

@property(nonatomic,weak) UILabel * lab_subTitle;
@end

@implementation Livel003DjHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor =  TMColorFromRGB(0xEFEFEF);

        [self init_ui];
        [self set_testData];
    }
    return self;
}
-(UIButton *)but_2
{
    if (!_but_2) {
        _but_2 = [self button_publicWithTitle:@"最新"];
    }
    return _but_2;
}

-(UIButton *)but_1
{
    if (!_but_1) {
        _but_1 = [self button_publicWithTitle:@"快报"];
        
     }
    return _but_1;
}

-(UIButton  *) button_publicWithTitle:(NSString *)title {//TMColorFromRGB(0xC64238)
    UIButton * but_p = [UIButton   buttonWithType:UIButtonTypeCustom];
    but_p.titleLabel.font = [UIFont systemFontOfSize:12];
//    [but_p setTitleColor:TMEngineConfig.instance.themeColor forState:0];
    but_p.alpha =  0.7;
    [but_p setTitle:title forState:0];
    [but_p addTarget:self action:@selector(clickButtonsender:) forControlEvents:UIControlEventTouchUpInside];
    but_p.userInteractionEnabled = NO;
    return but_p;
}


-(void) init_ui{
 //    v_header.backgroundColor = TMColorFromRGB(0xEFEFEF);
    UIImageView * v_he1  = [[UIImageView alloc] init];
    v_he1.backgroundColor = UIColor.orangeColor; 
   //  TMEngineConfig.instance.themeColor;
    UILabel * lab_headerTitle = [[UILabel alloc] init];
//    lab_headerTitle.textColor = TMColorFromRGB(0x424242);
    lab_headerTitle.font = [UIFont systemFontOfSize:16];
    lab_headerTitle.text = @"";
    [self  addSubview: lab_headerTitle];
    
    [self  addSubview: v_he1];
    self.lab_title = lab_headerTitle;
    self.LeftView = v_he1;
    [v_he1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 21));
        make.left.mas_equalTo(6);
        make.centerY.equalTo(lab_headerTitle) ;
        
    }];
    [lab_headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
//        make.width.mas_equalTo(65);
        make.left.equalTo(v_he1.mas_right).offset(6);
        make.centerY.equalTo(self);
    }];
    
    UIButton *  img_arrow =   [UIButton buttonWithType:UIButtonTypeCustom];
    [img_arrow  setImage:[UIImage imageNamed:@"Livel003.bundle/Arrow"] forState:0];
    [self addSubview: img_arrow ];
    [img_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(lab_headerTitle.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 20));
    }] ;
     UIButton *  but_click =   [UIButton buttonWithType:UIButtonTypeCustom];
     [but_click addTarget:self action:@selector(click_butRight) forControlEvents:UIControlEventTouchUpInside];
     [self addSubview: but_click ];
    [but_click mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
         make.width.mas_equalTo(60);
         make.height.mas_equalTo(50);
    }] ;
    UILabel *  lab_subTitle =   [[UILabel alloc] init];
    lab_subTitle.font = [UIFont systemFontOfSize:14];
    [lab_subTitle setTextColor:UIColor.lightGrayColor ];
    lab_subTitle.textAlignment = NSTextAlignmentRight;
    
    [self addSubview: lab_subTitle];
    self.lab_subTitle  = lab_subTitle;
    [lab_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(img_arrow.mas_left);
        make.centerY.equalTo(lab_headerTitle.mas_centerY);
        make.height.mas_equalTo(17);
        make.left.equalTo(lab_headerTitle.mas_right).offset(5);
    }] ;
    
    
}
-(void) set_styleRound
{	
	self.LeftView.frame = CGRectMake(0, 0, 20, 13);
//	self.LeftView.backgroundColor  = [UIColor whiteColor];
//	[self.LeftView  setImage:[UIImage imageNamed:@"Livel003.bundle/Group 21"]];
//	self.LeftView.backgroundColor = UIColor.orangeColor;
//	self.LeftView.image  = [UIImage imageNamed:@"Livel003.bundle/Group 21"];
//	self.LeftView.image = [self.LeftView.image   imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
//	self.LeftView.image = [self imageChangeColor:UIColor.blackColor img:self.LeftView.image];
	[self.LeftView mas_remakeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(20);
		make.height.mas_equalTo(13);
		make.left.equalTo(self);
		make.bottom.equalTo(self.lab_title.mas_bottom).offset(-5);
		
	}];
 	//线的路径
    UIBezierPath *polygonPath = [UIBezierPath bezierPath];
    
    // 这些点的位置都是相对于所在视图的
    // 起点
    [polygonPath moveToPoint:CGPointMake(6, 2)];
    // 其他点
    [polygonPath addLineToPoint:CGPointMake(10, 6)];
    [polygonPath addLineToPoint:CGPointMake(6, 10.5)];
    
//    [polygonPath closePath]; // 添加一个结尾点和起点相同
	UIBezierPath *polygonPath2 = [UIBezierPath bezierPath];
    
    // 这些点的位置都是相对于所在视图的
    CGFloat  x = 5;
    // 起点
    [polygonPath2 moveToPoint:CGPointMake(6+x, 2)];
    // 其他点
    [polygonPath2 addLineToPoint:CGPointMake(10+x, 6)];
    [polygonPath2 addLineToPoint:CGPointMake(6+x, 10.5)];
    
	CAShapeLayer *polygonLayer2 = [CAShapeLayer layer];
    polygonLayer2.lineWidth = 1.5;
    polygonLayer2.strokeColor = [UIColor whiteColor].CGColor;
    polygonLayer2.path = polygonPath2.CGPath;
    polygonLayer2.fillColor = nil; // 默认为blackColor
    
    CAShapeLayer *polygonLayer = [CAShapeLayer layer];
    polygonLayer.lineWidth = 1.5;
    polygonLayer.strokeColor = [UIColor whiteColor].CGColor;
    polygonLayer.path = polygonPath.CGPath;
    polygonLayer.fillColor = nil; // 默认为blackColor
    [self.LeftView.layer addSublayer:polygonLayer];
    [self.LeftView.layer addSublayer:polygonLayer2];
 	
	//TODO:uiview 单边圆角或者单边框
	UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.LeftView.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:CGSizeMake(self.LeftView.frame.size.height/2,self.LeftView.frame.size.height/2)];//圆角大小
	CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
	maskLayer.frame = self.LeftView.bounds;
	maskLayer.path = maskPath.CGPath;
	self.LeftView.layer.mask = maskLayer;
 	
}
-(UIImage*)imageChangeColor:(UIColor*)color img:(UIImage *) img
{
    //获取画布
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0f);
    //画笔沾取颜色
    [color setFill];
    
    CGRect bounds = CGRectMake(0, 0, img.size.width, img.size.height);
    UIRectFill(bounds);
    //绘制一次
    [img drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    //再绘制一次
    [img drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    //获取图片
    UIImage *imga = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imga;
}
-(void) set_stylebutton
{   self.LeftView.hidden = YES;
    self.lab_title.hidden = YES;
    self.lab_subTitle.textAlignment = NSTextAlignmentLeft;
// 	self.but_1.backgroundColor =  TMColorFromRGB(0xFFE7E7);//#FFE7E7

    self.backgroundColor = [UIColor whiteColor];
    [self addSubview: self.but_1];
    [self addSubview: self.but_2];
    self.but_2.userInteractionEnabled = YES;
    self.but_1.userInteractionEnabled = YES;
    [self.but_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(34, 23));
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(15);

    }];
    [self.but_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(34, 23));
        make.top.equalTo(self.but_1);
        make.left.equalTo(self.but_1.mas_right);
    }];
    UIView *vline = [[UIView alloc] init];
    vline.backgroundColor = [UIColor lightGrayColor];//#E0E0E0
    [self addSubview:vline];
    [vline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.but_2.mas_right).offset(7);
        make.size.mas_equalTo(CGSizeMake(1, 18));
        make.top.equalTo(self.but_2.mas_top).offset(3);
    }];
    
    
    [self.lab_subTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vline.mas_right).offset(8);
        make.height.mas_equalTo(21);
        make.centerY.equalTo(self.lab_title.mas_centerY);

    }];
 
    
    
}
-(void)set_testData{
    
    self.lab_subTitle .text = @"更多"  ;
}
#pragma mark - button 点击事件
-(void) click_butRight{
			if (self.right_action) {
			self.right_action(self.section);
		}
}
-(void)clickButtonsender:(UIButton *) sender{
    if (![sender.titleLabel.text isEqualToString:@"最新"]) {
//        _but_1.backgroundColor =  TMColorFromRGB(0xFFE7E7);//#FFE7E7
        _but_2.backgroundColor = [UIColor whiteColor];

    }else{
//        _but_2.backgroundColor = TMColorFromRGB(0xFFE7E7);;
        _but_1.backgroundColor = [UIColor whiteColor];

 
    }
    if (self.action) {
     	self.action(sender.titleLabel.text);
    }
}
@end
