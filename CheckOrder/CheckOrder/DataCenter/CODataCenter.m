//
//  CODataCenter.m
//  CheckOrder
//
//  Created by baojuan on 15/5/22.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "CODataCenter.h"

static NSString * kCOCoinToWho = @"kCOCoinToWho";
static NSString * kCOTaMoney = @"kCOTaMoney";
static NSString * kCOMyMoney = @"kCOMyMoney";
static NSString * kCOTaName = @"kCOTaName";
static NSString * kCOMyName = @"kCOMyName";

@implementation COAPPSetting

- (id)init
{
    if (self = [super init]) {
        self.coinToWho = COOrderCoinTypeMine;
        self.taName = @"Ta";
        self.myName = @"我";
        self.taOriginMoney = 0;
        self.myOriginMoney = 0;
    }
    return self;
}

@end



@implementation CODataCenter

+ (void)settingApp:(COAPPSetting *)setting
{
    [[NSUserDefaults standardUserDefaults] setValue:@(setting.taOriginMoney) forKey:kCOTaMoney];
    [[NSUserDefaults standardUserDefaults] setValue:@(setting.myOriginMoney) forKey:kCOMyMoney];
    [[NSUserDefaults standardUserDefaults] setValue:@(setting.coinToWho) forKey:kCOCoinToWho];
    [[NSUserDefaults standardUserDefaults] setValue:setting.myName forKey:kCOMyName];
    [[NSUserDefaults standardUserDefaults] setValue:setting.taName forKey:kCOTaName];
}


+ (COOrderCoinType)coinToWho
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kCOCoinToWho] integerValue];
}

+ (float)taSumMoney
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kCOTaMoney] floatValue];
}

+ (float)mySumMoney
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kCOMyMoney] floatValue];
}

+ (NSString *)taName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kCOTaName];
}

+ (NSString *)myName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kCOMyName];
}




+ (void)changeMySumMoney:(float)money
{
    float originMoney = [[[NSUserDefaults standardUserDefaults] objectForKey:kCOMyMoney] floatValue];
    originMoney += money;
    [[NSUserDefaults standardUserDefaults] setValue:@(originMoney) forKey:kCOMyMoney];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)changeTaSumMoney:(float)money
{
    float originMoney = [[[NSUserDefaults standardUserDefaults] objectForKey:kCOTaMoney] floatValue];
    originMoney += money;
    [[NSUserDefaults standardUserDefaults] setValue:@(originMoney) forKey:kCOTaMoney];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (float)taShouldPay:(float)orderMoney
{
    int a = 1;
    if (orderMoney < 0) {
        a = -1;
        orderMoney = a * orderMoney;
    }
    
    if ([CODataCenter coinToWho] != COOrderCoinTypeYours) {
        return (floor(orderMoney) / 2.0) * a;
    }
    else {
        NSLog(@"%f",floor(orderMoney));
        return (orderMoney - floor(orderMoney) / 2.0) * a;
    }
}

+ (float)meShouldPay:(float)orderMoney
{
    return orderMoney - [CODataCenter taShouldPay:orderMoney];
}

@end
