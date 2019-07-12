//
//  ViewController.m
//  DDMyFramework
//
//  Created by omni－appple on 2018/10/30.
//  Copyright © 2018年 COM.Sobey.dengjie. All rights reserved.
//
#import "ToolsI002CategoryViewController.h"
#import "ViewController.h"
#import "Livel003ChatView.h"
#import "Livel003CollectionHeadView.h"
#import "Livel003PicFocusView.h"
#import "Live003lGraphicBouncedView.h"
#import "UILabel+FCEx.h"
//#import "NSDictionary+PropertyCode.h"
#import <MJExtension.h>
#import <Masonry.h>
#import "Livel003AudioAnimation.h"
#import "tModel.h"
//#import <FCBaseKit/UIView+FCFrame.h>
// #import <TMSDK/TMSDK.h>
#import <ParadigmSDK/ParadigmSDK.h>
#import "Livel003VideoCollectionView.h"
#import "Livel003DjHeaderView.h"
#import <AFNetworking.h>
#import "InformListViewController.h"
#import "DDRollingBoutton.h"
#import "FCRollingView.h"
#import "FYPlayManager.h"
#import "DestinationModel.h"
#define  kWindow  [UIApplication sharedApplication].keyWindow.subviews.lastObject
@interface ViewController ()
@property(nonatomic,weak)Livel003ChatView * ttView ;
@property (nonatomic, strong)  UIImageView * scanImage;
@property (nonatomic, strong)  UIImageView * scanImage2;
@property (nonatomic, weak) FCRollingBGView * btn;

@end

@implementation ViewController
{
    CGFloat angle;
    BOOL of;
}
- (IBAction)test:(id)sender 
{
 
}

- (IBAction)slider:(UISlider *)sender 
{
	TracksViewModel * model  = [[TracksViewModel  alloc] initWithitemModel:1];
    
    DTracks * t = [[DTracks  alloc] init];
    DTracks_List * list = DTracks_List.new;
    list.duration = 360;
    list.playUrl64 = @"";
    list.title = @"";
 
    t.list = @[list];
    
    model.model.tracks = t;
    
   [kFYPlayManagerInstance playWithModel:model indexPathRow:0];
}

 
 
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
//	[_btn takeBack];
}
- (void)viewDidLoad 
{
	[super viewDidLoad];
 	FCRollingBGView *btn = [[FCRollingBGView  alloc] init];
	self.btn = btn;
 
//	Livel003PicFocusView *  tt2View  =[[Livel003PicFocusView alloc] initWithFrame:CGRectMake(0, 280, 100, 40)];
//	[self.view addSubview:tt2View]; 电饭锅
//	self.scanImage = [[UIImageView  alloc] initWithFrame:CGRectMake(100, 250, 80, 80)];
// 	self.scanImage2 = [[UIImageView  alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
//// 	self.scanImage2.
//	self.scanImage2.image = [UIImage imageNamed:@"首帧图"];
//	[self.scanImage addSubview:self.scanImage2];
//	self.scanImage.image = [UIImage imageNamed:@"播放背景"];
////	self.scanImage.fc_x = 10;
//	[self.view addSubview:self.scanImage]; 
 
//		Livel003CollectionHeadView * ttView = [Livel003CollectionHeadView  itemWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 60)];
//		[self.view addSubview:ttView];
////		self.ttView = ttView;
//		[self testbutton];
////		self.view.backgroundColor = UIColor.orangeColor;
//		UILabel * lab  = [[UILabel alloc] initWithFrame:CGRectMake(200, 300, 120, 20)];
//		lab.text = @"12345";
//		[lab attributedWithImg:[UIImage imageNamed:@"点赞1"] ImgBounds:CGRectMake(0, -5, 20, 20) size:15 textColor:UIColor.redColor];
// 
// 	[self.view addSubview:lab];
		Livel003VideoCollectionView * tView  = [Livel003VideoCollectionView itmeWithisHorizontal:NO];
//		tView
   		
//		UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)tView.collectionView.collectionViewLayout;
//		layout.itemSize = CGSizeMake(230, 150);	
//		 layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		[self.view addSubview:tView];
		[tView mas_makeConstraints:^(MASConstraintMaker *make) {
//			make.edges.equalTo(self.view);
		make.left.right.top.equalTo(self.view);
		make.height.equalTo(@230);
		}];
//      angle = 0;
//    [self startAnimation];
//	Livel003AudioAnimation * tView = [[Livel003AudioAnimation alloc] init];
//	[tView start];
//	[self.view addSubview:tView];
//	[tView mas_makeConstraints:^(MASConstraintMaker *make) {
//	 make.size.mas_equalTo(CGSizeMake(100, 100));
//	 make.top.equalTo(@300);
//	 make.left.equalTo(@300);
//	}];
//	
	/*
	 毛玻璃的样式(枚举)
	 UIBarStyleDefault = ,
	 UIBarStyleBlack = ,
	 UIBarStyleBlackOpaque = , // Deprecated. Use UIBarStyleBlack
	 UIBarStyleBlackTranslucent = , // Deprecated. Use UIBarStyleBlack and set the translucent property to YES
	 */
//	UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//	bgImgView.image = [UIImage imageNamed:@"huoying.jpg"];
//	[self.view addSubview:bgImgView];
//	UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(1, 1, bgImgView.frame.size.width., bgImgView.frame.size.height)];
//	toolbar.barStyle = UIBarStyleBlackTranslucent;
//	[bgImgView addSubview:toolbar];

//	Livel003DjHeaderView * theader = [[Livel003DjHeaderView alloc] init];
//	theader.lab_title.text = @"qwertyui";
//	theader.backgroundColor = UIColor.redColor;
//	[self.view addSubview:theader];
//		[theader mas_makeConstraints:^(MASConstraintMaker *make) {
////			make.edges.equalTo(self.view);
//		make.left.right.equalTo(self.view);
//		make.centerY.equalTo(self.view);
//		make.height.equalTo(@40);
//		}];
		 
//		  [[ParadigmSDK sharedInstance] requestRecomsWithSceneId:@"14063" itemId:@"5755" itemTitle:nil itemContent:nil completionHandler:^(NSArray<ParadigmRecomItem *> * _Nullable results, NSError * _Nullable error) {
//      
//          // 以下为纯示例代码，请勿复制使用。请根据您的业务具体处理，如保存数据、刷新页面等
//              if (error) {
//                  NSLog(@"%@",error.domain);
//              } else {
//              NSLog(@"results %@" , results);
////                  dispatch_async(dispatch_get_main_queue(), ^{
////                      [self.dataArray removeAllObjects];
////                      for (ParadigmRecomItem *item in results) {
////                          [self.dataArray addObject:item];
////                      }
////                      [self.tableView reloadData];
////                  });
//              }
//          }];
        
}
 
 

