//
//  NewCategoryModel.m
//  music
//
//  Created by 寿煜宇 on 19/6/14.
//  Copyright © 2019年 Fyus. All rights reserved.
//

#import "NewCategoryModel.h"

@implementation NewCategoryModel


+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [NewCategoryList class]};
}
@end
@implementation NewCategoryList

@end
