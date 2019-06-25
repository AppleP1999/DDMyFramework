//
//  creatView.h
//  VideoA01
//
//  Created by Higgses on 2018/1/19.
//  Copyright © 2018年 Higgses. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol creatViewDelegate <NSObject>

- (void)showClassificationList:(NSString *)text;

@end

@interface creatView : UIView
- (instancetype)initWithText:(NSString *)text titleText:(NSString *)titleText image:(NSString *)image;


@property (nonatomic, strong) UILabel *clickLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign)id<creatViewDelegate> delegate;

@end

