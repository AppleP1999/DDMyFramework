//
//  UIButton+DDExtensiontEvent.m
//  testDemo001
//
//  Created by DengOC on 2018/6/1.
//  Copyright © 2018年 DDAppleDengjie. All rights reserved.
//

#import "UIButton+DDExtensiontEvent.h"
#import <objc/runtime.h>

 
@implementation UIButton (DDExtensiontEvent)
static DDExtensionEventCallBlcok _callBlock;
+(instancetype)buttonFrame:(CGRect)frame callBlcok:(DDExtensionEventCallBlcok)callBlcok
{
    UIButton * btn = [[UIButton alloc ] initWithFrame:frame callBlcok:callBlcok];
    return btn;
}
- (instancetype)initWithFrame:(CGRect)frame callBlcok:(DDExtensionEventCallBlcok)callBlcok
{
    self = [super initWithFrame:frame];
    if (self) {
        [self add_ddcallBlcokAction:callBlcok];
    }
    return self;
}
-(DDExtensionEventCallBlcok)getCallBlcok
{
    return objc_getAssociatedObject(self, &_callBlock);
}
-(void)setCallBlcok:(DDExtensionEventCallBlcok)callBlcok
{
    objc_setAssociatedObject(self, &_callBlock, callBlcok, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)add_ddcallBlcokAction:(DDExtensionEventCallBlcok)block
{
    [self add_ddcallBlcokAction:block forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(dd_DownAction:) forControlEvents:UIControlEventTouchDown];
 
    [self addTarget:self action:@selector(dd_UpAction:) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel | UIControlEventTouchDragOutside)];
}
-(void)add_ddcallBlcokAction:(DDExtensionEventCallBlcok)block forControlEvents:(UIControlEvents)controlEvents
{   [self setCallBlcok:block];
    [self addTarget:self action:@selector(dd_bttonAction:) forControlEvents:controlEvents];
}
-(void )dd_DownAction:(UIButton *)btn
{
    btn.enabled = NO;
    btn.alpha = 0.5;
}
-(void )dd_UpAction:(UIButton *)btn
{
    btn.enabled = YES;
    btn.alpha = 1.0;
}
-(void)dd_bttonAction:(UIButton *) btn {
    if (self.getCallBlcok!=nil) {
     self.getCallBlcok(btn);
    }
 
//    __weak typeof(self)WeakSelf = self;
//    WeakSelf.getCallBlcok(btn);
}
@end
