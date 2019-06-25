//
//  NewsI004DjSearchVC.m
//  NewsI004
//
//  Created by omni－appple on 2018/9/27.
//  Copyright © 2018年 ZhouYou. All rights reserved.
//

 
#import "NewsI004DjSearchVC.h"
#import "NewsI004DjHistoricalView.h"
#import "NewsI004SearchHistorySaveUtils.h"
#import "UIColor+LLHex.h"
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import "NewsI004NewsCell.h"
#import "NewsI004DetailViewController.h"
#import <Toast/Toast.h>
#import <MJRefresh/MJRefresh.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "NewsI004Header.h"
#import "NewsI004Tool.h"
//#import <FCBaseKit/FCBaseKit.h>
typedef void (^dealCompleteBlock) (BOOL isComplete);

@interface NewsI004DjSearchVC ()<UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate> // NewsI004DetailsListVC

@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UIButton *rightMoreBtn;
@property (nonatomic,strong) UITextField *  searchTtextFieldextField ;
@property (nonatomic,strong) NewsI004DjHistoricalView *  historicalView ;
@property (nonatomic,strong) NewsI004SearchHistorySaveUtils * SaveUtils ;

@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, strong) UITableView *dd_tableView;
@property (nonatomic, strong) NSArray <NewsI004HomePageInformation_list *>*listData;
@property (nonatomic, assign) int page;
@end

@implementation NewsI004DjSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.native = YES;
     self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
    self.title = @"搜索";
    [self addCustomSubviews];
    [self clickCall];
}
-(void) clickCall{
		TMWS(ws);
 		_historicalView.click_call = ^(NSString *str) {
 		  	[SVProgressHUD show];
 			ws.historicalView.hidden =  YES;
			ws.searchTtextFieldextField.text = str;	
			ws.searchText  = str;
			[ws.dd_tableView.mj_header beginRefreshing];
		};
}
-(void) addCustomSubviews{
	self.automaticallyAdjustsScrollViewInsets = NO;

   self.SaveUtils = [[NewsI004SearchHistorySaveUtils alloc] initWithSearchHistoriesCacheFileName:@"NearByShopSearchMapAddressHistoryCacheFileName"];
	UIImageView * imgView = [[UIImageView alloc] init];
	
	[imgView setImage: [UIImage imageNamed:@"NewsI004.bundle/ss1"]];
	[self.view addSubview:imgView];
	 [imgView   mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(16, 16));
		make.top.mas_equalTo(26);
		make.left.mas_equalTo(15);
	}];
     self.searchTtextFieldextField =  [[UITextField alloc] init];
    self.searchTtextFieldextField.placeholder = @"输入关键词条";
    [self.searchTtextFieldextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    self.searchTtextFieldextField.returnKeyType = UIReturnKeySearch;
    self.searchTtextFieldextField.delegate = self;
    [self.view addSubview: self.searchTtextFieldextField];
 
	  
	[self.searchTtextFieldextField   mas_makeConstraints:^(MASConstraintMaker *make) {
	make.size.mas_equalTo(CGSizeMake(16, 16));
	make.centerY.equalTo(imgView);
	make.left.equalTo(imgView.mas_right).offset(10);
	make.right.equalTo(self.view).offset(-15);

	make.height.mas_equalTo(23);

	}];
  UIView * line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#CBCBCB"];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.searchTtextFieldextField.mas_bottom).offset(9);
    }];
    [self.view addSubview:self.leftTitleLabel];
    [self.view addSubview:self.rightMoreBtn];
     UIView * leftline = [[UIView alloc] init];
    leftline.backgroundColor = TMEngineConfig.instance.themeColor;
    [self.view addSubview:leftline];
    [leftline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26);
		make.size.mas_equalTo(CGSizeMake(5, 13));
        make.centerY.equalTo(self.rightMoreBtn);
    }];
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftline.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 22));
        make.top.equalTo(line).offset(21);
    }];
    [self.rightMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-26);
        make.size.mas_equalTo(CGSizeMake(60, 22));
        make.top.equalTo(line).offset(21);
    }];
    
    UIView * line2 = [[UIView alloc] init];
    line2.backgroundColor = TMEngineConfig.instance.themeColor;
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.rightMoreBtn);
        
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.rightMoreBtn.mas_bottom);
    }];
    
   [self load_historicalView];
    
    [self.view addSubview:self.dd_tableView];
    self.dd_tableView.hidden = YES;
    [self.dd_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}
