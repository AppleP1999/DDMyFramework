//
//  Livel003HeadCell.m
//  DDMyFramework
//
//  Created by omni－appple on 2019/3/18.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import "Livel003HeadCell.h"
#import <Masonry/Masonry.h>
@interface Livel003HeadCell ()
@property(nonatomic,weak)UIImageView * bg_imgView ;
@end
@implementation Livel003HeadCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
	   self.contentView.backgroundColor = UIColor.clearColor;
        UIImageView * bg_imgView = [[UIImageView  alloc] init];
        bg_imgView.layer.cornerRadius = frame.size.width/2; 
        bg_imgView.layer.masksToBounds = YES;
        [self.contentView addSubview:bg_imgView];
        self.bg_imgView = bg_imgView;
        [self.bg_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.equalTo(self.contentView);
		}];
		[self testFunc];
    }
    return self;
}
- (void)testFunc{
	 _bg_imgView.backgroundColor = UIColor.redColor;
}

@end
