//
//  LIve003lGraphicBouncedView.m
//  DDMyFramework
//
//  Created by omni－appple on 2019/4/2.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "UITextView+Livel003TextView.h"
#import "Live003lGraphicBouncedView.h"
#import "DDLDImagePicker.h"
#define DDWS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define  kWindow  [UIApplication sharedApplication].keyWindow.subviews.lastObject
#define  kUIScreen [UIScreen mainScreen].bounds.size
#define IsiPhoneX        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface Live003lGraphicBouncedView ()<DDLDImagePickerDelegate>
@property (nonatomic, weak) UIImageView *headView;
@property(nonatomic,weak)UILabel * lab_title;
@property(nonatomic,weak)UILabel * lab_content;

@property(nonatomic,weak)UITextField * tf_title;
@property(nonatomic,weak)UITextView * tf_content; 
 
@property(nonatomic,weak)UIButton * but_sedner ;
@property(nonatomic,weak)UIButton * but_exit ;

@property(nonatomic,weak)UIView * liveView1 ;
@property(nonatomic,weak)UIView * liveView ;

@property (nonatomic, strong) UIImage *selectImg;

@property(nonatomic,weak)UIViewController *currentVC;
@property (nonatomic, strong)UIAlertController *alertVC;

@end 
@implementation Live003lGraphicBouncedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    	 self.backgroundColor = [UIColor whiteColor];
        [self loadUI];
    }
    return self;
}
- (void)loadUI{
		NSDictionary * dic_Titles = @{
									@"新闻标题":@"请输入标题",
									@"新闻内容":@"请输入内容",
									  };
		 

		UILabel * lab_title = [[UILabel alloc] init];
		lab_title.text = @"图文直播"; 
		
		[self addSubview:lab_title];
		
		UIView * liveView1 = [[UIView alloc] init];
		liveView1.backgroundColor = [UIColor grayColor];
		[self addSubview:liveView1];
		
		UIButton * but_exit  = [[UIButton  alloc] init];
		but_exit.backgroundColor = [UIColor redColor];
		[but_exit addTarget:self action:@selector(click_butExit) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:but_exit]; 
		UITextField * tf_title = [[UITextField alloc] init];
		tf_title.placeholder = @"请输入标题"; 
		tf_title.font = [UIFont systemFontOfSize:14];
		[self addSubview:tf_title];
	
		UIView * liveView = [[UIView alloc] init];
		liveView.backgroundColor = [UIColor grayColor];
		[self addSubview:liveView];
		 
		

		UILabel * lab_content = [[UILabel alloc] init];
		lab_content.text = dic_Titles.allValues.lastObject;
		
		 
		[self addSubview:lab_content];
		
			
		UITextView * tf_content = [[UITextView alloc] init];
		tf_content.placeholder = @"请输入内容";; 
		
		
		
		[self addSubview:tf_content];
		
		UITextView * textView = [[UITextView alloc] init];
		[self addSubview:textView];
	UIImageView * headView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"拍摄相机选择"]];
	
	headView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"拍摄相机选择"]];
	//         [_headView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width/16*9)];
	headView.userInteractionEnabled = YES;
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBackView)];
	[headView addGestureRecognizer:tap];
	[self addSubview:headView];
	

		UIButton * but_sedner = [[UIButton alloc] init];
		[but_sedner setTitle:@"发布图文" forState:0];
		[but_sedner setBackgroundColor:[UIColor redColor] ];
		[but_sedner addTarget:self action:@selector(clickbut_sedner) forControlEvents:UIControlEventTouchUpInside];
		
		[self addSubview:but_sedner];
		self.headView = headView;
		self.liveView1 = liveView1;
		self.but_exit =  but_exit;
		self.but_sedner = but_sedner;
		self.liveView = liveView;
		self.lab_title = lab_title; 
		self.lab_content = lab_content;
		self.tf_content = tf_content;
		self.tf_title = tf_title;
		
	[self updateConstraintsIfNeeded];
	[self setNeedsUpdateConstraints];
}
- (void)updateConstraints{
	[self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(@15);
			make.height.equalTo(@25);
			make.width.equalTo(@100);
			make.top.equalTo(@10);

	}];
	
	[self.but_exit mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.equalTo(@-15);
			make.height.equalTo(@25);
			make.width.equalTo(@25);
			make.centerY.equalTo(self.lab_title);

	}];
	
	[self.liveView1 mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.left.equalTo(self);
			make.height.equalTo(@5);
			make.top.equalTo(self.lab_title.mas_bottom).offset(5);

	}];
	
	[self.tf_title mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(@15);
			make.height.equalTo(@25);
			make.right.equalTo(@-15);
	    	make.top.equalTo(self.liveView1.mas_bottom).offset(10);

	}];
	
	 [self.liveView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(self.tf_title).offset(5);
			make.height.equalTo(@0.5);
			make.right.equalTo(self.tf_title).offset(-5);
	    	make.top.equalTo(self.tf_title.mas_bottom).offset(10);

	}];
	
	[self.tf_content mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(@15);
			make.height.equalTo(@130);
			make.right.equalTo(@-15);
	    	make.top.equalTo(self.liveView.mas_bottom).offset(10);

	}];
 
	[self.but_sedner mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.right.equalTo(self);
			make.height.equalTo(@45);
	    	make.bottom.equalTo(self);

	}];
	
	[self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
//			make.left.equalTo(@15);
//			make.right.equalTo(@-15);
			make.centerX.equalTo(self);
			make.size.mas_equalTo(CGSizeMake(320, 150));
	    	make.top.equalTo(self.tf_content.mas_bottom).offset(10);
//	    	make.bottom.equalTo(self.but_sedner.mas_top).offset(-15);
	    	
	}];
	 [super updateConstraints];
}
+ (void)showVC:(UIViewController *)vc{
 	CGFloat height  = 460;
    UIButton *  bgView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kUIScreen.width, kUIScreen.height)];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
    bgView.tag = 10099;
    [kWindow addSubview:bgView];
	Live003lGraphicBouncedView * view_sheet = [[Live003lGraphicBouncedView   alloc]initWithFrame:CGRectMake(0, kUIScreen.height, kUIScreen.width, height)];
	view_sheet.currentVC = vc;
        

  void (^ disappearAnimationBlock)(void) = ^(void){
        [UIView animateWithDuration:0.5 animations:^{
            view_sheet.frame =  CGRectMake(0, kUIScreen.height, kUIScreen.width, height);
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    };
 
	[bgView addSubview:view_sheet];
    [UIView animateWithDuration:0.5 animations:^{
	view_sheet.frame =  CGRectMake(0, kUIScreen.height-height-IsiPhoneX, kUIScreen.width, height);
    }];
 
	view_sheet.clickBlock_call = ^() {
 
        !disappearAnimationBlock?nil:disappearAnimationBlock();
    };
} 
//- (UIImageView *)headView {
//    
//    if (!_headView) {
//        _headView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"封面"]];
//         [_headView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width/16*9)];
//        _headView.userInteractionEnabled = YES;
////        [_backScroll addSubview:_headView];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBackView)];
//        [_headView addGestureRecognizer:tap];
//    }
//    return _headView;
//}

- (void)clickbut_sedner{
        NSData *dataObj = [[NSData alloc]init];

	if (self.selectImg) {
		dataObj = UIImageJPEGRepresentation(self.selectImg, 0.3);
		}
	NSDictionary * dict = @{
			  	 @"title":self.tf_title.text,
			  	 @"content":self.tf_content.text,
			  	 @"img":dataObj,
			  	 @"xxxxid":@"",
			  	 @"menberId":@"",
							};
							
							
	NSLog(@"发送dict %@" ,dict); 
}
- (void)chooseBackView{
 
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
   
    DDWS(ws);
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        DDLDImagePicker *imagePicker = [DDLDImagePicker sharedInstance];
        imagePicker.delegate = ws;
        [imagePicker showImagePickerWithType:0 InViewController:ws.currentVC Scale:0.5625];
        
    }];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        DDLDImagePicker *imagePicker = [DDLDImagePicker sharedInstance];
        imagePicker.delegate = ws;
        [imagePicker showImagePickerWithType:1 InViewController:ws.currentVC Scale:0.5625];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
  
    
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [alertVc addAction:cancelAction];
    _alertVC = alertVc;
    [self.currentVC presentViewController: alertVc animated:YES completion:nil];
 
}

- (void)click_butExit{
		if (self.clickBlock_call) {
    		self.clickBlock_call();
		}
}
#pragma mark -- 实现imagePicker的代理方法
- (void)imagePicker:(DDLDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    [_headView setImage:editedImage];
    _selectImg = editedImage;
//	   [self popoverPresentationController];
}
- (void)imagePickerDidCancel:(DDLDImagePicker *)imagePicker{
    [self.currentVC popoverPresentationController];
}
@end
