//
//  FCDataTool.h
//  DJBaseKit
//
//  Created by omni－appple on 2019/5/9.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCDataTool : NSObject
/**
 字典转Json字符串
 
 @param infoDict 字典数据
 @return Json字符串
 */
+ (NSString *)convertToJSONData:(id)infoDict;

/**
 JSON字符串转化为字典
 
 @param jsonString Json字符串
 @return 字典数据
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
