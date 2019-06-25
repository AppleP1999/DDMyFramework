//
//  BottomListCell.m
//  Video01
//
//  Created by Higgses on 2018/2/7.
//  Copyright © 2018年 Higgses. All rights reserved.
//

#import "BottomListCell.h"
#import <Masonry/Masonry.h>
#define kHeight(h) ([UIScreen mainScreen].bounds.size.height / 667.0 * h)
#define kWidth(w) ([UIScreen mainScreen].bounds.size.width / 375.0 * w)
@implementation BottomListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creat];
    }
    return self;
}

- (void)creat {
    
    _lable = [[UILabel alloc]init];
//   [_lable setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:_lable];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_lable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(kWidth(200));
    }];
    
    _lable.textColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/225.0 alpha:1.0];
    _lable.textAlignment = NSTextAlignmentCenter;
    [_lable setFont:[UIFont systemFontOfSize:15.0]];
    
}

- (void)setLabelText:(NSString *)labelText {
    
    _lable.text = labelText;
    _labelText = labelText;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
