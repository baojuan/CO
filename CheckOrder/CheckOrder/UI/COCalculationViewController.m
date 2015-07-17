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
    
    self.selectedCategory = self.updateOrder.category;
    self.orderType = self.updateOrder.type;
    self.ps = self.updateOrder.ps;
    self.segment.selectedSegmentIndex = self.orderType;
    [self configCategoryView];
    [self configCalculationView];
    
    
    if (self.updateOrder) {
        if (self.selectedCategory.type == 0) {
            [self.calculation setCategoryText:self.selectedCategory.name];
        }
        else {
            [self.calculation setCategoryText:self.selectedCategory.name];
        }
        [self.calculation sumPrice:fabs(self.updateOrder.sum)];
    }

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
        if (!self.updateOrder) {
            COOrderModel *order = [COOrderModel new];
            int now = [self nowTime];
            order.orderId = now;
            order.category = self.selectedCategory;
            order.orderTime = now;
            order.type = self.orderType;
            order.year = [self getYear:now];
            order.month = [self getMonth:now];
            order.day = [self getDay:now];
            if (self.ps == nil) {
                self.ps = @"";
            }
            order.ps = self.ps;
            CGFloat sum = [self.calculation getSumPrice];
            if (order.category.type == 1) {
                sum = sum * -1;
            }
            order.sum = sum;
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                if ([[DBManager shareDB] insertOrderData:order]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"kAddOrderNotification" object:order];
                    });
                }
            });
        }
        else {
            COOrderModel *order = [COOrderModel new];
            order.orderId = self.updateOrder.orderId;
            order.category = self.selectedCategory;
            order.orderTime = self.updateOrder.orderTime;
            order.type = self.orderType;
            order.year = self.updateOrder.year;
            order.month = self.updateOrder.month;
            order.day = self.updateOrder.day;
            if (self.ps == nil) {
                self.ps = @"";
            }
            order.ps = self.ps;
            CGFloat sum = [self.calculation getSumPrice];
            if (order.category.type == 1) {
                sum = sum * -1;
            }
            order.sum = sum;

            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                if ([[DBManager shareDB] updateOrderData:order]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateOrderNotification" object:order];
                    });

                }
            });
        }
        
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateOrderNotification" object:nil];
    }];
}
- (IBAction)psButtonClick:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"备注" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"备注";
        textField.text = self.ps;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *field = alert.textFields[0];
        self.ps = field.text;
        [alert dismissViewControllerAnimated:YES completion:^{
            ;
        }];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
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
