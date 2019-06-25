//
//  CreatViewController.m
//  VideoA01
//
//  Created by Higgses on 2018/1/19.
//  Copyright © 2018年 Higgses. All rights reserved.
//
#import "CreatViewController.h"
#import "creatView.h"
#import <Masonry/Masonry.h>
#define kHeight(h) ([UIScreen mainScreen].bounds.size.height / 667.0 * h)
#define kWidth(w) ([UIScreen mainScreen].bounds.size.width / 375.0 * w)
#import <AFNetworking/AFNetworking.h>
#import "bottomListModel.h"
#import "YYModel.h"
#import "BottomListCell.h"
//#import <TMSDK/TMHttpUserInstance.h>
//#import <TMSDK/TMEngineConfig.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <MapKit/MapKit.h>
#import "mapVC.h"
#import "LDImagePicker.h"
#import "CreateLiveConfModel.h"
#import "CreateLiveHeader.h"
//#import <SetI001/SetI001ConfigInstance.h>

@interface CreatViewController () <UIImagePickerControllerDelegate, LDImagePickerDelegate,UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,CLLocationManagerDelegate,UITextViewDelegate>
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong)UIButton *creatLivebt;
@property (nonatomic, strong)UIView *blackV;
@property (nonatomic, strong) UITableView *bottomList;
@property (nonatomic, strong) UIScrollView *backScroll;
//@property (nonatomic, assign) NSInteger roomID;
@property (nonatomic, copy)NSString *beginTime;
@property (nonatomic, copy)NSString *endTime;
@property (nonatomic, strong)UIAlertController *alertVC;
@property (nonatomic, strong)UIView *backListView;
@property (nonatomic, copy)NSString *cateId;
@property (nonatomic, assign) CGFloat longitude;//当前经度
@property (nonatomic, assign) CGFloat latitude;//当前纬度
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *datePickerBackView;
@property (strong,nonatomic) CLLocationManager* locationManager;
@property (nonatomic, strong) NSString *updataDateStr;
@property BOOL keyboardVisiable;

@property (nonatomic, strong) bottomListModel *bottomModel;
@property (nonatomic, assign) BOOL isend;
@property (nonatomic, strong) NSString *dateStr;
@property (nonatomic, strong) NSString *addressStr;


///------------------------------------//////////
@property (nonatomic, strong)UITableView *craetTableView;
//直播分类
@property (nonatomic, strong)UITextField *classtyTF;
//直播标题
@property (nonatomic, strong)UITextField *liveTitleTF;
//直播简介
@property (nonatomic, strong)UITextView *introductionTV;
//开始时间
@property (nonatomic, strong)UITextField *startTimeTF;
//结束时间
@property (nonatomic, strong)UITextField *endTimeTF;
//直播地址
@property (nonatomic, strong)UITextField *liveAddressTF;
//tableViewfootView
@property (nonatomic, strong)UIView *footView;


//是否夜间模式
@property (nonatomic, assign)BOOL isNight;
@property(nonatomic,copy)NSString * member_id;
@property(nonatomic,copy)NSString * siteCode;
@end


@implementation CreatViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"创建直播";
   
}

