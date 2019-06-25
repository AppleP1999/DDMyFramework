//
//  Livel003ChatView.m
//  MVVM_Demo
//
//  Created by omni－appple on 2019/3/13.
//  Copyright © 2019年 gongwenkai. All rights reserved.
//
#import "UIView+LYAdd.h"
#import "Livel003ChatView.h"
#import "LIvel003DescCell.h"
#import "Livel003LiveChatCell.h"
@interface Livel003ChatView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSMutableArray * dataArr;
@end
@implementation Livel003ChatView 

-(NSMutableArray*)dataArr
{
     if (_dataArr == nil) {
     	self.dataArr = NSMutableArray.alloc.init;
     	self.backgroundColor = UIColor.clearColor;
    }
    return _dataArr;
}
- (void)addModel:(id)model
{
   [self.dataArr addObject:@""];
   [self reloadData];
//   self.contentSize.height - self.
//  	[self setContentOffset:CGPointMake(0, MAX(0, self.contentSize.height - self.height)) animated:YES];
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
		self.separatorStyle = UITableViewCellSeparatorStyleNone;
	 [self registerNib];
    }
    return self;
}
- (void)registerNib{
	[self registerNib:[UINib nibWithNibName:NSStringFromClass(Livel003LiveChatCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(Livel003LiveChatCell.class)];
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *  Identifier = @"Livel003LiveChatCell";
	Livel003LiveChatCell *  cell = [tableView  dequeueReusableCellWithIdentifier:Identifier];
	if (cell == nil) {
		cell = [[Livel003LiveChatCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
//		cell.detailTextLabel.text = @"detailTextLabeldetailTextL";
//		cell.textLabel.text = @"title";
	}    
 
	return cell;
} 
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataArr.count;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 30;
}

@end
