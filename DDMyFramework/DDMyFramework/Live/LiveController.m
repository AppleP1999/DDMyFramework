//
//  LiveController.m
//  Video01
//
//  Created by Higgses on 2018/2/6.
//  Copyright © 2018年 Higgses. All rights reserved.
//

#import "LiveController.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>
#define kHeight(h) ([UIScreen mainScreen].bounds.size.height / 667.0 * h)
#define kWidth(w) ([UIScreen mainScreen].bounds.size.width / 375.0 * w)
#import <AFNetworking/AFNetworking.h>
//#import <TMSDK/TMHttpUserInstance.h>
//#import <TMSDK/TMEngineConfig.h>
//#import <TMSDK/TMSDK.h>
//#define DDWS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#import "CreateLiveConfModel.h"
@interface LiveController ()<PLMediaStreamingSessionDelegate>
@property (nonatomic, strong) PLMediaStreamingSession *session;
@property (nonatomic, strong) UIButton *qiehuan;
@property (nonatomic, strong) UIButton *endLive;
@property (nonatomic, strong) UIButton *removeLive;
@end

@implementation LiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [PLStreamingEnv initEnv];
 
    _endLive = [UIButton buttonWithType:UIButtonTypeCustom];
    [_endLive setFrame:CGRectMake(kWidth(160), kHeight(531), kWidth(55), kHeight(55))];
//    [_endLive setTitle:@"结束直播" forState:UIControlStateNormal];
    
    [_endLive setImage:[UIImage imageNamed:@"image.bundle/停止"] forState:UIControlStateNormal];
//    [_endLive addTarget:self action:@selector(endLive) forControlEvents:UIControlEventTouchUpInside];
    [_endLive addTarget:self action:@selector(Action_removeView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_endLive];
    
    
    _removeLive = [UIButton buttonWithType:UIButtonTypeCustom];
    [_removeLive setFrame:CGRectMake(kWidth(15), kHeight(20), kWidth(20), kHeight(20))];
//    [_removeLive setTitle:@"关闭页面" forState:UIControlStateNormal];
    [_removeLive setImage:[UIImage imageNamed:@"image.bundle/关闭"] forState:UIControlStateNormal];
    
    [_removeLive addTarget:self action:@selector(Action_removeView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_removeLive];
    
    
    _qiehuan = [UIButton buttonWithType:UIButtonTypeCustom];
    [_qiehuan setFrame:CGRectMake(kWidth(334.5), kHeight(19.5), kWidth(25.5), kHeight(21))];
//    [_qiehuan setTitle:@"切" forState:UIControlStateNormal];
    [_qiehuan setImage:[UIImage imageNamed:@"image.bundle/相机翻转"] forState:UIControlStateNormal];
    
    [_qiehuan addTarget:self action:@selector(qianhou) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_qiehuan];
    DDWS(ws);
//    DDWS(ws);
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL videoGranted) {
//        NSLog(@"%@",videoGranted ? @"相机准许":@"相机不准许");
        if (videoGranted)
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL audioGranted) {
                //                NSLog(@"%@",audioGranted ? @"麦克风准许":@"麦克风不准许");
                if (audioGranted)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [ws initPlMediaStreaming];
                        [ws beginLive];
                    });
                }
                else
                    [ws showAlertViewWithTitle:@"提示" withMessage:@"未能获取麦克风权限" isAlert:YES withTextList:@[@"退出"] withHandlerList:@[^(UIAlertAction *action) {
                        [ws dismissViewControllerAnimated:YES completion:nil];
                    }]];
            }];
        }
        else
        {
            [ws showAlertViewWithTitle:@"提示" withMessage:@"未能获取摄像机权限" isAlert:YES withTextList:@[@"退出"] withHandlerList:@[^(UIAlertAction *action) {
                [ws dismissViewControllerAnimated:YES completion:nil];
            }]];
        }
    }];
}

