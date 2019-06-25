//
//  UIViewController+FCEmtyView.m
//  LiveI003
//
//  Created by ZhouYou on 2018/9/18.
//  Copyright © 2018年 ZhouYou. All rights reserved.
//

#import "UIViewController+FCEmtyView.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

static char UIViewEmptyView;

@implementation UIViewController (FCEmtyView)

- (UIView *)emptyView
{
    return objc_getAssociatedObject(self, &UIViewEmptyView);
}

- (void)setEmptyView:(UIView *)emptyView
{
    [self willChangeValueForKey:@"EmptyView"];
    objc_setAssociatedObject(self, &UIViewEmptyView,
                             emptyView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"EmptyView"];
}


-(void)addEmptyViewWithImageName:(NSString*)imageName title:(NSString*)title
{
    if (!self.emptyView)
    {
        UIImage* image = [UIImage imageNamed:imageName];
        NSString* text = title;
        if (!text)
            text = @"加载失败,点击重试";
        
        UIView* noMessageView = [[UIView alloc] initWithFrame:CGRectZero];
        noMessageView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:noMessageView];
        [noMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self.view);
        }];
        
        UIImageView *carImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [carImageView setImage:image];
        [noMessageView addSubview:carImageView];
        [carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
            make.center.mas_equalTo(self.view);
        }];
        
        UIButton *noInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [noInfoBtn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        [noInfoBtn setTitle:text forState:UIControlStateNormal];
        noInfoBtn.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        [noInfoBtn addTarget:self action:@selector(reloadBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        noInfoBtn.layer.cornerRadius = 3.0;
        [noMessageView addSubview:noInfoBtn];
        [noInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(carImageView.mas_bottom).offset(20);
            make.height.mas_equalTo(22);
//            make.width.mas_equalTo(200);
            make.centerX.mas_equalTo(self.view);
        }];
        
        self.emptyView = noMessageView;
    }
    [self.view bringSubviewToFront:self.emptyView];
}

- (void)showEmptyView
{
    [self addEmptyViewWithImageName:@"FCBaseKit.bundle/emptydata" title:nil];
    [UIView animateWithDuration:0.1 animations:^{
        self.emptyView.alpha = 1;
    }];
}

- (void)hiddenEmptyView
{
    [UIView animateWithDuration:0.15 animations:^{
        self.emptyView.alpha = 0;
    }];
}

- (void)reloadBtnClicked
{
    [self hiddenEmptyView];
    [self reloadViewData];
}

- (void)reloadViewData
{
    
}
@end
