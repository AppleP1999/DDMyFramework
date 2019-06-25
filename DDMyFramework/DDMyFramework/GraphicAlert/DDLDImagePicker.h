//
//  DDLDImagePicker.h
//  ImageClipTool
//
//  Created by 段乾磊 on 16/7/6.
//  Copyright © 2019年 LazyDuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum ImagePickerType
{
    ImagePickerCamera = 0,
    ImagePickerPhoto = 1
}ImagePickerType;
@class DDLDImagePicker;
@protocol DDLDImagePickerDelegate <NSObject>

- (void)imagePicker:(DDLDImagePicker *)imagePicker didFinished:(UIImage *)editedImage;
- (void)imagePickerDidCancel:(DDLDImagePicker *)imagePicker;
@end
@interface DDLDImagePicker : NSObject
+ (instancetype) sharedInstance;
//scale 裁剪框的高宽比 0~1.5 默认为1
- (void)showImagePickerWithType:(ImagePickerType)type InViewController:(UIViewController *)viewController Scale:(double)scale;
//代理
@property (nonatomic, assign) id<DDLDImagePickerDelegate> delegate;
@end