- (bottomListModel *)bottomModel {
    if(!_bottomModel) {
        
        _bottomModel = [[bottomListModel alloc]init];
    }
    return _bottomModel;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.isNight = [SetI001ConfigInstance instance].nightModel;
    self.view.backgroundColor = [UIColor whiteColor];
    self.isend = NO;
    [self.view addSubview:self.craetTableView];
    [self startLocation];
    
    
 
    
}
-(void)startLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100.0f;
//    if ([[[UIDevicecurrentDevice]systemVersion]doubleValue] >8.0){
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//    if ([[UIDevicecurrentDevice].systemVersionfloatValue] >= 8.0) {
//        _locationManager.allowsBackgroundLocationUpdates =YES;
//    }
    [self.locationManager startUpdatingLocation];
    
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
            
        casekCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }break;
        default:break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    
    
    CLLocation *newLocation = locations[0];
    
    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
    
    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    self.longitude = oldCoordinate.longitude;
    self.latitude = oldCoordinate.latitude;
    
    
    [manager stopUpdatingLocation];
    
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    DDWS(ws);
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> *_Nullable placemarks, NSError * _Nullable error) {
        
        
        
        for (CLPlacemark *place in placemarks) {
            
            NSLog(@"name,%@",place.name);                      // 位置名
            
            NSLog(@"thoroughfare,%@",place.thoroughfare);      // 街道
            
            NSLog(@"subThoroughfare,%@",place.subThoroughfare);// 子街道
            
            NSLog(@"locality,%@",place.locality);              // 市
            
            NSLog(@"subLocality,%@",place.subLocality);        // 区
            
            NSLog(@"country,%@",place.country);                // 国家
//            if ([JudgeIDAndBankCardisEmptyOrNull:_gpsCityName]) {
//                _gpsCityName=@"定位失败";
//            }
//            WRITE_DATA(place.locality,@"CITY_JC_NAME");
//            [self.mytableviewreloadData];
            ws.addressStr = [NSString stringWithFormat:@"%@%@%@%@",place.locality,place.subLocality,place.thoroughfare,place.name];
            ws.liveAddressTF.text = ws.addressStr;
        }
        
    }];
}

//创建直播
- (void)creatLive:(UIButton *)sender
{
    DDWS(ws);
    [sender setBackgroundColor:[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0]];
    sender.userInteractionEnabled = NO;
    
    //                    NSLog(@"创建房间成功 %@", resultModel.params);
    
//    _roomID = [[resultModel.params objectForKey:@"roomId"] integerValue];
         
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSData *dataObj = [[NSData alloc]init];
        if (self.img) {
            dataObj = UIImageJPEGRepresentation(self.img, 0.3);
        }
        NSString *imageString = [dataObj base64EncodedStringWithOptions:0];
        NSDictionary *dic = [NSDictionary dictionary];
    /*
        dic = @{
                @"category_id" : _cateId,
                @"user_id" : @( CreateLiveConfModel.sharedManager.member_id),
                @"channel_id" :  CreateLiveConfModel.sharedManager.siteCode,
                @"title" : self.liveTitleTF.text,
                @"summary": self.introductionTV.text,
                @"start_time" : _beginTime,
                @"end_time" : _endTime,
                @"fm_img": dataObj,
                @"push_url" : model.inputStreamUrl,
                @"live_url": [NSString stringWithFormat:@"%@,%@,%@",outModel.rtmp,outModel.flv,outModel.m3u8],
                @"room_id" : [NSString stringWithFormat:@"%ld", (long)_roomID],
                @"longitude" : @(self.longitude),
                @"latitude" : @(self.latitude),
                @"address" : self.addressStr
                };
        */
    dic = @{    
            @"category_id" : _cateId?:@"",
            @"user_id" : @( CreateLiveConfModel.sharedManager.member_id),
            @"channel_id" :  CreateLiveConfModel.sharedManager.siteCode?:@"00000000000000000000000000000000",
            @"title" : self.liveTitleTF.text,
            @"summary": self.introductionTV.text,
            @"start_time" : _beginTime?:@"",
            @"end_time" : _endTime?:@"",
            @"fm_img": dataObj,
            @"longitude" : @(self.longitude),
            @"latitude" : @(self.latitude),
            @"address" : self.addressStr?:@""
            };
        
        [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        
        
        
        // 请求参数类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", @"multipart/form-data", @"image/png",nil ];
        
         //  CreateLiveConfModel.sharedManager.domain
 
        [manager POST:[NSString stringWithFormat:@"%@/videoa01/api/createQiniuLive",  CreateLiveConfModel.sharedManager.domain] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            
            
            [formData appendPartWithFormData:dataObj
                                        name:@"fm_img"];
            [formData appendPartWithFileData:dataObj name:@"fm_img" fileName:@"img.png" mimeType:@"image/png"];
            //
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [ws.navigationController popViewControllerAnimated:YES];
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//            NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
//             
//            NSLog(@"error--%@",[[serializedData objectForKey:@"data"] objectForKey:@"message"]);
            [sender setBackgroundColor:  CreateLiveConfModel.sharedManager.themeColor];
            sender.userInteractionEnabled = YES;
        }];
}

