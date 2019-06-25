//
//  Livel003CollectionHeadView.m
//  DDMyFramework
//
//  Created by omni－appple on 2019/3/18.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//
 #import <Masonry/Masonry.h>
#import "Livel003CollectionHeadView.h"
#import "Livel003HeadCell.h"
#define kItemW  40

@interface Livel003CollectionHeadView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation Livel003CollectionHeadView 

+(instancetype) itemWithFrame:(CGRect)frame
{
	   UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//        CGFloat with = TMSCREEN_WITH/2-15*2-8 ; 
//        layout.itemSize = CGSizeMake(with ,with);//每项的大小
         //设置每一行的间距
        layout.minimumLineSpacing = 0;
        //设置item的间距
        layout.minimumInteritemSpacing = 5;
		layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;// 水平滚动

        //设置section的边距
//        layout.sectionInset = UIEdgeInsetsMake(5, 10, 0, 10);
        //(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
//        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8); //设置每组的cell的边界
      Livel003CollectionHeadView*  headView = [[Livel003CollectionHeadView alloc]initWithFrame: frame collectionViewLayout:layout];

        headView.showsVerticalScrollIndicator = NO;
        headView.showsHorizontalScrollIndicator = NO;
        return headView;
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
		self.dataSource  = self;
 		[self confCollectionView];
    }
    return self;
}
 - ( void )confCollectionView {
 
 
		self.backgroundColor = UIColor.clearColor;
//        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];  //  一定要设置
        [self registerClass:[Livel003HeadCell class] forCellWithReuseIdentifier:@"Livel003HeadCell"];//注册CELL
 
}
//定义展示的UICollectionViewCell的个数 
 -(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section  
{  
    return 16;  
}   
//定义展示的Section的个数  
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView  
{  
    return 1;  
}    
//每个UICollectionView展示的内容  
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  
{  
    static NSString * CellIdentifier = @"Livel003HeadCell";  
    Livel003HeadCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];  
 
    return cell;  
}   
#pragma mark --UICollectionViewDelegate   
//UICollectionView被选中时调用的方法  
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  
{  
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];  
    cell.backgroundColor = [UIColor whiteColor];  
} 
  
//返回这个UICollectionView是否可以被选择  
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath  
{  
    return YES;  
}  
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath  
{  
      
        //indexPath.section==0?CGSizeMake(TMSCREEN_WITH,TMSCREEN_WITH*9/16) 
     return   CGSizeMake(kItemW,kItemW);
//    return CGSizeMake(with, with);  
} 
//Header   高度
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return  CGSizeMake(100, 50);
//}
// 头部view  设置 
// - (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//
//	    UICollectionReusableView *firstView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//    firstView.backgroundColor = UIColor.clearColor;
// 
////	UICollectionReusableView * firstView  = [[UICollectionReusableView alloc] init];
//	firstView.backgroundColor = UIColor.clearColor;
//	UIView * bgView = [[UIView alloc] init];
//	bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//	UIImageView * img_pic = [[UIImageView alloc] init];
//	img_pic.layer.cornerRadius = 25;
//	img_pic.layer.masksToBounds = YES;
//	UIButton * btn = [[UIButton alloc] init];
//	[btn setBackgroundColor:UIColor.redColor ];
//	[btn setTitle:@"关注" forState:0];
//	[bgView addSubview:img_pic];
//	[bgView addSubview:btn];
//	[firstView addSubview:bgView];
//	
//	 [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//			  make.edges.equalTo(firstView);
//	  }];
//		
//	 [img_pic mas_makeConstraints:^(MASConstraintMaker *make) {
//			  make.size.mas_equalTo(CGSizeMake(kItemW, kItemW));
//			  make.left.top.equalTo(bgView);
//	  }];
//	[btn mas_makeConstraints:^(MASConstraintMaker *make) {
//			  make.size.mas_equalTo(CGSizeMake(60, 30));
//			  make.centerY.equalTo(bgView);
//			  make.right.equalTo(@-10);
//	  }];
//	 [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//			  make.height.equalTo(@40);
//			  make.left.equalTo(@8);
//			  make.right.equalTo(@-8);
//			  make.centerY.equalTo(firstView);
//			 	
//	  }];
//    return   firstView;
//} 


@end
