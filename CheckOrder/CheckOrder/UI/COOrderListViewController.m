//
//  COOrderListViewController.m
//  CheckOrder
//
//  Created by baojuan on 15/5/21.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COOrderListViewController.h"
#import "COOrderListLeftCell.h"
#import "COOrderListRightCell.h"
#import "COOrderListTimeCell.h"
#import "COOrderListLRCell.h"

#import "COOrderModel.h"

#import "CODataCenter.h"

@interface COOrderListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong)  NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *taSumMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *mySumMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *taNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *myNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumMoneyLabel;

@end

@implementation COOrderListViewController

- (void)testData
{
    COOrderModel *model1 = [COOrderModel new];
    model1.orderId = 1;
    model1.sum = -100.00;
    model1.type = COOrderTypeMine;
    model1.orderTime = 2000000;
    model1.updateTime = 2000000;
    COCategoryModel *cate1 = [COCategoryModel new];
    cate1.categoryId = 12;
    cate1.name = @"用餐";
    cate1.type = 0;
    cate1.updateTime = 1000000;
    cate1.icon = 5;
    model1.category = cate1;
    model1.ps = @"吃吃吃";
    model1.year = 2015;
    model1.month = 5;
    model1.day = 12;
    
    
    
    COOrderModel *model2 = [COOrderModel new];
    model2.orderId = 1;
    model2.sum = -500.00;
    model2.type = COOrderTypeOurs;
    model2.orderTime = 2200000;
    model2.updateTime = 2200000;
    COCategoryModel *cate2 = [COCategoryModel new];
    cate2.categoryId = 10;
    cate2.name = @"购物";
    cate2.type = 0;
    cate2.updateTime = 1100000;
    cate2.icon = 3;
    model2.category = cate2;
    model2.ps = @"买买买";
    model2.year = 2015;
    model2.month = 5;
    model2.day = 12;
    
    
    COOrderModel *model4 = [COOrderModel new];
    model4.orderId = 1;
    model4.sum = -500.00;
    model4.type = COOrderTypeOurs;
    model4.orderTime = 2200000;
    model4.updateTime = 2200000;
    COCategoryModel *cate4 = [COCategoryModel new];
    cate4.categoryId = 10;
    cate4.name = @"购物";
    cate4.type = 0;
    cate4.updateTime = 1100000;
    cate4.icon = 3;
    model4.category = cate4;
    model4.ps = @"买买买4";
    model4.year = 2015;
    model4.month = 5;
    model4.day = 12;
    
    
    
    COOrderModel *model3 = [COOrderModel new];
    model3.orderId = 1;
    model3.sum = 500.00;
    model3.type = COOrderTypeMine;
    model3.orderTime = 2000000;
    model3.updateTime = 2000000;
    COCategoryModel *cate3 = [COCategoryModel new];
    cate3.categoryId = 12;
    cate3.name = @"收入";
    cate3.type = 0;
    cate3.updateTime = 0000000;
    cate3.icon = 2;
    model3.category = cate3;
    model3.year = 2015;
    model3.month = 5;
    model3.day = 15;
    
    
    self.dataArray = @[@{@"12":@[model1,model2]},@{@"15":@[model3,model4]}];

}


- (void)viewDidLoad
{
    [self testData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"COOrderListLeftCell" bundle:nil] forCellReuseIdentifier:@"COOrderListLeftCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"COOrderListRightCell" bundle:nil] forCellReuseIdentifier:@"COOrderListRightCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"COOrderListLRCell" bundle:nil] forCellReuseIdentifier:@"COOrderListLRCell"];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self configViewData];
    
    
}

- (void)configViewData
{
    float taSumMoney = [CODataCenter taSumMoney];
    float mySumMoney = [CODataCenter mySumMoney];
    float allSumMoney = taSumMoney + mySumMoney;
    
    self.taNameLabel.text = [NSString stringWithFormat:@"%@的",[CODataCenter taName]];
    self.myNameLabel.text = [NSString stringWithFormat:@"%@的",[CODataCenter myName]];
    
    self.taSumMoneyLabel.text = [NSString stringWithFormat:@"%.2f",taSumMoney];
    self.mySumMoneyLabel.text = [NSString stringWithFormat:@"%.2f",mySumMoney];
    self.sumMoneyLabel.text = [NSString stringWithFormat:@"%.2f",allSumMoney];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = [self.dataArray objectAtIndex:section];
    NSArray *array = [[dict allValues] firstObject];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.section];
    NSArray *array = [[dict allValues] firstObject];
    COOrderModel *model = [array objectAtIndex:indexPath.row];
    if (model.type == COOrderTypeMine) {
        COOrderListRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COOrderListRightCell" forIndexPath:indexPath];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@ %.2f",model.category.name,model.sum];
        cell.desLabel.text = model.ps;
        return cell;
    }
    else if (model.type == COOrderTypeYours) {
        COOrderListLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COOrderListLeftCell" forIndexPath:indexPath];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@ %.2f",model.category.name,model.sum];
        cell.desLabel.text = model.ps;
        return cell;
    }
    else if (model.type == COOrderTypeOurs) {
        COOrderListLRCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COOrderListLRCell" forIndexPath:indexPath];
        cell.leftTitleLabel.text = cell.rightTitleLabel.text = [NSString stringWithFormat:@"%@ %.2f",model.category.name,(model.sum / 2.0)];
        cell.leftDesLabel.text = cell.rightDesLabel.text = model.ps;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    COOrderListTimeCell *cell = [[COOrderListTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"COOrderListTimeCell"];
    NSDictionary *dict = [self.dataArray objectAtIndex:section];
    cell.dateLabel.text = [dict.keyEnumerator nextObject];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell.contentView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

@end
