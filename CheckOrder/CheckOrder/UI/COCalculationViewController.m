//
//  COCalculationViewController.m
//  CheckOrder
//
//  Created by baojuan on 15/6/2.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COCalculationViewController.h"
#import "COCalculationView.h"
#import "COCategoryView.h"
#import "DBManager.h"
#import "COCategoryModel.h"
#import "COOrderModel.h"
#import "DBManager.h"

@interface COCalculationViewController ()
@property (weak, nonatomic) IBOutlet COCalculationView *calculation;
@property (weak, nonatomic) IBOutlet COCategoryView *inCategoryView;
@property (weak, nonatomic) IBOutlet COCategoryView *outCategoryView;
@property (strong, nonatomic) COCategoryModel * selectedCategory;
@property (assign, nonatomic) NSInteger orderType;
@property (copy, nonatomic) NSString *ps;
@end

@implementation COCalculationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.selectedCategory = nil;
    self.orderType = -1;
    [self configCategoryView];
    [self configCalculationView];
}


- (void)configCategoryView
{
    COCategoryModel *model = [COCategoryModel new];
    model.type = 0;
    NSArray *inArray = [[DBManager shareDB] selectCategoryData:model];
    [self.inCategoryView insertIntoCategoryArray:inArray];
    
    model.type = 1;
    NSArray *outArray = [[DBManager shareDB] selectCategoryData:model];
    [self.outCategoryView insertIntoCategoryArray:outArray];
    
    
    
    self.inCategoryView.categoryClick = ^(COCategoryModel *model){
        self.selectedCategory = model;
        [self.calculation setCategoryText:model.name];
    };
    
    self.outCategoryView.categoryClick = ^(COCategoryModel *model){
        self.selectedCategory = model;
        [self.calculation setCategoryText:model.name];
    };
}

- (void)configCalculationView
{
    self.calculation.okButtonHandle = ^(){
        COOrderModel *order = [COOrderModel new];
        int now = [self nowTime];
        order.orderId = now;
        order.category = self.selectedCategory;
        order.orderTime = now;
        order.type = self.orderType;
        order.year = [self getYear:now];
        order.month = [self getMonth:now];
        order.day = [self getDay:now];
        order.ps = self.ps;
        [[DBManager shareDB] insertOrderData:order];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeButtonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}

- (int)nowTime
{
    return [[NSDate date] timeIntervalSince1970];
}

- (int)getDay:(int)time
{
    NSString *string = [self changeTimeToString:time];
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSArray *resultArray = [array[0] componentsSeparatedByString:@"-"];
    return [resultArray[2] intValue];
}
- (int)getMonth:(int)time
{
    NSString *string = [self changeTimeToString:time];
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSArray *resultArray = [array[0] componentsSeparatedByString:@"-"];
    return [resultArray[1] intValue];
}
- (int)getYear:(int)time
{
    NSString *string = [self changeTimeToString:time];
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSArray *resultArray = [array[0] componentsSeparatedByString:@"-"];
    return [resultArray[0] intValue];
}

- (NSString *)changeTimeToString:(int)time
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",date);
    return [formatter stringFromDate:date];
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
