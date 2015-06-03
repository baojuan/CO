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

@interface COCalculationViewController ()
@property (weak, nonatomic) IBOutlet COCalculationView *calculation;

@end

@implementation COCalculationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