- (void) load_historicalView{
	if (self.historicalView){
		[self.historicalView removeFromSuperview];
	} 
   	self.historicalView = [[NewsI004DjHistoricalView alloc] initWithFrame:CGRectMake(16, 50, UIScreen.mainScreen.bounds.size.width-16*2, UIScreen.mainScreen.bounds.size.height-120)];
    
    [self.view addSubview:self.historicalView];

    [self.historicalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
		make.top.equalTo(self.leftTitleLabel.mas_bottom).offset(22);
        make.bottom.equalTo(self.view);
    }];
}
- (UILabel *)leftTitleLabel
{
    if (!_leftTitleLabel) {
        
        UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectZero];
        labelName.text = @"历史记录";
        labelName.font =   [UIFont systemFontOfSize:14];
        labelName.textColor = [UIColor colorWithHexString:@"#424242"];
        _leftTitleLabel = labelName;
        
    }
    return _leftTitleLabel;
}

- (UIButton *)rightMoreBtn
{
    if (!_rightMoreBtn) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button  setTitle:@"清空记录" forState:UIControlStateNormal];
        button.titleLabel.font =   [UIFont systemFontOfSize:14];
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        [button setTitleColor:TMEngineConfig.instance.themeColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _rightMoreBtn = button;
    }
    return _rightMoreBtn;
}
#pragma mark - 清空记录
-(void)rightBtnOnClick
{
	[FCBaseTool showAlertViewTitle:@"确定清空搜索历史吗？" message:nil cancelBlaock:nil confirmBlaock:^{
		self.historicalView.hidden = YES;
		[self.SaveUtils clearSearchHistoryWithResult:nil];
	}];
 
}
//搜索虚拟键盘响应

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (!textField.text.length)
        return YES;
    
    self.searchText = textField.text;
    TMWS(ws);
    [self.SaveUtils saveSearchCache:textField.text result:^(BOOL isComplete) {
        [ws load_historicalView];
        ws.historicalView.hidden = YES;
    }];
    
    [_searchTtextFieldextField resignFirstResponder];
    [SVProgressHUD show];
    [self.dd_tableView.mj_header beginRefreshing];
    
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.dd_tableView.hidden = YES;
}

-(void)textFieldDidChange{
    NSLog(@"text %@",self.searchTtextFieldextField.text);
    if ([self.searchTtextFieldextField.text isEqualToString:@""]) {
//        self.historicalView.stingsArray = [self.SaveUtils getSearchCache];
        self.historicalView.hidden = NO;
    }else{
        self.historicalView.hidden = YES;
    }
}

#pragma mark - tableview
-(UITableView * )dd_tableView
{
    if (!_dd_tableView) {
        _dd_tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width) style:UITableViewStylePlain];
        
//        [_dd_tableView registerClass:NewsI004NewsCell.class forCellReuseIdentifier: @"NewsI004NewsCell"];
//		[_dd_tableView registerClass:NewsI004NewsCell.class forCellReuseIdentifier: @"NewsI004NewsCell03"];
//        [_dd_tableView registerClass:NewsI004NewsCell.class forCellReuseIdentifier: @"NewsI004NewsCell02"];
//	    [_dd_tableView registerClass:NewsI004NewsCell.class forCellReuseIdentifier: @"NewsI004NewsCellImgtypeHidden"];
        _dd_tableView.delegate = self;
        _dd_tableView.dataSource = self;
        _dd_tableView.backgroundColor =  TMColorFromRGB(0xEFEFEF);
        self. dd_tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        [self.dd_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        
        _dd_tableView .separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_dd_tableView];
        
        TMWS(ws);
        _dd_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            ws.page = 1;
            [ws requestSearchData];
        }];
        _dd_tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
          
            [ws requestSearchData];
			ws.page++;
        }];
    }
    return _dd_tableView;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//	NSString * cellID = @"NewsI004NewsCell";
