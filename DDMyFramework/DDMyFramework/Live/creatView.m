//
//  creatView.m
//  VideoA01
//
//  Created by Higgses on 2018/1/19.
//  Copyright © 2018年 Higgses. All rights reserved.
//

#import "creatView.h"

#import <Masonry/Masonry.h>
#define kHeight(h) ([UIScreen mainScreen].bounds.size.height / 667.0 * h)
#define kWidth(w) ([UIScreen mainScreen].bounds.size.width / 375.0 * w)


@interface creatView()

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;





@end


@implementation creatView

- (instancetype)initWithText:(NSString *)text titleText:(NSString *)titleText image:(NSString *)image
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageName = image;
        _text = text;
        _titleText = titleText;
        
        [self creat];
    }
    return self;
}

- (void)showBottomList{
    
    [self.delegate showClassificationList:_titleText];
    
}


- (void)creat {
    _icon = [[UIImageView alloc]init];
    _title = [[UILabel alloc]init];
    _title.text = _titleText;
    _title.font = [UIFont systemFontOfSize:15.0];
    [_title setTextColor:[UIColor colorWithRed:118/255.0 green:118/255.0 blue:118/255.0 alpha:1.0]];
    [_icon setImage:[UIImage imageNamed:_imageName]];
    
    
    [self addSubview:_icon];
    [self addSubview:_title];
    
    if ([_titleText isEqualToString:@"直播分类"] || [_titleText isEqualToString:@"开始时间"]||[_titleText isEqualToString:@"结束时间"]) {
        _clickLabel = [[UILabel alloc]init];
        [_clickLabel setFont:[UIFont systemFontOfSize:13.0]];
        _clickLabel.text = _text;
        _clickLabel.userInteractionEnabled = YES;
        [_clickLabel setTextColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBottomList)];
        
        [self addGestureRecognizer:tap];
        [self addSubview:_clickLabel];
    } else {
        _textField = [[UITextField alloc]init];
        _textField.placeholder = _text;
        //    _textField.delegate = self;
        [_textField setValue:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        
        [_textField setFont:[UIFont systemFontOfSize:13.0]];
        [_textField setTextColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0]];
        [_textField setValue:[UIFont systemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
        
        
        [self addSubview:_textField];
    }
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if ([_titleText isEqualToString:@"直播简介"]) {
            make.top.equalTo(self.mas_top).offset(kHeight(19));
        }else {
            make.centerY.equalTo(self);
        }
        make.left.equalTo(self.mas_left).offset(kWidth(15));
        make.width.mas_equalTo(kWidth(16));
        make.height.mas_equalTo(kHeight(13.5));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_icon);
        make.width.mas_equalTo(kWidth(63));
        make.height.mas_equalTo(kHeight(14.5));
        make.left.equalTo(_icon.mas_right).offset(kWidth(11.5));
    }];
    
    
    if ([_titleText isEqualToString:@"直播分类"] || [_titleText isEqualToString:@"开始时间"]||[_titleText isEqualToString:@"结束时间"] ) {
        
        [_clickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(_title);
            make.left.equalTo(_title.mas_right).offset(kWidth(9.5));
            make.height.mas_equalTo(kHeight(12.5));
            make.right.equalTo(self.mas_right).offset(kWidth(-50));
        }];
        
    }else{
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(_title);
            make.left.equalTo(_title.mas_right).offset(kWidth(9.5));
            make.height.mas_equalTo(kHeight(12.5));
            make.right.equalTo(self.mas_right).offset(kWidth(-50));
        }];
    }
}

@end

