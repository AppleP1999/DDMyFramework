//
//  ToolsI002CategoryModel.m
//  DDMyFramework
//
//  Created by omni－appple on 2019/4/11.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import "ToolsI002CategoryModel.h"

@implementation ToolsI002CategoryModel
+ (instancetype)categoryWithDict:(NSDictionary *)dict
{
    ToolsI002CategoryModel *c = [[self alloc] init];
    [c setValuesForKeysWithDictionary:dict];
    return c;
}
@end
