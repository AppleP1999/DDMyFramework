//
//  UIView+FCFrame.m
// 
//
//  Created by Charles on 16/9/1.
//  Copyright © 2019年 Charles. All rights reserved.
//

#import "UIView+FCFrame.h"
#define kDefautColor [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1]
@implementation UIView (FCFrame)
+ (instancetype)fc_viewFromXib
{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
- (BOOL)fc_intersectsWithView:(UIView *)view
{
    //都先转换为相对于窗口的坐标，然后进行判断是否重合
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
}
- (void)setFc_x:(CGFloat)fc_x {
    CGRect frame = self.frame;
    frame.origin.x = fc_x;
    self.frame = frame;
}

- (void)setFc_y:(CGFloat)fc_y {
    CGRect frame = self.frame;
    frame.origin.y = fc_y;
    self.frame = frame;
}

- (CGFloat)fc_x {
    return self.frame.origin.x;
}

- (CGFloat)fc_y {
    return self.frame.origin.y;
}
-(void)setFc_centerX:(CGFloat)fc_centerX
{
	  CGPoint center = self.center;
    	center.x = fc_centerX;
    	self.center = center;
}
 
- (CGFloat)fc_centerX {
    return self.center.x;
}
-(void)setFc_centerY:(CGFloat)fc_centerY{

  	CGPoint center = self.center;
    center.y = fc_centerY;
    self.center = center;
    
}
 
- (CGFloat)fc_centerY {
    return self.center.y;
}

- (void)setFc_width:(CGFloat)fc_width {
    CGRect frame = self.frame;
    frame.size.width = fc_width;
    self.frame = frame;
}

- (void)setFc_height:(CGFloat)fc_height {
    CGRect frame = self.frame;
    frame.size.height = fc_height;
    self.frame = frame;
}

- (CGFloat)fc_height {
    return self.frame.size.height;
}

- (CGFloat)fc_width {
    return self.frame.size.width;
}

- (void)setFc_size:(CGSize)fc_size {
    CGRect frame = self.frame;
    frame.size = fc_size;
    self.frame = frame;
}

- (CGSize)fc_size {
    return self.frame.size;
}
-(void)setFc_origin:(CGPoint)fc_origin
{
    CGRect frame = self.frame;
    frame.origin = fc_origin;
    self.frame = frame;
}

- (CGPoint)fc_origin {
    return self.frame.origin;
}
- (CGFloat)fc_top
{
    return self.frame.origin.y;
}

- (void)setFc_top:(CGFloat)fc_top
{
    CGRect frame = self.frame;
    frame.origin.y = fc_top;
    self.frame = frame;
}

- (CGFloat)fc_left
{
    return self.frame.origin.x;
}
- (void)setFc_left:(CGFloat)fc_left
{
    CGRect frame = self.frame;
    frame.origin.x = fc_left;
    self.frame = frame;
}


- (CGFloat)fc_bottom
{
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setFc_bottom:(CGFloat)fc_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = fc_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)fc_right
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setFc_right:(CGFloat)fc_right
{
    CGRect frame = self.frame;
    frame.origin.x = fc_right - frame.size.width;
    self.frame = frame;
}
- (void)fc_drawLineStyle:(FCDrawLineStyle)style {
    [self fc_drawLineWithMargin:0 style:style];
}

/**
 *  在顶部或者底部画线
 *
 *  @param margin 左间距（右间距和左间距相等）
 *  @param style  顶部或者底部
 */
- (void)fc_drawLineWithMargin:(CGFloat)margin style:(FCDrawLineStyle)style {
    [self fc_drawLineWithleftMargin:margin rightMargin:margin style:style];
}

/**
 *  在顶部或者底部画线
 *
 *  @param leftMargin  左边间距
 *  @param rightMargin 右边间距
 *  @param style       顶部或者底部
 */
- (void)fc_drawLineWithleftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin style:(FCDrawLineStyle)style {
    [self fc_drawLineWithleftMargin:leftMargin rightMargin:rightMargin style:style color:kDefautColor];
}

/**
 *  在顶部或者底部画线
 *
 *  @param leftMargin  左边间距
 *  @param rightMargin 右边间距
 *  @param style       顶部或者底部
 *  @param color       线的颜色
 */
- (void)fc_drawLineWithleftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin style:(FCDrawLineStyle)style color:(UIColor *)color {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor =  color;
    switch (style) {
        case FCDrawLineStyleTop:
            lineView.frame = CGRectMake(leftMargin, 0, self.frame.size.width-leftMargin-rightMargin, 0.5);
            break;
        case FCDrawLineStyleBottom:
            lineView.frame = CGRectMake(leftMargin, self.frame.size.height-0.5, self.frame.size.width-leftMargin-rightMargin, 0.5);
            lineView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            break;
        default:
            break;
    }
    lineView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //防止多次添加lineView
    if (self.tag == 12667) {
        return;
    }
    self.tag = 12667;
    [self addSubview:lineView];
}

// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen
{
    if (self == nil) {
        return FALSE;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    
    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    
    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}
 


@end
