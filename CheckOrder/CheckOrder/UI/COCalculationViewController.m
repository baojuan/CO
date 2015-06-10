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
#import "NSObject+DateChange.h"

@interface COCalculationViewController ()
@property (weak, nonatomic) IBOutlet COCalculationView *calculation;
@property (weak, nonatomic) IBOutlet COCategoryView *inCategoryView;
@property (weak, nonatomic) IBOutlet COCategoryView *outCategoryView;
@property (strong, nonatomic) COCategoryModel * selectedCategory;
@property (assign, nonatomic) NSInteger orderType;
@property (copy, nonatomic) NSString *ps;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end

@implementation COCalculationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.selectedCategory = nil;
    self.orderType = 1;
    self.segment.selectedSegmentIndex = 1;
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
        if (!self.selectedCategory) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选择分类" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return ;
        }
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
        CGFloat sum = [self.calculation getSumPrice];
        if (order.category.type == 1) {
            sum = sum * -1;
        }
        order.sum = sum;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kAddOrderNotification" object:order];
        
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           [[DBManager shareDB] insertOrderData:order];
//        });
        
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segmentSelected:(UISegmentedControl *)seg
{
    self.orderType = seg.selectedSegmentIndex;
}
- (IBAction)closeButtonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
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