- (void)initPlMediaStreaming
{
    PLVideoCaptureConfiguration *videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
    PLAudioCaptureConfiguration *audioCaptureConfiguration = [PLAudioCaptureConfiguration defaultConfiguration];
    PLVideoStreamingConfiguration *videoStreamingConfiguration = [PLVideoStreamingConfiguration defaultConfiguration];
    PLAudioStreamingConfiguration *audioStreamingConfiguration = [PLAudioStreamingConfiguration defaultConfiguration];
    
    self.session = [[PLMediaStreamingSession alloc] initWithVideoCaptureConfiguration:videoCaptureConfiguration audioCaptureConfiguration:audioCaptureConfiguration videoStreamingConfiguration:videoStreamingConfiguration audioStreamingConfiguration:audioStreamingConfiguration stream:nil];
    self.session.delegate = self;
    [self.view insertSubview:self.session.previewView belowSubview:_endLive];
}

- (void)beginLive {
    DDWS(ws);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = [NSDictionary dictionary];
        dic = @{
            @"user_id" :@(CreateLiveConfModel.sharedManager.member_id),
            @"live_id" : _liveId,
            @"status" : @1
            };
    NSLog(@"liveId:%@", _liveId);
    
    // 请求参数类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", @"multipart/form-data", @"image/png",nil ];
    [manager POST:[NSString stringWithFormat:@"%@/videoa01/api/liveonoff",CreateLiveConfModel.sharedManager.domain] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
    {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ws.session startStreamingWithPushURL:[NSURL URLWithString:ws.pushUrl] feedback:^(PLStreamStartStateFeedback feedback) {
            
//            dispatch_async(dispatch_get_main_queue(), ^{
//
                if (feedback == PLStreamStartStateSuccess) {
                    [ws showAlertWithTitle:@"直播" withMessage:@"开始直播"];
                }
                else {
                    [ws showAlertWithTitle:@"开始直播失败 " withMessage:DDFORMAT(@"错误码:%ld",feedback)];
                }
//            });
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
//        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
//
//        NSLog(@"error--%@  %@",[[serializedData objectForKey:@"data"] objectForKey:@"message"], serializedData);
        
        [ws dismissViewControllerAnimated:YES completion:nil];
    }];
}


//结束直播

- (void)aciton_end{
    DDWS(ws);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{
            @"user_id" : @(CreateLiveConfModel.sharedManager.member_id),
            @"live_id" : _liveId,
            @"status" : @2
            };
    
    
    // 请求参数类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", @"multipart/form-data", @"image/png",nil ];
    
    
    [manager POST:[NSString stringWithFormat:@"%@videoa01/api/liveonoff",CreateLiveConfModel.sharedManager.domain] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [ws showAlertWithTitle:@"结束直播" withMessage:@"确定结束直播吗？" handler:^(UIAlertAction *action) {
            [ws.session stopStreaming];
            [ws dismissViewControllerAnimated:YES completion:nil];
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
//        
//        NSLog(@"error--%@  %@",[[serializedData objectForKey:@"data"] objectForKey:@"message"], serializedData);
    }];
}

- (void)Action_removeView {
    DDWS(ws);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{
            @"user_id" : @(CreateLiveConfModel.sharedManager.member_id),
            @"live_id" : _liveId,
            @"status" : @2
            };
    
    // 请求参数类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", @"multipart/form-data", @"image/png",nil ];
    [manager POST:[NSString stringWithFormat:@"%@/videoa01/api/liveonoff",CreateLiveConfModel.sharedManager.domain] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ws showAlertWithTitle:@"结束直播" withMessage:@"确定结束直播吗？" handler:^(UIAlertAction *action) {
            [ws.session stopStreaming];
            [ws dismissViewControllerAnimated:YES completion:nil];
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
//        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
//        NSLog(@"error--%@  %@",[[serializedData objectForKey:@"data"] objectForKey:@"message"], serializedData);
    }];
}

- (void)qianhou {
    [self.session toggleCamera];
}


- (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message{
    [self showAlertViewWithTitle:title withMessage:message isAlert:YES withTextList:@[@"确定"] withHandlerList:@[^(UIAlertAction *action){}] withStyleList:nil];
}

- (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message handler:(void (^)(UIAlertAction *))handler{
    
    [self showAlertViewWithTitle:title withMessage:message isAlert:YES withTextList:@[@"确定",@"取消"] withHandlerList:@[handler,^(UIAlertAction *action){}] withStyleList:nil];
}

- (void)showAlertViewWithTitle:(NSString *)title withMessage:(NSString *)message isAlert:(BOOL)isAlert withTextList:(NSArray<NSString *> *)textList withHandlerList:(NSArray<void (^)(UIAlertAction *)> *)handlerList{
    
    [self showAlertViewWithTitle:title withMessage:message isAlert:isAlert withTextList:textList withHandlerList:handlerList withStyleList:nil];
}

- (void)showAlertViewWithTitle:(NSString *)title withMessage:(NSString *)message isAlert:(BOOL)isAlert withTextList:(NSArray<NSString *> *)textList withHandlerList:(NSArray<void (^)(UIAlertAction *)> *)handlerList withStyleList:(NSArray *)styleList{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:isAlert?UIAlertControllerStyleAlert:UIAlertControllerStyleActionSheet];
    
    for (int i=0; i<textList.count; i++) {
        UIAlertAction *theAction = [UIAlertAction actionWithTitle:textList[i] style:styleList?[styleList[i] integerValue]:([textList[i] isEqual:@"取消"]?UIAlertActionStyleCancel:UIAlertActionStyleDefault) handler:handlerList[i]];
        [alertController addAction:theAction];
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - -- PLMediaStreamingSessiondelegate

- (void)mediaStreamingSession:(PLMediaStreamingSession *)session didDisconnectWithError:(NSError *)error
{
    DDWS(ws);
    [self showAlertViewWithTitle:@"提示" withMessage:@"网络问题，已停止推流，时候继续推流？" isAlert:YES withTextList:@[@"继续",@"退出"] withHandlerList:@[^(UIAlertAction *action){
        [ws.session restartStreamingWithPushURL:[NSURL URLWithString:ws.pushUrl] feedback:^(PLStreamStartStateFeedback feedback) {
            if (feedback == PLStreamStartStateSuccess) {
                [ws showAlertWithTitle:@"直播" withMessage:@"开始直播"];
            }
            else {
                [ws showAlertWithTitle:@"开始直播失败 " withMessage:DDFORMAT(@"错误码:%ld",feedback)];
            }
        }];
    },^(UIAlertAction *action){
        [ws aciton_end];
    }] withStyleList:nil];
}

//- (void)mediaStreamingSession:(PLMediaStreamingSession *)session didGetCameraAuthorizationStatus:(PLAuthorizationStatus)status
//{
//    DDWS(ws);
//    [self.session startStreamingWithPushURL:[NSURL URLWithString:ws.pushUrl] feedback:^(PLStreamStartStateFeedback feedback) {
//        if (feedback == PLStreamStartStateSuccess) {
//            [ws showAlertWithTitle:@"直播" withMessage:@"开始直播"];
//        }
//        else {
//            [ws showAlertWithTitle:@"开始直播失败 " withMessage:DDFORMAT(@"错误码:%ld",feedback)];
//        }
//    }];
//}
//
//- (void)mediaStreamingSession:(PLMediaStreamingSession *)session didGetMicrophoneAuthorizationStatus:(PLAuthorizationStatus)status
//{
//    [self.session restartStreamingWithPushURL:<#(NSURL *)#> feedback:<#^(PLStreamStartStateFeedback feedback)handler#>]
//    DDWS(ws);
//    [self.session startStreamingWithPushURL:[NSURL URLWithString:ws.pushUrl] feedback:^(PLStreamStartStateFeedback feedback) {
//        if (feedback == PLStreamStartStateSuccess) {
//            [ws showAlertWithTitle:@"直播" withMessage:@"开始直播"];
//        }
//        else {
//            [ws showAlertWithTitle:@"开始直播失败 " withMessage:DDFORMAT(@"错误码:%ld",feedback)];
//        }
//    }];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
