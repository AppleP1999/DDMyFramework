//
//  FCTableViewCell.m
//  ShoppingGuide
//
//  Created by dengjie on 2017/2/22.
//  Copyright © 2017年 com.business.facedaogou. All rights reserved.
//

#import "FCTableViewCell.h"

@implementation FCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self uc_setupViews];
        [self uc_bindViewModel];
    }
    return self;
}

- (void)uc_setupViews {}

- (void)uc_bindViewModel {}

@end
