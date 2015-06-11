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
#import "DBManager.h"
#import "NSObject+DateChange.h"
#import "COCalculationViewController.h"


@interface COOrderListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong)  NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *taSumMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *mySumMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *taNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *myNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumMoneyLabel;

@property (nonatomic, strong)  NSIndexPath *editIndexPath;

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
//    [self testData];
    short month = [self getMonth:[self nowTime]];
    short year = [self getYear:[self nowTime]];

    [self orderArrayFromDBWithMonth:month year:year];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"COOrderListLeftCell" bundle:nil] forCellReuseIdentifier:@"COOrderListLeftCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"COOrderListRightCell" bundle:nil] forCellReuseIdentifier:@"COOrderListRightCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"COOrderListLRCell" bundle:nil] forCellReuseIdentifier:@"COOrderListLRCell"];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self configViewData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAddOrderNotification:) name:@"kAddOrderNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateOrderNotification:) name:@"kUpdateOrderNotification" object:nil];

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

- (void)orderArrayFromDBWithMonth:(NSInteger)month year:(NSInteger)year
{
    COOrderModel *model = [[COOrderModel alloc] init];
    model.month = month;
    model.year = year;
    NSArray * dbArray = [[DBManager shareDB] selectOrderData:model];
    NSArray *sectionArray = [self sectionArrayFromDBArray:dbArray];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:sectionArray];
    [array addObjectsFromArray:self.dataArray];
    self.dataArray = [NSArray arrayWithArray:array];
}

- (NSArray *)sectionArrayFromDBArray:(NSArray *)dbArray
{
    if ([dbArray count] == 0) {
        return [NSArray array];
    }
    NSMutableArray *result = [NSMutableArray new];
    __block short key = -1;
    NSMutableArray *sectionArray = [[NSMutableArray alloc] init];
    [dbArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        COOrderModel *model = obj;
        if (model.day != key) {
            if (key != -1) {
                NSString *resultKey = [NSString stringWithFormat:@"%d.%d.%d",model.year,model.month,key];
                NSArray *resultArray = [NSArray arrayWithArray:sectionArray];
                [result addObject:@{resultKey:resultArray}];
            }
            key = model.day;
            [sectionArray removeAllObjects];
        }
        [sectionArray addObject:model];
    }];
    //最后一组
    COOrderModel *lastOrder = [dbArray lastObject];
    NSString *resultKey = [NSString stringWithFormat:@"%d.%d.%d",lastOrder.year,lastOrder.month,lastOrder.day];
    NSArray *resultArray = [NSArray arrayWithArray:sectionArray];
    [result addObject:@{resultKey:resultArray}];

    return result;
}

#pragma mark - tableview delegate&datasource

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
    void(^editBlock)(void) = ^(){
        
        COCalculationViewController *controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"COCalculationViewController"];
        controller.updateOrder = model;
        [self presentViewController:controller animated:YES completion:^{
            [self.tableView deselectRowAtIndexPath:self.editIndexPath animated:NO];
        }];
    };
    
    void(^deleteBlock)(void) = ^(){
        
        model.sum *= -1;
        [self changeMoneyData:model];
        [self configViewData];
        
        NSMutableArray *resultArray = [[NSMutableArray alloc] initWithArray:self.dataArray];
        NSDictionary *resultDict = [resultArray objectAtIndex:self.editIndexPath.section];
        NSString *key = [[resultDict allKeys] firstObject];
        NSMutableArray *array = [NSMutableArray arrayWithArray:[[resultDict allValues] firstObject]];

        [array removeObject:model];
        if ([array count] > 0) {
            [resultArray replaceObjectAtIndex:indexPath.section withObject:@{key:array}];
        }
        else {
            [resultArray removeObject:resultDict];
        }
        self.dataArray = [NSArray arrayWithArray:resultArray];
        self.editIndexPath = nil;
        [self.tableView reloadData];
        [self.tableView deselectRowAtIndexPath:self.editIndexPath animated:NO];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[DBManager shareDB] deleteOrderData:model];
        });
    };

    if ([model isKindOfClass:[COOrderModel class]]) {
        if (model.type == COOrderTypeMine) {
            COOrderListRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COOrderListRightCell" forIndexPath:indexPath];
            cell.selectedCell = NO;
            cell.editHandler =  editBlock;
            cell.deleteHandler = deleteBlock;
            cell.titleLabel.text = [NSString stringWithFormat:@"%@ %.2f",model.category.name,model.sum];
            cell.desLabel.text = model.ps;
            return cell;
        }
        else if (model.type == COOrderTypeYours) {
            COOrderListLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COOrderListLeftCell" forIndexPath:indexPath];
            cell.selectedCell = NO;
            cell.editHandler =  editBlock;
            cell.deleteHandler = deleteBlock;
            cell.titleLabel.text = [NSString stringWithFormat:@"%@ %.2f",model.category.name,model.sum];
            cell.desLabel.text = model.ps;
            return cell;
        }
        else if (model.type == COOrderTypeOurs) {
            COOrderListLRCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COOrderListLRCell" forIndexPath:indexPath];
            cell.selectedCell = NO;
            cell.editHandler =  editBlock;
            cell.deleteHandler = deleteBlock;
            cell.leftTitleLabel.text = [NSString stringWithFormat:@"%@ %.2f",model.category.name,[CODataCenter taShouldPay:model.sum]];
            cell.rightTitleLabel.text = [NSString stringWithFormat:@"%@ %.2f",model.category.name,[CODataCenter meShouldPay:model.sum]];
            cell.leftDesLabel.text = cell.rightDesLabel.text = model.ps;
            return cell;
        }
        return nil;

    }
    if ([model isKindOfClass:[NSString class]]) {
        NSString *string = [array objectAtIndex:indexPath.row];
        COOrderListTimeCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"COOrderListTimeCell" owner:self options:nil] lastObject];
        cell.dateLabel.text = string;
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
    COOrderListTimeCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"COOrderListTimeCell" owner:self options:nil] lastObject];
    NSDictionary *dict = [self.dataArray objectAtIndex:section];
    cell.dateLabel.text = [dict.keyEnumerator nextObject];
    return cell.contentView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editIndexPath == indexPath) {
        return;
    }
    [self.tableView deselectRowAtIndexPath:self.editIndexPath animated:NO];
    self.editIndexPath = indexPath;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[COOrderCell class]]) {
        ((COOrderCell*)cell).selectedCell = YES;
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    COOrderCell *cell = (COOrderCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[COOrderCell class]]) {
        cell.selectedCell = NO;
    }
}

