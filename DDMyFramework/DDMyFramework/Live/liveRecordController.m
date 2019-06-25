//
//  liveRecordController.m
//  VideoA01
//
//  Created by Higgses on 2018/1/19.
//  Copyright © 2018年 Higgses. All rights reserved.
//

#import "liveRecordController.h"
#import "LiveRecordCell.h"
#import "CreatViewController.h"
#import <Masonry/Masonry.h>
#define kHeight(h) ([UIScreen mainScreen].bounds.size.height / 667.0 * h)
#define kWidth(w) ([UIScreen mainScreen].bounds.size.width / 375.0 * w)
#import <AFNetworking/AFNetworking.h>
#import "RecorModel.h"
#import "YYModel.h"
#import <MJRefresh/MJRefresh.h>
#import "LiveController.h"
//#import <TMSDK/TMHttpUserInstance.h>
//#import <TMSDK/TMEngineConfig.h>
#import "CreateLiveConfModel.h"
@interface liveRecordController ()<UITableViewDelegate,UITableViewDataSource, LiveRecordDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RecorModel *recordModel;


@end

@implementation liveRecordController

- (void)beginLive:(NSString *)pushUrl LiveId:(NSString *)liveId status:(NSInteger)status{
    
    
    LiveController *lvC = [[LiveController alloc]init];
    lvC.pushUrl = pushUrl;
    lvC.liveId = liveId;
    lvC.status = status;
    [self presentViewController:lvC animated:YES completion:^{
        
        
    }];
    
//
//    int intRoomid = [roomId intValue];
//
//    NSLog(@"😆%d     %@", intRoomid , roomId);
    

}


- (UITableView *)tableView {
    if(!_tableView) {
        
        TMWS(ws);
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
        
            [ws getRecord];
        }];
        _tableView.mj_header.automaticallyChangeAlpha = YES;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_equalTo(self.view);
        }];
    }
    return _tableView;
}
- (RecorModel *)recordModel {
    if(!_recordModel) {
        
        _recordModel = [[RecorModel alloc]init];
    }
    return _recordModel;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"直播记录";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{ NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0],
        NSShadowAttributeName: [[NSShadow alloc] init]}];
 
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:[UIImage imageNamed:@"image.bundle/创建直播"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(creatLive) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self getRecord];
}


- (void)creatLive {
    
    CreatViewController *creatVC = [[CreatViewController alloc]init];
    [self.navigationController pushViewController:creatVC animated:YES];
    
}

- (void)getRecord {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager GET:[NSString stringWithFormat:@"%@/videoa01/api/selflive?user_id=%d", CreateLiveConfModel.sharedManager.domain,CreateLiveConfModel.sharedManager.member_id]
      parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

          self.recordModel = [RecorModel yy_modelWithJSON:responseObject];

          [_tableView.mj_header endRefreshing];
           [_tableView.mj_header endRefreshing];
          [self.tableView reloadData];


      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

          NSLog(@"%@", error);

      }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _recordModel.data.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHeight(89.5);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    DetailData *model=  [[DetailData alloc]init];
    model = _recordModel.data.data[indexPath.row];
    NSLog(@"%ld",(long)model.status);
    if (model.status != 0) {
        return;
    }
    NSLog(@"pushUrl:%@",model.push_url);
    NSLog(@"liveUrl:%@",model.live_url);

    [self beginLive:model.push_url LiveId:[NSString stringWithFormat:@"%ld",(long)model.liveID] status:model.status];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStr = @"liveRecordCell";
    LiveRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[LiveRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        [cell setBackgroundColor:[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0]];
        cell.delegate = self;
    }
    cell.recordModel = _recordModel.data.data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
