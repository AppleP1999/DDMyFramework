//
//  NewsI004GYLMainView.h
//  NewsI004
//
//  Created by omni－appple on 2019/5/21.
//  Copyright © 2019年 ZhouYou. All rights reserved.
//
#import "NewsI004HomePageModel.h"
#import "NewsI004TypeHintingView.h"
#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, NewsI004GYLMainStyle) {
		/**默认图片靠右*/
		NewsI004GYLMainStyleDefault = 0,
		/**大图片风格*/
		NewsI004GYLMainStyleBigPictureView,
		/**大图片无图风格*/
		NewsI004GYLMainStyleBigPictureView_Hidden,
		/**卡片大图片风格*/
		NewsI004GYLMainStyleNews_card,
		/**卡片无图风格*/
		NewsI004GYLMainStyleNews_card_Hidden,
		/**三图风格*/
		NewsI004GYLMainStyleThreeFigure,
		/**卡片三图风格*/
		NewsI004GYLMainStyleThreeFigure_card,
		/**其他无图风格*/
		NewsI004GYLMainStyleOtherNoPic 
		 

};
@interface NewsI004GYLMainView : UIView
@property(nonatomic,weak)NewsI004TypeHintingView *view_type;

@end
