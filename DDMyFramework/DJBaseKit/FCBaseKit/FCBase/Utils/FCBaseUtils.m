//
//  FCBaseUtils.m
//  TmCompDemo
//
//  Created by lym on 2018/7/2.
//  Copyright © 2018年 ZhouYou. All rights reserved.
//

#import "FCBaseUtils.h"
#import <Masonry/Masonry.h>
#import "FCBaseDefine.h"

@implementation FCBaseUtils
+ (UIView *)createViewWithRadius:(CGFloat)radius
{
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = radius;
    view.layer.shadowColor = [UIColor grayColor].CGColor;
    view.layer.shadowRadius = radius ;
    view.layer.shadowOpacity = 0.3;
    view.layer.shadowOffset  = CGSizeMake(0, 3);// 阴影的范围
    return view;
}

+ (UILabel *)createLabelWithFontSize:(CGFloat)szie textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize: szie];
    return label;
}

+ (UILabel *)createLabelWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize: 15];
    return label;
}

+ (UILabel *)createLabelWithText:(NSString *)text size:(CGFloat)size
{
    UILabel *label = [self createLabelWithText: text];
    label.font = [UIFont systemFontOfSize: size];
    return label;
}

+ (UILabel *)createLabelWithText:(NSString *)text size:(CGFloat)size alignment:(NSTextAlignment)alignment
{
    UILabel *label = [self createLabelWithText: text size: size];
    label.textAlignment = alignment;
    return  label;
}

+ (UILabel *)createLabelWithText:(NSString *)text size:(CGFloat)size alignment:(NSTextAlignment)alignment textColor:(UIColor *)color
{
    UILabel *label = [self createLabelWithText: text size: size alignment: alignment];
    label.textColor = color;
    return  label;
}

+ (UIButton *)createBtnWithRadius:(CGFloat)radius title:(NSString *)title
{
    UIButton *button = [[UIButton alloc] init];
    button.layer.cornerRadius = radius;
    [button setTitle: title forState: UIControlStateNormal];
    [button setTitle: title forState: UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize: 15];
    return  button;
}

+ (UITextField *)createTextFieldWithHoldText:(NSString *)holdText
{
    UITextField *textField = [[UITextField alloc] init];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString: holdText];
    [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 ] range:NSMakeRange(0, holdText.length)];
    [placeholder addAttribute:NSForegroundColorAttributeName value:FCRGB(137, 137, 137) range:NSMakeRange(0, holdText.length)];
    //    NSMutableParagraphStyle *centerStyle = [textField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    //    centerStyle.minimumLineHeight = textField.font.lineHeight - (textField.font.lineHeight - [UIFont systemFontOfSize:12.0].lineHeight) / 2.0;
    //    [placeholder addAttribute:NSParagraphStyleAttributeName value:centerStyle range:NSMakeRange(0, holdText.length)];
    textField.attributedPlaceholder = placeholder;
    textField.textColor = FCRGB(137, 137, 137);
    textField.font = [UIFont systemFontOfSize: 12 ];
    textField.textAlignment = NSTextAlignmentLeft;
    return  textField;
}

+ (UITextField *)createTextFieldWithHoldText:(NSString *)holdText fontSize:(CGFloat)size
{
    UITextField *textField = [[UITextField alloc] init];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString: holdText];
    [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:NSMakeRange(0, holdText.length)];
    [placeholder addAttribute:NSForegroundColorAttributeName value:FCRGB(137, 137, 137) range:NSMakeRange(0, holdText.length)];
    //    NSMutableParagraphStyle *centerStyle = [textField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    //    centerStyle.minimumLineHeight = textField.font.lineHeight - (textField.font.lineHeight - [UIFont systemFontOfSize:12.0].lineHeight) / 2.0;
    //    [placeholder addAttribute:NSParagraphStyleAttributeName value:centerStyle range:NSMakeRange(0, holdText.length)];
    textField.attributedPlaceholder = placeholder;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize: size];
    textField.textAlignment = NSTextAlignmentLeft;
    return  textField;
}

+ (UITextField *)createTextFieldWithHoldText:(NSString *)holdText fontSize:(CGFloat)size leftView:(UIView *)view
{
    UITextField *textField = [self createTextFieldWithHoldText: holdText fontSize: size];
    textField.textColor = FCRGB(196, 196, 196);
    textField.leftView = view;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

+ (UITextField *)createTextFieldWithHoldText:(NSString *)holdText fontSize:(CGFloat)size leftImage:(UIImage *)leftImage leftImageSize:(CGSize)leftSize
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage: leftImage];
    imageView.frame = CGRectMake(0, 0, leftSize.width, leftSize.height);
    imageView.contentMode = UIViewContentModeCenter;
    UITextField *textField = [self createTextFieldWithHoldText: holdText fontSize: size leftView: imageView];
    return textField;
}

+ (UITextField *)createBorderTextFieldWithHoldText:(NSString *)holdText fontSize:(CGFloat)size
{
    UITextField *textField = [[UITextField alloc] init];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString: holdText];
    [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:NSMakeRange(0, holdText.length)];
    [placeholder addAttribute:NSForegroundColorAttributeName value:FCRGB(137, 137, 137) range:NSMakeRange(0, holdText.length)];
    //    NSMutableParagraphStyle *centerStyle = [textField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    //    centerStyle.minimumLineHeight = textField.font.lineHeight - (textField.font.lineHeight - [UIFont systemFontOfSize:12.0].lineHeight) / 2.0;
    //    [placeholder addAttribute:NSParagraphStyleAttributeName value:centerStyle range:NSMakeRange(0, holdText.length)];
    textField.attributedPlaceholder = placeholder;
    textField.textColor = FCRGB(137, 137, 137);
    textField.font = [UIFont systemFontOfSize: size];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.layer.borderColor = FCRGB(210, 210, 210).CGColor;
    textField.layer.borderWidth = 0.5;
    textField.layer.cornerRadius = 5 ;
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(12.5 ,0,12.5 ,30 )];
    leftView.backgroundColor = [UIColor clearColor];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return  textField;
}

