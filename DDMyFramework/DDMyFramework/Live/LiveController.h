//
//  LiveController.h
//  Video01
//
//  Created by Higgses on 2018/2/6.
//  Copyright © 2018年 Higgses. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveController : UIViewController

@property (nonatomic, copy)NSString *pushUrl;
@property (nonatomic, copy)NSString *liveId;
@property (nonatomic, assign) NSInteger status;

@end
