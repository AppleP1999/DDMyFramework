//
//  GACategoryCell.m
//  DDMyFramework
//
//  Created by omni－appple on 2019/4/12.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import "GACategoryCell.h"

@implementation GACategoryCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}
-(UIView *)leftView {
	if (!_leftView ) {
     _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 98)];
     _leftView.backgroundColor = [UIColor whiteColor];
     [self.contentView addSubview:_leftView];
	}
	return _leftView;
}
  
  
-  (void)load_ui{
   
}
 
 

@end
