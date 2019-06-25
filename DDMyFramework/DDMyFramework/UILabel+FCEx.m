//
//  UILabel+FCEx.m
//  DDMyFramework
//
//  Created by omni－appple on 2019/4/30.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import "UILabel+FCEx.h"

@implementation UILabel (FCEx)

-(void)attributedWithImg:(UIImage *)img ImgBounds:(CGRect)imgbounds size:(CGFloat)size  textColor:(UIColor*)tectColor
{
	if (!self.text) {
		self.text = @"";
	}
	NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: self.text];
	  [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, self.text.length)];
	  [attri addAttribute:NSForegroundColorAttributeName value:tectColor range:NSMakeRange(0, self.text.length)];
	  [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:NSMakeRange(0, self.text.length)];
	 NSTextAttachment * chment = [[NSTextAttachment alloc] init];
	 chment.image = img;
	 chment.bounds = imgbounds ; 
	 NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:chment];
	 [attri insertAttributedString:string atIndex:0];
	 self.attributedText = attri;
 
}
@end