- (void)getListData {
    
    DDWS(ws);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil];
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSString *url = [NSString stringWithFormat:@"%@/videoa01/api/livecategory?channel_id=%@&user_id=%d", CreateLiveConfModel.sharedManager.domain, CreateLiveConfModel.sharedManager.siteCode, CreateLiveConfModel.sharedManager.member_id];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
          
      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
         
          ws.bottomModel = [bottomListModel yy_modelWithJSON:responseObject];
          
          [ws.bottomList reloadData];
          
          
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          
          NSLog(@"%@", error);
          
      }];
    
}

- (void)removeBack {
    
    [self removeBottom];
}




#pragma mark -- tableViewdelegate, tableViewDataSource



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if([tableView isEqual:self.craetTableView]){
        return 10;
    }else{
        return 0.01;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([tableView isEqual:self.craetTableView]){
        return 5;
    }else{
        return 1;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([tableView isEqual:self.craetTableView]){
        if (section == 3
            ) {
            return 2;
        }else{
            return 1;
        }
    }else{
        return self.bottomModel.data.count;
    }
  
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:self.craetTableView]){
        if(indexPath.section == 2){
            return 100;
        }else{
             return 40;
        }
    }else{
         return 40;
    }
   
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:self.craetTableView]){
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"cell%ld",indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(12.5, 10, 20, 15)];
        [cell.contentView addSubview:img];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 100, 20)];
        label.font = [UIFont systemFontOfSize:13];
        [cell.contentView addSubview:label];
        if (indexPath.section == 0) {
            img.image = [UIImage imageNamed:@"image.bundle/直播分类"];
            label.text = @"直播分类";
            [cell.contentView addSubview:self.classtyTF];
        }else if (indexPath.section == 1){
            img.frame = CGRectMake(12.5, 10, 15, 20);
            img.image = [UIImage imageNamed:@"image.bundle/直播标题"];
            label.text = @"直播标题";
            [cell.contentView addSubview:self.liveTitleTF];
        }else if (indexPath.section == 2){
            img.image = [UIImage imageNamed:@"image.bundle/直播简介"];
            label.text = @"直播简介";
            [cell.contentView addSubview:self.introductionTV];
        }else if (indexPath.section == 3){
            if(indexPath.row == 0){
                img.image = [UIImage imageNamed:@"image.bundle/直播开始时间"];
                label.text = @"开始时间";
                [cell.contentView addSubview:self.startTimeTF];
            }else{
                img.image = [UIImage imageNamed:@"image.bundle/直播结束时间"];
                label.text = @"结束时间";
                [cell.contentView addSubview:self.endTimeTF];
            }
        }else{
            img.frame = CGRectMake(12.5, 10, 15, 20);
            img.image = [UIImage imageNamed:@"image.bundle/直播地址"];
            label.text = @"直播地址";
            [cell.contentView addSubview:self.liveAddressTF];
        }
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        UILabel *LB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        LB.text = self.bottomModel.data[indexPath.row].name;
        LB.font = [UIFont systemFontOfSize:13];
        [cell.contentView addSubview:LB];
        LB.textAlignment = 1;
        return cell;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDWS(ws);
        if ([tableView isEqual:self.craetTableView]) {
            if(indexPath.section == 0){
                [self getListData];
                
                _backListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 176)];
                
                [_backListView setBackgroundColor:[UIColor blackColor]];
                _backListView.alpha = 0.3;
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBack)];
                _backListView.userInteractionEnabled = YES;
                [_backListView addGestureRecognizer:tap];
                UITableView *view = [[UITableView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - 176, self.view.bounds.size.width, 176)];
                _bottomList = view;
                self.bottomList.dataSource = self;
                self.bottomList.delegate = self;
                _bottomList.separatorColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
                
                [self.view addSubview:_bottomList];
                [self.view addSubview:_backListView];
            }else if (indexPath.section == 1){
                [self.liveTitleTF becomeFirstResponder];
            }else if (indexPath.section == 2){
                
            }else if (indexPath.section == 3){
                if (indexPath.row == 0) {
                    self.isend = NO;
                    [self.view addSubview:self.datePickerBackView];
                    [self.datePickerBackView addSubview:self.datePicker];
                }else{
                    self.isend = YES;
                    [self.view addSubview:self.datePickerBackView];
                    [self.datePickerBackView addSubview:self.datePicker];
                }
            }else{
                mapVC *vc = [[mapVC alloc]init];
                vc.string = self.addressStr;
                vc.returnValueBlock = ^(NSDictionary *passedValue){
                    
                    ws.liveAddressTF.text = [passedValue objectForKey:@"address"];
                    ws.latitude = [[passedValue objectForKey:@"la"] floatValue];
                    ws.longitude = [[passedValue objectForKey:@"lo"] floatValue];
                   
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
    }else{
        self.cateId = [NSString stringWithFormat:@"%ld",self.bottomModel.data[indexPath.row].cateid];
        self.classtyTF.text = self.bottomModel.data[indexPath.row].name;
        [self removeBottom];
    }
    
    
    
   
}

