//
//  NewsI004DjSearchVC.h
//  NewsI004
//
//  Created by omni－appple on 2018/9/27.
//  Copyright © 2018年 ZhouYou. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <TMSDK/TMSDK.h>
#import "NewsI004MainModel.h"
@interface NewsI004DjSearchVC : TMViewController
@property(nonatomic,assign)NSInteger plate_id;
@property (nonatomic, strong)  NewsI004MainData * data;
 
@end
