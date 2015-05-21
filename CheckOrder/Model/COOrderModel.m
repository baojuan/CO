//
//  OrderModel.m
//  CheckOrder
//
//  Created by baojuan on 15/5/19.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COOrderModel.h"

@implementation COOrderModel
- (id)init
{
    if (self = [super init]) {
        self.orderId = -1;
        self.category = nil;
        self.sum = 0;
        self.ps = nil;
        self.type = COOrderTypeDefault;
        self.orderTime = -1;
        self.updateTime = -1;
        self.year = -1;
        self.month = -1;
        self.day = -1;
    }
    return self;
}
- (BOOL)isEmptyModel
{
    if (self.orderId != -1) {
        return NO;
    }
    return YES;
}
- (NSDictionary *)changeModelToDictionary
{
    NSMutableDictionary *resultDict = [NSMutableDictionary new];
    if (self.orderId != -1) {
        [resultDict setValue:@(self.orderId) forKey:@"orderId"];
    }
    if (self.category) {
        [resultDict setValue:self.category forKey:@"category"];
    }
    if (self.sum != -1) {
        [resultDict setValue:@(self.sum) forKey:@"sum"];
    }
    if (self.type != COOrderTypeDefault) {
        [resultDict setValue:@(self.type) forKey:@"type"];
    }
    if (self.orderTime != -1) {
        [resultDict setValue:@(self.orderTime) forKey:@"orderTime"];
    }
    if (self.updateTime != -1) {
        [resultDict setValue:@(self.updateTime) forKey:@"updateTime"];
    }
    if (self.year != -1) {
        [resultDict setValue:@(self.year) forKey:@"year"];
    }
    if (self.month != -1) {
        [resultDict setValue:@(self.month) forKey:@"month"];
    }
    if (self.day != -1) {
        [resultDict setValue:@(self.day) forKey:@"day"];
    }
    return resultDict;
}

@end