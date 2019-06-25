//
//  FCButtonItem.h
//  Shibui
//
//  Created by Jiva DeVoe on 1/12/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCButtonItem : NSObject
{
//    NSString *label;
//    void (^action)();
}
@property (strong, nonatomic) NSString *label;
@property (copy, nonatomic) void (^action)(void);
+(id)item;
+(id)itemWithLabel:(NSString *)inLabel;
+(id)itemWithLabel:(NSString *)inLabel action:(void(^)(void))action;
@end

