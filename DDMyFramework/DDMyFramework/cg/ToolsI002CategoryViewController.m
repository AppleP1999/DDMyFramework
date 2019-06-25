//
//  ToolsI002CategoryViewController.m
//  DDMyFramework
//
//  Created by omni－appple on 2019/4/11.
//  Copyright © 2019年 COM.Sobey.dengjie. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "ToolsI002CategoryViewController.h"
#import "ToolsI002CategoryModel.h"
#import "GACategoryCell.h"
@interface ToolsI002CategoryViewController () <UITableViewDataSource, UITableViewDelegate>
 
/** 右边表格 */
@property (strong, nonatomic)  UITableView *subcategoryTableView;
/** 左边表格 */
@property (strong, nonatomic)  UITableView *categoryTableView;
/** 所有的类别数据 */
@property (nonatomic, strong) NSArray *categories;

@property (nonatomic, strong)  UIView * leftView;

//+ (instancetype)categoryWithDict:(NSDictionary *)dict;
@end

@implementation ToolsI002CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
 
	 NSMutableArray * arr  = @[].mutableCopy;
	 
	 for (int i = 0 ; i < 6; i ++) {
	 
	 
	 
	NSString * name = [NSString stringWithFormat:@"方法%d" , i];
	 NSMutableArray * arra  = @[].mutableCopy;
	  for (int k = 0;  k <i +1; k ++) {
    		[arra  addObject:name];
		}
	 ToolsI002CategoryModel *  c = [ToolsI002CategoryModel categoryWithDict:@{
											@"name":name,
											@"icon":@"图层48",
											@"highlighted_icon" :@"图层48",
											@"subcategories":arra,
														}];
														
	[arr  addObject:c];
	}
	self.categories = arr;
	 
	[self load_tableview];
	
//	[self.categoryTableView reloadData];
//   [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}
- (void) load_tableview{
     //1：默认选中左边表格的第0行
    // UITableViewCellSelectionStyleGray
    [self.subcategoryTableView  registerClass:[UITableViewCell class] forCellReuseIdentifier:@"subcategory"];
    [self.categoryTableView  registerClass:[GACategoryCell  class] forCellReuseIdentifier:@"category"];
    //2:给右侧的tableView增加额外的滚动区域：在有导航栏的时候，系统默认会为UIScrollView或是继承它的子控件默认增加64的额外滚动区域，如果有两个继承于UIScrollView的子控件，则系统默认只会为第一个添加到视图上的子控件增加额外的滚动区域。如果想禁止，则实现UIScrollView或是tableView等的ContentInset属性，增加额外的滚动区域，或是在控制器中实现self.automaticallyAdjustsScrollViewInsets = NO;
    self.subcategoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    
 	[self.view addSubview:self.subcategoryTableView];
 	[self.view addSubview:self.categoryTableView];
 	CGFloat p =   [UIScreen mainScreen].bounds.size.width/375.0;
  	[self.categoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
 	      make.width.mas_equalTo(140*p);
 	      make.bottom.top.left.equalTo(self.view);
 	      
	}];
	
	[self.subcategoryTableView  mas_makeConstraints:^(MASConstraintMaker *make) {
 
		make.left.equalTo(self.categoryTableView.mas_right);
	    make.bottom.top.right.equalTo(self.view);
	}];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 左边表格
    if (tableView == self.categoryTableView) return self.categories.count;
    
    // 右边表格
	ToolsI002CategoryModel *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    return   c.subcategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 左边表格
    if (tableView == self.categoryTableView) {
        static NSString *ID = @"category";
     GACategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath] ;
        
        ToolsI002CategoryModel *c = self.categories[indexPath.row];
        
        // 设置普通图片
//        cell.imageView.image = [UIImage imageNamed:c.icon];
////         设置高亮图片（cell选中 -> cell.imageView.highlighted = YES -> cell.imageView显示highlightedImage这个图片）
//        cell.imageView.highlightedImage = [UIImage imageNamed:c.highlighted_icon];
        
//         设置label高亮时的文字颜色
        cell.textLabel.highlightedTextColor = [UIColor redColor];
        cell.selectedBackgroundView.backgroundColor = UIColor.redColor;
//		cell.backgroundColor = UIColor.yellowColor;
        cell.textLabel.text = c.name;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		UIView *backgroundViews = [[UIView alloc]initWithFrame:cell.frame];
		UIView *  p = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 98)];
     	p.backgroundColor = [UIColor redColor];
     	[backgroundViews addSubview:p];
     	
		backgroundViews.backgroundColor = [UIColor orangeColor];
		[cell setSelectedBackgroundView:backgroundViews];
		
	 
        return cell;
    } else {
        // 右边表格
        static NSString *ID = @"subcategory";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath] ;
		ToolsI002CategoryModel *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
//		cell.selectedBackgroundView.backgroundColor = UIColor.redColor;
                // 设置普通图片
        cell.imageView.image = [UIImage imageNamed:c.icon];
//         设置高亮图片（cell选中 -> cell.imageView.highlighted = YES -> cell.imageView显示highlightedImage这个图片）
        cell.imageView.highlightedImage = [UIImage imageNamed:c.highlighted_icon];
        // 获得左边表格被选中的模型
         cell.textLabel.text = c.subcategories[indexPath.row];
        
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
// 	 	GACategoryCell * cell  = [tableView  cellForRowAtIndexPath:indexPath];
// 	 	cell.backgroundColor = [UIColor whiteColor];
 	 	
		[self.subcategoryTableView reloadData];
    }else{
	 
	}
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

 
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
      return 98;
}

#pragma  makr load --- 
- (UITableView *)subcategoryTableView{
	 if (!_subcategoryTableView) {
    	_subcategoryTableView = [[ UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStyleGrouped];
    	_subcategoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    	_subcategoryTableView.delegate = self;
    	_subcategoryTableView.dataSource = self;
	}
	return  _subcategoryTableView;
}

- (UITableView *)categoryTableView{
	 if (!_categoryTableView ) {
    	_categoryTableView = [[ UITableView alloc] initWithFrame:CGRectMake(140, 0, 100, 100) style:UITableViewStyleGrouped];
    	_categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    	_categoryTableView.delegate = self;
		_categoryTableView.dataSource = self;

	}
	return  _categoryTableView;
}
 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

@end
