//
//  Livel003LiveChatCell.m
//  GlobalLive
//
//  Created by Louis on 16/7/8.
//  Copyright © 2019年 GuanCloud. All rights reserved.
//

#import "Livel003LiveChatCell.h"
#import "UIView+LYAdd.h"
@interface Livel003LiveChatCell ()
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainContentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *remainContentLblWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *remainContentLblHeightConstraint;
@end

@implementation Livel003LiveChatCell

- (void)awakeFromNib {
 	[super awakeFromNib];
 
    [_nickNameLabel setLabelShadow];
    [_contentLabel setLabelShadow];
    [_remainContentLabel setLabelShadow];
	 
//	_levelLabel.text = @"送了什么";
 	_nickNameLabel.text = @"凤飞飞";
}

//- (void)setChatModel:(LYLiveChatModel *)chatModel {
//    _chatModel = chatModel;
//    
//    if (chatModel.isLiveMsg) {
//        _levelLabel.text = @"";
//    } else {
//        _levelLabel.text = @"★ 66";
//    }
//    
//    _remainContentLabel.hidden = !chatModel.isMoreLine;
//    if (chatModel.isMoreLine) {
//        _remainContentLabel.text = chatModel.secondContent;
//        _remainContentLblWidthConstraint.constant = chatModel.secondContentSize.width + 3;
//        _remainContentLblHeightConstraint.constant = chatModel.secondContentSize.height + 3;
//        [_remainContentLabel layoutIfNeeded];
//        _remainContentLabel.textColor = chatModel.contentColor;
//        _contentLabel.text = chatModel.firstContent;
//    } else {
//        _contentLabel.text = chatModel.content;
//    }
//    
//    _contentLabel.textColor = chatModel.contentColor;
//
//    _nickNameLabel.text = [NSString stringWithFormat:@"%@: ", chatModel.nickName];
//}

@end
