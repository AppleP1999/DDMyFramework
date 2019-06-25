//
//  mapVC.m
//  Video01
//
//  Created by Higgses on 2018/3/15.
//  Copyright © 2018年 Higgses. All rights reserved.
//

#import "mapVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
//#import <TMSDK/TMSDK.h>
#import "CreateLiveConfModel.h"
#define kHeight(h) ([UIScreen mainScreen].bounds.size.height / 667.0 * h)
#define kWidth(w) ([UIScreen mainScreen].bounds.size.width / 375.0 * w)
@interface mapVC ()<MAMapViewDelegate,UIGestureRecognizerDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource,AMapSearchDelegate,AMapLocationManagerDelegate>
{
    BOOL _didappear;
}
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapReGeocodeSearchRequest *search;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotation;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) UILabel *addressLB;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AMapSearchAPI *searchApi;

@end

@implementation mapVC

- (void)viewDidLoad { 
    [super viewDidLoad];
    self.searchApi = [[AMapSearchAPI alloc]init];
    self.searchApi.delegate = self;
    [AMapServices sharedServices].enableHTTPS = YES;
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    //给_mapView添加长按手势
//    UITapGestureRecognizer *r5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
//    r5.numberOfTapsRequired = 1;
//    r5.delegate = self;
//    [_mapView addGestureRecognizer:r5];
    
//    UILongPressGestureRecognizer *lpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//    lpress.delegate = self;
//    [_mapView addGestureRecognizer:lpress];
    
    ///把地图添加至view
    [self.view addSubview:self.mapView];
    ///进入地图就显示定位小蓝点
    // 开启定位
    _mapView.showsUserLocation = YES;
    // 追踪用户位置
   _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    // 设置成NO表示关闭指南针；YES表示显示指南针
    _mapView.showsCompass= NO;
//    self.mapView.showsUserLocation = NO;
    //全局的大头针

    _pointAnnotation = [[MAPointAnnotation alloc] init];
    self.addressLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    self.addressLB.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.6];
    self.addressLB.textColor = [UIColor blackColor];
    self.addressLB.text = self.string;
    self.addressLB.textAlignment = 1;
    [self.view addSubview:self.sureBtn];
    [self.view addSubview:self.addressLB];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_didappear)
    {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image.bundle/图钉"]];
        img.frame = CGRectMake(0, 0, 15, 30);
        img.center = CGPointMake(self.mapView.center.x-8, self.mapView.center.y-30);
        [self.view addSubview:img];
        _didappear = YES;
    }
}
#pragma mark - 允许多手势响应
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
//自定义大头针我这里只是把大头针变成一张自定义的图片
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@""];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    MACoordinateRegion region;
    
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    
    region.center = centerCoordinate;
    
    [self setGegeo:centerCoordinate];
    
   [self setLocationWithLatitude:centerCoordinate.latitude AndLongitude:centerCoordinate.longitude];
    
}
- (void)setGegeo:(CLLocationCoordinate2D)coor {
    
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc]init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coor.latitude longitude:coor.longitude];
    regeo.requireExtension            = YES;
    
    [self.searchApi AMapReGoecodeSearch:regeo];
}
- (void)longPress:(UIGestureRecognizer*)gestureRecognizer{
   
    _mapView.showsUserLocation = NO;
    [_mapView removeAnnotation:_pointAnnotation];
    //坐标转换
    CGPoint touchPoint = [gestureRecognizer locationInView:_mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
    
    _pointAnnotation.coordinate = touchMapCoordinate;
    //_pointAnnotation.title = @"设置名字";
    
    [_mapView addAnnotation:_pointAnnotation];
    if(gestureRecognizer)
    [self setLocationWithLatitude:touchMapCoordinate.latitude AndLongitude:touchMapCoordinate.longitude];
}
- (void)aciton_sure:(UIButton *)sender{
     __weak typeof(self) weakself = self;
    if (self.longitude.length > 0 || self.longitude.length > 0 || self.addressLB.text.length > 0) {
        NSDictionary *dic = @{@"la":self.latitude,@"lo":self.longitude,@"address":self.addressLB.text};
        if (weakself.returnValueBlock) {
            //将自己的值传出去，完成传值
            weakself.returnValueBlock(dic);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)setLocationWithLatitude:(CLLocationDegrees)latitude AndLongitude:(CLLocationDegrees)longitude{
    
    NSString *latitudeStr = [NSString stringWithFormat:@"%f",latitude];
    NSString *longitudeStr = [NSString stringWithFormat:@"%f",longitude];
    self.latitude = latitudeStr;
    self.longitude = longitudeStr;
//    _mapCoordinate = [NSString stringWithFormat:@"%@,%@",latitudeStr,longitudeStr];
    //NSLog(@"%@",_mapCoordinate);
    //反编码 经纬度---->位置信息
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"反编码失败:%@",error);
//            [self.view makeToast:@"该网点经纬度信息有误，请重新标注！"];
        }else{
            NSLog(@"反编码成功:%@",placemarks);
            CLPlacemark *placemark=[placemarks lastObject];
            //NSLog(@"%@",placemark.addressDictionary[@"FormattedAddressLines"]);
            NSDictionary *addressDic=placemark.addressDictionary;
            
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            //NSLog(@"%@,%@,%@,%@",state,city,subLocality,street);
            NSString *strLocation;
            if (street.length == 0 || street == NULL || [street isEqualToString:@"(null)"]) {
                strLocation= [NSString stringWithFormat:@"%@%@",city,subLocality];
            }else{
                strLocation= [NSString stringWithFormat:@"%@%@%@%@",state,city,subLocality,street];
            }
            
            self.addressLB.text = strLocation;
        }
    }];
}
/*
 * 手机定位你当前的位置，并获得你位置的信息
 */
- (void)mobilePhonePositioning{
    
    _locationManager = [[AMapLocationManager alloc] init];
    _locationManager.delegate = self;
    [AMapServices sharedServices].apiKey =@"你的key值";
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为10s
    _locationManager.locationTimeout =10;
    //   逆地理请求超时时间，最低2s，此处设置为10s
    _locationManager.reGeocodeTimeout = 10;
    
    // 显示进度圈
//    [self showHUDWithStatus:@"正在定位您的位置..."];
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        // 隐藏进度圈
//        [self dismissHUDIgnoreShowCount];
        
        if (error)
        {
            //NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
//            [self.view makeToast:@"抱歉，未能定位到你的位置!"];
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        //NSLog(@"location:%@", location);
//        NSString *latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
//        NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        self.mapView.centerCoordinate = location.coordinate;
//        _mapCoordinate = [NSString stringWithFormat:@"%@,%@",latitude,longitude];
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
//            self.addressTextView.text = regeocode.formattedAddress;
        }
    }];
}
#pragma mark -- UITableViewDataSource,UItableViewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    label.text = @"成都天府五街";
    label.font = [UIFont systemFontOfSize:13];
    [cell.contentView addSubview:label];
    return cell;
    
}

#pragma mark -- getter

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(0, 0, 100, 30);
        _sureBtn.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 100);
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 15;
        [_sureBtn setBackgroundColor: CreateLiveConfModel.sharedManager.themeColor];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(aciton_sure:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _sureBtn;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 300) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}
@end
