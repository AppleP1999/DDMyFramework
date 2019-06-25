//
//  STDExampleMixCellsViewController.m
//  STDTableView
//
//  Created by XuQibin on 2018/3/18.
//  Copyright © 2018年 Standards. All rights reserved.
//

#import "STDExampleMixCellsViewController.h"

#import "STDExampleImageCell.h"

#import "STDExampleHeaderCell.h"

@interface STDExampleMixCellsViewController ()

@end

@implementation STDExampleMixCellsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

#pragma mark - setup

- (void)configTableView:(UITableView *)tableView
{
    tableView.backgroundColor = kTableViewBackgroundColor;

    [tableView std_registerCellNibClass:[STDExampleImageCell class]];
    [tableView std_registerCellClass:[STDExampleHeaderCell class]];
    
    STDTableViewSection *sectionData = [[STDTableViewSection alloc] initWithCellClass:[STDExampleHeaderCell class]];
    [tableView std_addSection:sectionData];
}

- (void)setupExampleContent
{
    NSArray *itemList = @[[STDExampleImageCell cellItemWithData:@"bg-mixcell" cellHeight:200],
                          [STDExampleHeaderCell cellItemWithData:@"关于" cellHeight:55],
                          [STDExampleHeaderCell cellItemWithData:@"设置" cellHeight:55]];
    
    [self.tableView std_addItems:itemList atSection:0];
    
    [self.tableView std_insertRows:itemList.count atEmptySection:0 withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STDTableViewItem *item = [tableView std_itemAtIndexPath:indexPath];
    
    return item.cellHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
