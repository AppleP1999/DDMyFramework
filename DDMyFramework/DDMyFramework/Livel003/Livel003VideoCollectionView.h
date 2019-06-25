//
//  Livel003VideoCollectionView.h
//  DDMyFramework
//
//  Created by omni－appple on 2019/5/13.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//  基于CollectionView 横向滚动   与 常规规定    

#import <UIKit/UIKit.h>

@interface Livel003VideoCollectionView : UIView
+ (instancetype)itmeWithisHorizontal:(BOOL) horizontal ;
@property (nonatomic, strong)  UICollectionView * collectionView;
@end

 
