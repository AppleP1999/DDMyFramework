//
//  Livel003VideoCollectionView.m
//  DDMyFramework
//
//  Created by omni－appple on 2019/5/13.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//
#import "Livel003VideoCollectionCell.h"
#import "Livel003VideoCollectionView.h"
#import <Masonry/Masonry.h>
@interface Livel003VideoCollectionView  ()<UICollectionViewDelegate, UICollectionViewDataSource>
//@property (nonatomic, strong)  UICollectionView * collectionView;
@property(nonatomic,assign)BOOL isHorizontal;
@end
@implementation Livel003VideoCollectionView

+ (instancetype)itmeWithisHorizontal:(BOOL) horizontal {
	Livel003VideoCollectionView * v =  [[Livel003VideoCollectionView  alloc] init];
	v.isHorizontal = horizontal;
	return v;
}
- (instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}
-(void)layoutSubviews{
	 [super layoutSubviews];
 
	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self);
	}];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//        CGFloat with = TMSCREEN_WITH/2-15*2-8 ; 
//        layout.itemSize = CGSizeMake(with ,with);//每项的大小
     	//设置每一行的间距
    	layout.minimumLineSpacing = 0;
//    	//设置item的间距
    	layout.minimumInteritemSpacing = 0;
//    	//设置section的边距
//    	layout.sectionInset = UIEdgeInsetsMake(8, 0, 8, 0);
        //(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
        layout.sectionInset = UIEdgeInsetsMake(0, 8,0, 8); //设置每组的cell的边界
        CGFloat with = (UIScreen.mainScreen.bounds.size.width-24)/2  ;
         layout.itemSize = CGSizeMake(with , 170);
         if (self.isHorizontal) {
    	 layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		 layout.minimumLineSpacing = 8;

		}
        _collectionView = [[UICollectionView alloc]initWithFrame: self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.mjDelegate= self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[Livel003VideoCollectionCell class] forCellWithReuseIdentifier:@"Livel003VideoCollectionCell"];//注册CELL
     
    }
    return _collectionView;
}
//定义展示的UICollectionViewCell的个数 
 -(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section  
{  
    return 14;  
}   
//定义展示的Section的个数  
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView  
{  
    return 1;  
}    
//每个UICollectionView展示的内容  
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  
{  
    static NSString * CellIdentifier = @"Livel003VideoCollectionCell";  
    Livel003VideoCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];  
  	if (self.isHorizontal) {
    cell.lab_date.hidden = YES;
    cell.lab_content.numberOfLines = 1;
	}
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];  
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
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath  
//{  
//
////	     collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 4,0, 4); //设置每组的cell的边界
//        CGFloat with = (UIScreen.mainScreen.bounds.size.width-24)/2  ;
//         
//     return   CGSizeMake(with,170);
////    return CGSizeMake(with, with);  
//} 
//Header   高度
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return  CGSizeMake(.1,.1);
//}
// 头部view  设置 
// - (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
////    MatrixI003CvReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
////	headerView.lab_title.text = @"政务号";
////	headerView.viewModel = self.viewModel;
//	
//    return   [UICollectionReusableView new];
//} 

 
@end
