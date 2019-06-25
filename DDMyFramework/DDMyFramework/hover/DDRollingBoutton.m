//
//  DDRollingBoutton.m
//  EasyShop
//
//  Created by DengOC on 2018/7/3.
//  Copyright © 2018年 u1city01. All rights reserved.
//

#import "DDRollingBoutton.h"
#define ScreenWidth UIScreen.mainScreen.bounds.size.width
#define Screenheight UIScreen.mainScreen.bounds.size.height
@implementation DDRollingBoutton

+ (DDRollingBoutton* ) bouttonRollingWithButtomView:(UIView*)buttomView

{
    DDRollingBoutton *  btn  = [[DDRollingBoutton alloc] init];
    btn.view = buttomView;
    return btn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UIButton  *  button  = [[UIButton alloc] init];
        //    if (moveRedPacket==nil) {
        
//        self =   [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-50)/2,Screenheight-170,50,50)];
        self.frame = CGRectMake((ScreenWidth-50)/2,Screenheight-170,50,50);
        //    }
        self.layer.borderWidth=1;
        
        self.layer.cornerRadius=25;
        
        self.layer.masksToBounds =YES;
        
        //点击移动
        //    [[UIPanGestureRecognizer alloc]initWithTarget:@selector(handlePan:) ];
        UIPanGestureRecognizer *panTouch = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:) ];
        
        [self addGestureRecognizer:panTouch];
        
        // 长按隐藏
        
        UILongPressGestureRecognizer *longPressGR =
        
        [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        
        longPressGR.minimumPressDuration =1.5;
        
        [self addGestureRecognizer:longPressGR];
    }
    return self;
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
#pragma mark处理拖动手势

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    //视图前置操作
    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    CGPoint center = recognizer.view.center;
    CGFloat cornerRadius = recognizer.view.frame.size.width / 2;
    CGPoint translation = [recognizer translationInView:self.view];
    
    //NSLog(@"%@", NSStringFromCGPoint(translation));
    recognizer.view.center =CGPointMake(center.x + translation.x, center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if (recognizer.state ==UIGestureRecognizerStateEnded) 
    {
        
        //计算速度向量的长度，当他小于200时，滑行会很短
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude =sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude /200;
        //NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult); //e.g. 397.973175, slideMult: 1.989866
        //基于速度和速度因素计算一个终点
        float slideFactor =0.1 * slideMult;

        CGPoint finalPoint =CGPointMake(center.x + (velocity.x * slideFactor),
                                        
                                        center.y + (velocity.y * slideFactor));
        
        //限制最小［cornerRadius］和最大边界值［self.view.bounds.size.width - cornerRadius］，以免拖动出屏幕界限
        
        finalPoint.x =MIN(MAX(finalPoint.x, cornerRadius),
                          
                          self.view.bounds.size.width - cornerRadius);
		if (finalPoint.y<64)
		{
        	finalPoint.y = 64 ;		
		}
        finalPoint.y =MIN(MAX(finalPoint.y, cornerRadius),
                          
                          self.view.bounds.size.height - cornerRadius);
        
        //使用 UIView动画使 view滑行到终点
        
		if (finalPoint.x < ScreenWidth/2)
		{
			finalPoint.x = 15;
		}
		else
		{
			finalPoint.x = ScreenWidth - 40;		
		}
		
        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			
            recognizer.view.center = finalPoint;
            
        } completion:nil];
        
    }
    
}

@end