#pragma mark - notification
- (void)handleAddOrderNotification:(NSNotification *)notification
{
    COOrderModel *order = (COOrderModel *)notification.object;
    if (![order isKindOfClass:[COOrderModel class]]) {
        return;
    }
    else {
        if ([self.dataArray count] > 0) {
            //在dataArray中插入数据
            NSDictionary *dict = self.dataArray[0];
            NSString *key = [NSString stringWithFormat:@"%d.%d.%d",order.year,order.month,order.day];
            if ([[[dict keyEnumerator] nextObject] isEqualToString:key]) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                [array addObject:order];
                [array addObjectsFromArray:dict[[dict.keyEnumerator nextObject]]];
                NSMutableArray *resultArray = [[NSMutableArray alloc] initWithArray:self.dataArray];
                [resultArray replaceObjectAtIndex:0 withObject:@{key:array}];
                self.dataArray = resultArray;
            }
        }
        else {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:order];
            NSString *key = [NSString stringWithFormat:@"%d.%d.%d",order.year,order.month,order.day];
            NSDictionary *insertDict = @{key:array};
            NSMutableArray *resultArray = [[NSMutableArray alloc] initWithArray:self.dataArray];
            [resultArray insertObject:insertDict atIndex:0];
            self.dataArray = resultArray;

        }
        
    }
    [self.tableView reloadData];
    
    [self changeMoneyData:order];
    [self configViewData];
}


- (void)handleUpdateOrderNotification:(NSNotification *)notification
{
    COOrderModel *order = (COOrderModel *)notification.object;
    if (order == nil) {
        self.editIndexPath = nil;
        [self.tableView reloadData];
        return;
    }
    if (![order isKindOfClass:[COOrderModel class]]) {
        self.editIndexPath = nil;
        [self.tableView reloadData];
        return;
    }
    else {
        
        NSDictionary *dict = [self.dataArray objectAtIndex:self.editIndexPath.section];
        NSArray *tempArray = [[dict allValues] firstObject];
        COOrderModel *model = [tempArray objectAtIndex:self.editIndexPath.row];
        
        //减掉原来的钱数
        model.sum *= -1;
        [self changeMoneyData:model];

        NSMutableArray *resultArray = [[NSMutableArray alloc] initWithArray:self.dataArray];
        NSDictionary *resultDict = [resultArray objectAtIndex:self.editIndexPath.section];
        NSString *key = [[resultDict allKeys] firstObject];
        NSMutableArray *array = [NSMutableArray arrayWithArray:[[resultDict allValues] firstObject]];
        [array replaceObjectAtIndex:self.editIndexPath.row withObject:order];
        if ([array count] > 0) {
            [resultArray replaceObjectAtIndex:self.editIndexPath.section withObject:@{key:array}];
        }
        else {
            [resultArray removeObject:array];
        }
        self.dataArray = [NSArray arrayWithArray:resultArray];
    }
    
    self.editIndexPath = nil;
    [self.tableView reloadData];
    
    [self changeMoneyData:order];
    [self configViewData];
}

- (void)changeMoneyData:(COOrderModel *)order
{
    if (order.type == COOrderTypeYours) {
        [CODataCenter changeTaSumMoney:order.sum];
    }
    else if (order.type == COOrderTypeMine) {
        [CODataCenter changeMySumMoney:order.sum];
    }
    else if (order.type == COOrderTypeOurs) {
        [CODataCenter changeTaSumMoney:[CODataCenter taShouldPay:order.sum]];
        [CODataCenter changeMySumMoney:[CODataCenter meShouldPay:order.sum]];
    }

}

@end
