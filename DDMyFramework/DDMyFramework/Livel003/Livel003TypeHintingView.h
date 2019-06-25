//
//  Livel003TypeHintingView.h
//  LiveI003
//
//  Created by omni－appple on 2019/5/14.
//  Copyright © 2019年 ZhouYou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, Livel003HintingImgType) {
		Livel003HintingTypeDefault = 0,
		Livel003HintingTypeVideo,
		Livel003HintingTypeLive,
		/** 专题*/
		Livel003HintingTypeProject,
		/** 图集*/
		Livel003HintingTypeAtlas,
		
			
};
@interface Livel003TypeHintingView : UIView
@property (nonatomic, weak)  UILabel * lab_typeName;
@property(nonatomic,assign) Livel003HintingImgType type;
@end