+ (UIButton *)createNoBorderBtnWithTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle: title forState: UIControlStateNormal];
    [button setTitleColor: FCRGB(137, 137, 137) forState: UIControlStateNormal];
    [button setTitleColor: FCRGB(137, 137, 137) forState: UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize: 12];
    return button;
}

+ (UIButton *)createNoBorderBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor
{
    UIButton *button = [self createNoBorderBtnWithTitle: title];
    [button setTitleColor: titleColor forState: UIControlStateNormal];
    [button setTitleColor: titleColor forState: UIControlStateHighlighted];
    return button;
}

+ (UIButton *)createNoBorderBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)size
{
    UIButton *button = [self createNoBorderBtnWithTitle: title titleColor: titleColor];
    button.titleLabel.font = [UIFont systemFontOfSize: size];
    return button;
}

+ (UIButton *)createNoBorderBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)size backgroundColor:(UIColor *)backgroundColor
{
    UIButton *button = [self createNoBorderBtnWithTitle: title titleColor: titleColor fontSize: size];
    [button setBackgroundColor: backgroundColor];
    return button;
}

+ (UIButton *)createNoBorderBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)size backgroundColor:(UIColor *)backgroundColor Radius:(CGFloat)radius
{
    UIButton *button = [self createNoBorderBtnWithTitle: title titleColor:titleColor fontSize: size backgroundColor: backgroundColor];
    button.layer.cornerRadius = radius;
    return button;
}

+ (UIButton *)createBorderBtnWithArrowImage
{
    UIImage *arrowImage = [UIImage imageNamed: @"下拉三角"];
    UIButton *button = [[UIButton alloc] init];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = FCRGB(210, 210, 210).CGColor;
    button.layer.cornerRadius = 3 ;
    UIImageView *districtImageView = [[UIImageView alloc] initWithImage: arrowImage];
    [button addSubview: districtImageView];
    [districtImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(button);
        make.right.equalTo(button).with.offset(-12 );
        make.size.mas_equalTo(CGSizeMake( arrowImage.size.width,  arrowImage.size.height));
    }];
    return button;
}

+ (UIButton *)createBorderBtnWithArrowImageWithTitle:(NSString *)title
{
    UIImage *arrowImage = [UIImage imageNamed: @"下拉三角"];
    UIButton *button = [[UIButton alloc] init];
    //    [button setTitle: name forState: UIControlStateNormal];
    //    [button setTitle: name forState: UIControlStateHighlighted];
    //    button.titleLabel.font = [UIFont systemFontOfSize: 12 ];
    //    [button setTitleColor: FCRGB(137, 137, 137) forState: UIControlStateNormal];
    //    [button setTitleColor: FCRGB(137, 137, 137)  forState: UIControlStateHighlighted];
    //    button.layer.borderWidth = 0.5;
    //    button.layer.borderColor = FCRGB(210, 210, 210).CGColor;
    //    button.layer.cornerRadius = 3 ;
    [button setTitle: title forState: UIControlStateNormal];
    [button setTitle: title forState: UIControlStateHighlighted];
    [button setTitleColor: FCRGB(137, 137, 137) forState: UIControlStateNormal];
    [button setTitleColor: FCRGB(137, 137, 137) forState: UIControlStateHighlighted];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitleEdgeInsets: UIEdgeInsetsMake(0, 25 , 0, 0)];
    button.titleLabel.font = [UIFont systemFontOfSize: 12 ];
    UIImageView *districtImageView = [[UIImageView alloc] initWithImage: arrowImage];
    [button addSubview: districtImageView];
    [districtImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(button);
        make.right.equalTo(button).with.offset(-12 );
        make.size.mas_equalTo(CGSizeMake( arrowImage.size.width,  arrowImage.size.height));
    }];
    return button;
}



+ (UIButton *)createBtnWithImage:(UIImage *)image
{
    return [self createBtnWithNormalImage: image selectedImage: image];
}
+ (UIButton *)createBtnWithImage:(UIImage *)image selectedImage:(UIImage *)sImage
{
	    return [self createBtnWithNormalImage: image selectedImage: sImage];
}
+ (UIButton *)createBtnWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage: normalImage forState: UIControlStateNormal];
    [button setImage: selectedImage forState: UIControlStateSelected];
    return button;
}

+ (UIView *)createLineView
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor: FCRGB(210, 210, 210)];
    return view;
}

+ (UITextView *)createTextViewWithPlaceholder:(NSString *)text font:(UIFont *)font backgroundColor:(UIColor *)color cornerRadius:(CGFloat)radius textColor:(UIColor *)textColor
{
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = color;
    textView.layer.cornerRadius = radius;
    textView.layer.masksToBounds = YES;
    textView.font = font;
    textView.textColor = textColor;
    // _placeholderLabel
    UILabel *placeHolderLabel = [self createLabelWithText: text size: 15  alignment: NSTextAlignmentLeft textColor: FCRGB(137, 137, 137)];
    placeHolderLabel.font = font;
    placeHolderLabel.numberOfLines = 0;
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    return textView;
}
@end
