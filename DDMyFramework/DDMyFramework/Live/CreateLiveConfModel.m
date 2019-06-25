//
//  CreateLiveConfModel.m
//  DDMyFramework
//
//  Created by omni－appple on 2019/2/22.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import "CreateLiveConfModel.h"

@implementation CreateLiveConfModel
 
+ (instancetype)sharedManager   {
 		static CreateLiveConfModel *sharedAccountManagerInstance = nil;  
        static dispatch_once_t predicate;  
        dispatch_once(&predicate, ^{  
                sharedAccountManagerInstance = [[self alloc] init];   
        });  
    return sharedAccountManagerInstance;  
}
@end
