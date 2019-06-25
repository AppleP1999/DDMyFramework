//
//  FCCycleView.h
//  TBCycleProgress
//
//  Created by qianjianeng on 16/2/22.
//  Copyright © 2019年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCCycleView : UIView

@property (nonatomic, strong) UILabel *label;

- (void)drawProgress:(CGFloat )progress;

@end
