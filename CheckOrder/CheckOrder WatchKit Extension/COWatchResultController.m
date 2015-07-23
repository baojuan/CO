//
//  COWatchResultController.m
//  CheckOrder
//
//  Created by baojuan on 15/7/23.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COWatchResultController.h"
#import "COWatchDataCenter.h"
#import "DBManager.h"
#import "NSObject+DateChange.h"

@interface COWatchResultController ()
@property (weak, nonatomic) IBOutlet WKInterfaceImage *categoryImage;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *priceLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *categoryTitle;

@end

@implementation COWatchResultController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self.categoryImage setImage:[UIImage imageNamed:[self iconName:[NSString stringWithFormat:@"%d",WatchCenter.model.category.icon]]]];
    [self.categoryTitle setText:WatchCenter.model.category.name];
    [self.priceLabel setText:[NSString stringWithFormat:@"￥%.2f",WatchCenter.model.sum]];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)okButtonClick
{
    COOrderModel *order = WatchCenter.model;
    int now = [self nowTime];
    order.orderId = now;
    order.orderTime = now;
    order.year = [self getYear:now];
    order.month = [self getMonth:now];
    order.day = [self getDay:now];
    order.ps = @"";
    CGFloat sum = order.sum;
    if (order.category.type == 1) {
        sum = sum * -1;
    }
    order.sum = sum;

    NSUserDefaults *userdefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.checkorder.watch"];
    NSArray *orders = [userdefault valueForKey:@"WatchOrders"];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:orders];
    [array addObject:[NSKeyedArchiver archivedDataWithRootObject:order]];
    [userdefault setValue:array forKey:@"WatchOrders"];
    [userdefault synchronize];
    
    [self dismissController];


}

- (NSString *)iconName:(NSString *)key
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"categoryIcon" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return [dict valueForKey:key];
}


@end



