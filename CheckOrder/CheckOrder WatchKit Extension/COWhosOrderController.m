//
//  COWhosOrderController.m
//  CheckOrder
//
//  Created by baojuan on 15/7/22.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COWhosOrderController.h"
#import "COWatchDataCenter.h"

@interface COWhosOrderController ()
@property (weak, nonatomic) IBOutlet WKInterfaceButton *taButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *myButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *ourButton;

@end

@implementation COWhosOrderController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    if (WatchCenter.model.orderId != -1) {
        [self dismissController];
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)taButtonClick
{
    WatchCenter.model.type = COOrderTypeYours;
    [self presentControllerWithNames:@[@"COCategorysController",@"COWatchCalculationController",@"COWatchResultController"] contexts:nil];
}

- (IBAction)myButtonClick
{
    WatchCenter.model.type = COOrderTypeMine;
    [self presentControllerWithNames:@[@"COCategorysController",@"COWatchCalculationController",@"COWatchResultController"] contexts:nil];

}

- (IBAction)oursButtonClick
{
    WatchCenter.model.type = COOrderTypeOurs;
    [self presentControllerWithNames:@[@"COCategorysController",@"COWatchCalculationController",@"COWatchResultController"] contexts:nil];
}

@end



