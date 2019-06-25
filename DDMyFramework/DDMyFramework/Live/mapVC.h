//
//  mapVC.h
//  Video01
//
//  Created by Higgses on 2018/3/15.
//  Copyright © 2018年 Higgses. All rights reserved.
//

#import <TMSDK/Cordova.h>
typedef void (^ReturnValueBlock) (NSDictionary *strValue);
@interface mapVC : TMViewController
@property (nonatomic, strong)NSString *string;
@property(nonatomic, copy) ReturnValueBlock returnValueBlock;
@end