//	NSArray *tmpArr = [self.listData[indexPath.row].thumbnail componentsSeparatedByString :@","];
//		if (tmpArr.count == 3  ) {
//			//    		  static   NSString *  cellID03  = @"NewsI004NewsCell03";
//			cellID = @"NewsI004NewsCell03";
//		}else if (tmpArr.count == 2){
//			cellID = @"NewsI004NewsCell02";
// 		}
//		else if (self.listData[indexPath.row].type == 1 || [self.listData[indexPath.row].module_name isEqualToString:@"fcinformation"] ){// 文章和资讯类型
//			cellID = @"NewsI004NewsCelltypeHidden";
//		}else if ([self.listData[indexPath.row].module_name isEqualToString:@"fcfind"]){
//			cellID = @"NewsI004NewsCellimgtypeHidden";
//		}
//		
    NewsI004NewsCell * cell = [NewsI004NewsCell  cell_tableView:tableView indexPath:indexPath cellData:self.listData[indexPath.row]];
//    NewsI004NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
//    NewsI004HomePageInformation_list *newsData = self.listData[indexPath.row];
//	cell.data = newsData ;
 
     return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.listData[indexPath.row].cellH;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
      	NewsI004HomePageInformation_list  * listM = self.listData[indexPath.row];
 
    [NewsI004Tool toDetailControllerFrom:self info:listM];
}

#pragma mark ------------------------------开始搜索请求
- (void)requestSearchData
{
    __weak typeof(self) weakself  = self;
    ///fcinformation/Information/informationList
    NSString * url = @"/fcinformation/Information/informationList";
      NSString *urlstr = [NSString stringWithFormat:@"%@%@?index=%d&member_id=%d&key=%@&types=%@",[TMEngineConfig instance].domain,url,_page,[TMHttpUserInstance instance].member_id ,self.searchText,@"0,1,2"];
//    NSString *urlstr = [NSString stringWithFormat:@"%@/newsmapa01/Api/news?page=%d&channel_id=%@&title=%@",[TMEngineConfig instance].domain,_page,[TMEngineConfig instance].siteCode,self.searchText?:@""];
//  NSString *urlstr = [NSString stringWithFormat:@"%@/newsmapa01/Api/news?page=%d&channel_id=%@&title=%@",[TMEngineConfig instance].domain,_page,[TMEngineConfig instance].siteCode,self.searchText?:@""];
//     	NewsI004HomePageData * data = self.listData.lastObject;
//    NSString *url = [NSString stringWithFormat:@"%@/fcinformation/Information/informationList?&plate_id=%zd&member_id=%d&page_size=%zd&index=%zd",[TMEngineConfig instance].domain ,data.plate_id,[TMHttpUserInstance instance].member_id ,_page_size,_page];
    
    urlstr = [urlstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlstr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakself.dd_tableView.hidden = NO;
        [SVProgressHUD dismiss];
        [weakself bindDataDic:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakself.view makeToast:@"请求失败 请稍后再试" duration:3.0 position:CSToastPositionCenter];
        [weakself.dd_tableView.mj_header endRefreshing];
        [weakself.dd_tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    }];
}

- (void)bindDataDic:(NSDictionary *)infoDic
{
 	NewsI004HomePageNextModel * model  = [NewsI004HomePageNextModel mj_objectWithKeyValues:infoDic];
    NSArray *dataArr = model.data.list?:@[];
    if (self.page > 1 && ![dataArr count]) {
        [self.dd_tableView.mj_footer endRefreshingWithNoMoreData];
        return ;
    }
    if (self.page == 1) {
        self.listData  = [NSMutableArray array];
        if (![dataArr count]) {
            [self.dd_tableView reloadData];
            [self.dd_tableView.mj_header endRefreshing];
            return;
        }
    }
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.listData];
    [tmpArr addObjectsFromArray:dataArr];
    self.listData = tmpArr;
    [self.dd_tableView reloadData];
    [self.dd_tableView.mj_header endRefreshing];
    [self.dd_tableView.mj_footer endRefreshing];
}

@end
