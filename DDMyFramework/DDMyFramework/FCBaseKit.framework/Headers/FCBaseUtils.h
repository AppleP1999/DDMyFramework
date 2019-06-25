//
//  FCBaseUtils.h
//  TmCompDemo
//
//  Created by lym on 2018/7/2.
//  Copyright © 2018年 ZhouYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FCBaseUtils : NSObject


+ (UIView *)createViewWithRadius:(CGFloat)radius;
+ (UIView *)createLineView;


+ (UILabel *)createLabelWithFontSize:(CGFloat)szie textColor:(UIColor *)textColor;
+ (UILabel *)createLabelWithText:(NSString *)text;
+ (UILabel *)createLabelWithText:(NSString *)text size:(CGFloat)size;
+ (UILabel *)createLabelWithText:(NSString *)text size:(CGFloat)size alignment:(NSTextAlignment)alignment;
+ (UILabel *)createLabelWithText:(NSString *)text size:(CGFloat)size alignment:(NSTextAlignment)alignment textColor:(UIColor *)color;

+ (UIButton *)createBtnWithRadius:(CGFloat)radius title:(NSString *)title;
+ (UIButton *)createBorderBtnWithArrowImage;
+ (UIButton *)createBorderBtnWithArrowImageWithTitle:(NSString *)title;

+ (UITextField *)createTextFieldWithHoldText:(NSString *)holdText;
+ (UITextField *)createTextFieldWithHoldText:(NSString *)holdText fontSize:(CGFloat)size;
+ (UITextField *)createTextFieldWithHoldText:(NSString *)holdText fontSize:(CGFloat)size leftView:(UIView *)view;
+ (UITextField *)createTextFieldWithHoldText:(NSString *)holdText fontSize:(CGFloat)size leftImage:(UIImage *)leftImage leftImageSize:(CGSize)leftSize;
+ (UITextField *)createBorderTextFieldWithHoldText:(NSString *)holdText fontSize:(CGFloat)size;

+ (UIButton *)createNoBorderBtnWithTitle:(NSString *)title;
+ (UIButton *)createNoBorderBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;
+ (UIButton *)createNoBorderBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)size;
+ (UIButton *)createNoBorderBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)size backgroundColor:(UIColor *)backgroundColor;
+ (UIButton *)createNoBorderBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)size backgroundColor:(UIColor *)backgroundColor Radius:(CGFloat)radius;


+ (UIButton *)createBtnWithImage:(UIImage *)image;
+ (UIButton *)createBtnWithImage:(UIImage *)image selectedImage:(UIImage *)sImage;
+ (UIButton *)createBtnWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

+ (UITextView *)createTextViewWithPlaceholder:(NSString *)text font:(UIFont *)font backgroundColor:(UIColor *)color cornerRadius:(CGFloat)radius textColor:(UIColor *)textColor;

@end
