//
//  COMonthStatisticsViewController.m
//  CheckOrder
//
//  Created by baojuan on 15/6/30.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COMonthStatisticsViewController.h"
#import "COMonthStatisticsCell.h"






@interface COMonthStatisticsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *dataArray;

@end

@implementation COMonthStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self readProportionData];
}

- (void)readProportionData
{
    NSArray *cost = [[NSUserDefaults standardUserDefaults] valueForKey:kCOMonthCost];
    self.dataArray = cost;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    COMonthStatisticsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"COMonthStatisticsCell" owner:self options:nil] lastObject];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
