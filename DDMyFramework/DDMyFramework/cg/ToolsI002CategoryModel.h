//
//  ToolsI002CategoryModel.h
//  DDMyFramework
//
//  Created by omni－appple on 2019/4/11.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolsI002CategoryModel : NSObject
/** 子类别 */
@property (nonatomic, strong) NSArray *subcategories;
/** 姓名 */
@property (nonatomic, strong) NSString *name;
/** 图标 */
@property (nonatomic, strong) NSString *icon;
/** 高亮图标 */
@property (nonatomic, strong) NSString *highlighted_icon;

+ (instancetype)categoryWithDict:(NSDictionary *)dict;
@end
