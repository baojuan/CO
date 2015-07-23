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

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [super encodeWithCoder:encoder];//不要忘了这个
    [encoder encodeInt:self.orderId forKey:@"orderId"];
    [encoder encodeObject:self.category forKey:@"category"];
    [encoder encodeFloat:self.sum forKey:@"sum"];
    [encoder encodeInt:self.type forKey:@"type"];
    [encoder encodeInt:self.orderTime forKey:@"orderTime"];
    [encoder encodeInt:self.updateTime forKey:@"updateTime"];
    [encoder encodeInt:self.year forKey:@"year"];
    [encoder encodeInt:self.month forKey:@"month"];
    [encoder encodeInt:self.day forKey:@"day"];
    [encoder encodeObject:self.ps forKey:@"ps"];


}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];//不要忘了这个
    self.orderId = [aDecoder decodeIntForKey:@"orderId"];
    self.category = [aDecoder decodeObjectForKey:@"category"];
    self.sum = [aDecoder decodeFloatForKey:@"sum"];
    self.type = [aDecoder decodeIntForKey:@"type"];
    self.orderTime = [aDecoder decodeIntForKey:@"orderTime"];
    self.updateTime = [aDecoder decodeIntForKey:@"updateTime"];
    self.year = [aDecoder decodeIntForKey:@"year"];
    self.month = [aDecoder decodeIntForKey:@"month"];
    self.day = [aDecoder decodeIntForKey:@"day"];
    self.ps = [aDecoder decodeObjectForKey:@"ps"];
    
    return self;
}


@end