//
//  STDExampleViewController.m
//  STDTableView
//
//  Created by XuQibin on 2018/3/17.
//  Copyright © 2018年 Standards. All rights reserved.
//

#import "STDExampleViewController.h"

#import "STDExampleListCell.h"
#import "STDExampleListItem.h"

#import "STDExampleHeaderViewController.h"
#import "STDExampleCellEventViewController.h"
#import "STDExampleMixCellsViewController.h"
#import <TABAnimated.h>
@interface STDExampleViewController ()

@end

@implementation STDExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"STDTableView";
 
}

#pragma mark - setup

- (void)configTableView:(UITableView *)tableView
{
    tableView.rowHeight = 55;

    [tableView std_registerCellNibClass:[STDExampleListCell class]];
    
 
    
    STDTableViewSection *sectionData = [[STDTableViewSection alloc] initWithCellClass:[STDExampleListCell class]];
    [tableView std_addSection:sectionData];
    
//	tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[STDExampleListCell class] cellHeight:55];
//	tableView.tabAnimated.categoryBlock = ^(UIView * _Nonnull view) {
//            view.animation(1).down(2).line(2);
//        };
        
// 	[tableView tab_startAnimation];
//	 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//     [tableView tab_endAnimation];
// 
//    });
}

- (void)setupExampleContent
{
    NSArray *itemList = @[[STDExampleListItem itemWithTitle:@"1. 头部点击缩放" subTitle:nil object:[STDExampleHeaderViewController class]],
                          [STDExampleListItem itemWithTitle:@"2. Cell事件响应" subTitle:nil object:[STDExampleCellEventViewController class]],
                          [STDExampleListItem itemWithTitle:@"3. 混合Cell" subTitle:nil object:[STDExampleMixCellsViewController class]]];
    
    [self.tableView std_addItems:itemList atSection:0];
    
    [self.tableView std_insertRows:itemList.count atEmptySection:0 withRowAnimation:UITableViewRowAnimationFade];
    
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [tableView std_cellSelectedCallbackWithIndexPath:indexPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
@end
