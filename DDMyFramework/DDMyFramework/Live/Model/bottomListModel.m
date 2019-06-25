//
//  bottomListModel.m
//  Video01
//
//  Created by Higgses on 2018/2/7.
//  Copyright © 2018年 Higgses. All rights reserved.
//

#import "bottomListModel.h"

@implementation bottomListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [BottomListData class],
             
             };
}

@end

@implementation BottomListData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cateid" : @"id"
             };
}


@end