//移除底部分类弹窗
- (void)removeBottom {
    
    [_bottomList setAlpha:0.0];
    [_bottomList setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width ,176)];
    [_bottomList removeFromSuperview];
    
    [_backListView setAlpha:0.0];
    [_backListView removeFromSuperview];
    _backListView = nil;
    _bottomList = nil;
  
    
}


//更换封面
- (void)chooseBackView{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
   
    DDWS(ws);
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
        imagePicker.delegate = ws;
        [imagePicker showImagePickerWithType:0 InViewController:ws Scale:0.5625];
        
    }];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
        imagePicker.delegate = ws;
        [imagePicker showImagePickerWithType:1 InViewController:ws Scale:0.5625];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
  
    
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [alertVc addAction:cancelAction];
    _alertVC = alertVc;
    [self presentViewController:_alertVC animated:YES completion:nil];
    
    
}
#pragma mark -- 实现imagePicker的代理方法
- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
    [self popoverPresentationController];
    
}

- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    
    //加在视图中
    [_headView setImage:editedImage];
    self.img = editedImage;
    
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 10;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 50;
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}



- (UIDatePicker *)datePicker{
    if (!_datePicker) {
       
       
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-300, self.view.bounds.size.width, 300)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(0,self.view.bounds.size.height-330,100, 30);
        [sureBtn addTarget:self action:@selector(action_sure:) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sureBtn setBackgroundColor:[UIColor whiteColor]];
        [self.datePickerBackView addSubview:sureBtn];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, self.view.bounds.size.height-330, self.view.bounds.size.width-200, 30)];
        view.backgroundColor = [UIColor whiteColor];
        [self.datePickerBackView addSubview:view];
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(self.view.bounds.size.width-100,self.view.bounds.size.height-330,100,30);
        [cancelBtn addTarget:self action:@selector(action_cancel:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [self.datePickerBackView addSubview:cancelBtn];
        // 设置日期选择控件的地区
        
        [_datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        
        //    [myDatePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_SC"]];
        
        //默认为当天。
        
        [_datePicker setCalendar:[NSCalendar currentCalendar]];
        
        //    设置DatePicker的时区。
        
        //    默认为设置为：[datePicker setTimeZone:[NSTimeZone defaultTimeZone]];
        
        //    设置DatePicker的日期。
        
        //    默认设置为:
        
        [_datePicker setDate:[NSDate date]];
        
        //    minimumDate设置DatePicker的允许的最小日期。
        
        //    maximumDate设置DatePicker的允许的最大日期
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDate *currentDate = [NSDate date];
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        
        [comps setDay:100000];//设置最大时间为：当前时间推后10天
        
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        
        [comps setDay:0];//设置最小时间为：当前时间
        
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        
        [_datePicker setMaximumDate:maxDate];
        
        [_datePicker setMinimumDate:minDate];
        //    设置DatePicker的倒计时间.
        //    1) 设置日期选择的模
        //    [myDatePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
        //    2) 设置倒计时的时长
        //    注意：设置倒计时时长需要在确定模式之后指定
        // 倒计时的时长，以秒为单位
        //    [myDatePicker setCountDownDuration:10 * 60];
        //显示小时，分钟和AM/PM
        //    [myDatePicker setDatePickerMode:UIDatePickerModeTime];
        //显示年月日
        //    [myDatePicker setDatePickerMode:UIDatePickerModeDate];
        //显示小时和分
        //    [myDatePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
        //监听datepicker值的改变
        [_datePicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}
- (void)dateChange:(UIDatePicker *)date

{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSDate转NSString
    self.dateStr = [dateFormatter stringFromDate:date.date];
    self.updataDateStr = [dateFormatter1 stringFromDate:date.date];
    NSLog(@"%@", self.dateStr);
    
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

- (UIView *)datePickerBackView{
    if (!_datePickerBackView) {
        _datePickerBackView = [[UIView alloc]initWithFrame:self.view.bounds];
        _datePickerBackView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView:)];
        PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
        PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
        _datePickerBackView.contentMode = UIViewContentModeScaleToFill;
        [_datePickerBackView addGestureRecognizer:PrivateLetterTap];
       
        
    }
    return _datePickerBackView;
}

- (void)action_sure:(UIButton *)sender{
    if (self.dateStr.length == 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        //设置格式：zzz表示时区
        [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //NSDate转NSString
        self.dateStr = [dateFormatter stringFromDate:[NSDate date]];
        self.updataDateStr = [dateFormatter1 stringFromDate:[NSDate date]];
    }
    if (self.isend) {
       self.endTimeTF.text = self.dateStr;
        _endTime = self.updataDateStr;
    }else{
         self.startTimeTF.text = self.dateStr;
        _beginTime = self.updataDateStr;
    }
    [self.datePickerBackView removeFromSuperview];
}

- (void)action_cancel:(UIButton *)sender{
     [self.datePickerBackView removeFromSuperview];
    
}
- (void)tapAvatarView: (UITapGestureRecognizer *)gesture{
    
    [self.datePickerBackView removeFromSuperview];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}


#pragma mark -- getter
- (UITableView *)craetTableView{
    if (!_craetTableView) {
        _craetTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStyleGrouped];
        _craetTableView.delegate = self;
        _craetTableView.dataSource = self;
        _craetTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _craetTableView.showsVerticalScrollIndicator = NO;
        _craetTableView.showsHorizontalScrollIndicator = NO;
        [_craetTableView setTableHeaderView:self.headView];
        [_craetTableView setTableFooterView:self.footView];
        _craetTableView.sectionHeaderHeight = 10;
        _craetTableView.sectionFooterHeight = 10;
        
    }
    return _craetTableView;
}
- (UIImageView *)headView {
    
    if (!_headView) {
        _headView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image.bundle/封面"]];
         [_headView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/16*9)];
        _headView.userInteractionEnabled = YES;
        [_backScroll addSubview:_headView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBackView)];
        [_headView addGestureRecognizer:tap];
    }
    return _headView;
}
- (UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        [_footView addSubview:self.creatLivebt];
    }
    return _footView;
}
- (UIButton *)creatLivebt
{
    if (!_creatLivebt) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(40, 10, self.view.frame.size.width - 80, 40);
        _creatLivebt = button;
        [_creatLivebt addTarget:self action:@selector(creatLive:) forControlEvents:UIControlEventTouchUpInside];
        _creatLivebt.layer.masksToBounds = YES;
        // 设置圆角大小
        _creatLivebt.layer.cornerRadius = 4.5;
        
        [_creatLivebt setBackgroundColor:CreateLiveConfModel.sharedManager.themeColor];
        [_creatLivebt setTitle:@"创建直播" forState:UIControlStateNormal];
        [_creatLivebt.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_creatLivebt.titleLabel setTextColor:[UIColor whiteColor]];
        [_backScroll addSubview:_creatLivebt];
        
    }
    return _creatLivebt;
}
- (UITextField *)classtyTF
{
    if (!_classtyTF) {
        _classtyTF = [[UITextField alloc]initWithFrame:CGRectMake(140, 10, [UIScreen mainScreen].bounds.size.width - 200, 20)];
        _classtyTF.placeholder = @"请选择直播分类";
        [_classtyTF setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        _classtyTF.delegate = self;
        _classtyTF.userInteractionEnabled = NO;
        _classtyTF.font = [UIFont systemFontOfSize:13];
        _classtyTF.keyboardType = UIKeyboardAppearanceDefault;
        _classtyTF.returnKeyType = UIReturnKeyDone;
        
    }
    return _classtyTF;
}
- (UITextField *)liveTitleTF{
    if(!_liveTitleTF){
        _liveTitleTF = [[UITextField alloc]initWithFrame:CGRectMake(140, 10, [UIScreen mainScreen].bounds.size.width - 200, 20)];
        _liveTitleTF.placeholder = @"请输入直播标题";
        _liveTitleTF.delegate = self;
        _liveTitleTF.font = [UIFont systemFontOfSize:13];
        _liveTitleTF.keyboardType = UIKeyboardAppearanceDefault;
        _liveTitleTF.returnKeyType = UIReturnKeyDone;
        [_liveTitleTF setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    }
    return _liveTitleTF;
}
- (UITextView *)introductionTV{
    if (!_introductionTV) {
        _introductionTV = [[UITextView alloc]initWithFrame:CGRectMake(140, 5, [UIScreen mainScreen].bounds.size.width - 200, 80)];
        _introductionTV.delegate = self;
        _introductionTV.keyboardType = UIKeyboardAppearanceDefault;
        _introductionTV.returnKeyType = UIReturnKeyDone;
        _introductionTV.font = [UIFont systemFontOfSize:13];
        _introductionTV.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"请输入直播简介";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor lightGrayColor];
        [placeHolderLabel sizeToFit];
        [_introductionTV addSubview:placeHolderLabel];
        
        // same font
        _introductionTV.font = [UIFont systemFontOfSize:13.f];
        placeHolderLabel.font = [UIFont systemFontOfSize:13.f];
        
        [_introductionTV setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    }
    return _introductionTV;
}
- (UITextField *)startTimeTF{
    if (!_startTimeTF) {
        _startTimeTF = [[UITextField alloc]initWithFrame:CGRectMake(140, 10, [UIScreen mainScreen].bounds.size.width - 200, 20)];
        _startTimeTF.placeholder = @"请选择直播开始时间";
        _startTimeTF.delegate = self;
        _startTimeTF.font = [UIFont systemFontOfSize:13];
        _startTimeTF.userInteractionEnabled = NO;
        [_startTimeTF setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        _startTimeTF.keyboardType = UIKeyboardAppearanceDefault;
        _startTimeTF.returnKeyType = UIReturnKeyDone;
    }
    return _startTimeTF;
}
- (UITextField *)endTimeTF{
    if (!_endTimeTF) {
        _endTimeTF = [[UITextField alloc]initWithFrame:CGRectMake(140, 10, [UIScreen mainScreen].bounds.size.width - 200, 20)];
        _endTimeTF.placeholder = @"请选择直播结束时间";
        _endTimeTF.delegate = self;
        _endTimeTF.font = [UIFont systemFontOfSize:13];
        _endTimeTF.userInteractionEnabled = NO;
        _endTimeTF.keyboardType = UIKeyboardAppearanceDefault;
        _endTimeTF.returnKeyType = UIReturnKeyDone;
        [_endTimeTF setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    }
    return _endTimeTF;
}
- (UITextField *)liveAddressTF{
    if (!_liveAddressTF) {
        _liveAddressTF = [[UITextField alloc]initWithFrame:CGRectMake(140, 10, [UIScreen mainScreen].bounds.size.width - 200, 20)];
        _liveAddressTF.placeholder = @"请选择直播地址";
        _liveAddressTF.delegate = self;
        _liveAddressTF.font = [UIFont systemFontOfSize:13];
        _liveAddressTF.keyboardType = UIKeyboardAppearanceDefault;
        _liveAddressTF.returnKeyType = UIReturnKeyDone;
        _liveAddressTF.userInteractionEnabled = NO;
        [_liveAddressTF setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    }
    return _liveAddressTF;
}
- (UIView *)blackV {
    if (!_blackV) {
        UIView *view = [[UIView alloc] init];
        _blackV = view;
        [_blackV setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]];
        [_backScroll addSubview:_blackV];
        
    }
    return _blackV;
}
@end