//方法1
-(void) startAnimation
{
	if (of) {
//    angle = 0;
    return;
	}
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    self.scanImage.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}

-(void)endAnimation
{
    angle += 2;
    [self startAnimation];
 
}

//方法2
//- (void)startAnimation
//{
//	if (of) {
//    	return;
//	}
//    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
//    
//    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.scanImage.transform = endAngle;
//    } completion:^(BOOL finished) {
//        angle += 2; 
//        [self startAnimation];
//    }];
//}
- (NSMutableAttributedString *)accWithImg:(UIImage *)img ImgBounds:(CGRect)imgbounds 
{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:nil?:@""];
//	  [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 9)];

	 NSTextAttachment * chment = [[NSTextAttachment alloc] init];
	 chment.image = [UIImage imageNamed:@"点赞1"];
	 chment.bounds = CGRectMake(0, -5, 20, 20);
	 NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:chment];
	 [attri insertAttributedString:string atIndex:0];
	 return attri;
}
- (void)testbutton {
    
     UIButton  * tempbut = UIButton.new;
     tempbut.frame = CGRectMake(100, 100, 120, 80);
     tempbut.backgroundColor = UIColor.redColor;
     [tempbut addTarget:self action:@selector(testClick) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:tempbut];
}
- (void)testClick	{
// 	tModel * p = tModel.new;
//	 p.name = @"发发发";
//	 p.age =@"19";
//	 p.att = @"安兔兔"; 
//	[NSKeyedArchiver archiveRootObject:p toFile:@"/Users/omni-appple/DJSobey/Person.plist"];
	
//		[FCApiTokenHelper isRequestVerifyWithMethod:@"sdd/sdd" withPostTime:<#(NSString *)#> intervals:<#(int)#>]
//	 tModel *p2 = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/omni-appple/DJSobey/Person.plist"];
//    NSLog(@"%@",p2);
   AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
	[manager POST:@"" parameters:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		
	}];

}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
