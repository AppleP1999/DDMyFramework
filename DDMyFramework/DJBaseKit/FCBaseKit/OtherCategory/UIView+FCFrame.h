//
//  UIView+FCFrame.h
// 
//
//  Created by Charles on 16/9/1.
//  Copyright © 2019年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, FCDrawLineStyle) {
    FCDrawLineStyleTop,
    FCDrawLineStyleBottom
};

@interface UIView (FCFrame)
/**
 *  快速根据xib创建View
 */
+ (instancetype)fc_viewFromXib;
/**
 *  判断self和view是否重叠
 */
- (BOOL)fc_intersectsWithView:(UIView *)view;

/**
 *  起点x坐标
 */
@property (nonatomic, assign) CGFloat fc_x;
/**
 *  起点y坐标
 */
@property (nonatomic, assign) CGFloat fc_y;
/**
 *  中心点x坐标
 */
@property (nonatomic, assign) CGFloat fc_centerX;
/**
 *  中心点y坐标
 */
@property (nonatomic, assign) CGFloat fc_centerY;
/**
 *  宽度
 */
@property (nonatomic, assign) CGFloat fc_width;
/**
 *  高度
 */
@property (nonatomic, assign) CGFloat fc_height;
/**
 *  顶部
 */
@property (nonatomic, assign) CGFloat fc_top;
/**
 *  底部
 */
@property (nonatomic, assign) CGFloat fc_bottom;
/**
 *  左边
 */
@property (nonatomic, assign) CGFloat fc_left;
/**
 *  右边
 */
@property (nonatomic, assign) CGFloat fc_right;
/**
 *  size
 */
@property (nonatomic, assign) CGSize fc_size;
/**
 *  起点坐标
 */
@property (nonatomic, assign) CGPoint fc_origin;


- (void)fc_drawLineStyle:(FCDrawLineStyle)style;

/**
 *  在顶部或者底部画线
 *
 *  @param margin 左间距（右间距和左间距相等）
 *  @param style  顶部或者底部
 */
- (void)fc_drawLineWithMargin:(CGFloat)margin style:(FCDrawLineStyle)style;

/**
 *  在顶部或者底部画线
 *
 *  @param leftMargin  左边间距
 *  @param rightMargin 右边间距
 *  @param style       顶部或者底部
 */
- (void)fc_drawLineWithleftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin style:(FCDrawLineStyle)style;

/**
 *  在顶部或者底部画线
 *
 *  @param leftMargin  左边间距
 *  @param rightMargin 右边间距
 *  @param style       顶部或者底部
 *  @param color       线的颜色
 */
- (void)fc_drawLineWithleftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin style:(FCDrawLineStyle)style color:(UIColor *)color;

// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen;
@end
