//
//  CODataCenter.m
//  CheckOrder
//
//  Created by baojuan on 15/5/22.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "CODataCenter.h"
#import "COOrderModel.h"
#import "NSObject+DateChange.h"
#import "DBManager.h"


static NSString * const kCOFirstInApp = @"kCOFirstInApp";

static NSString * const kCOCoinToWho = @"kCOCoinToWho";
static NSString * const kCOTaMoney = @"kCOTaMoney";
static NSString * const kCOMyMoney = @"kCOMyMoney";
static NSString * const kCOTaName = @"kCOTaName";
static NSString * const kCOMyName = @"kCOMyName";


//statistics
NSString * const kCOMonthCost = @"kCOMonthCost";


NSString * const kCODate = @"kCODate";

NSString * const kCOMyMonthCost = @"kCOMyMonthCost";
NSString * const kCOTaMonthCost = @"kCOTaMonthCost";
NSString * const kCOOurMonthCost = @"kCOOurMonthCost";


static CODataCenter *st_dataCenter = nil;

#define DataCenterShare [CODataCenter share]

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


+ (COAPPSetting *)share
{
    if (!st_dataCenter) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            st_dataCenter = [[CODataCenter alloc] init];
        });
    }
    return st_dataCenter;
}


+ (BOOL)isFirstOpenApp
{
    return ![[[NSUserDefaults standardUserDefaults] valueForKey:kCOFirstInApp] boolValue];
}

+ (void)firstOpenApp
{
    [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:kCOFirstInApp];
}

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




+ (void)calculationMonthCost
{
    int now = [DataCenterShare nowTime];
    NSString *nowMonth = [DataCenterShare changeTimeToMonthString:now];
    NSArray * array = [[NSUserDefaults standardUserDefaults] valueForKey:kCOMonthCost];
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithArray:array];
    if ([array count] > 0) {
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *dict = obj;
            NSString *date = [dict valueForKey:kCODate];
            if ([date isEqualToString:nowMonth]) {
                NSDictionary *dict = [CODataCenter getNowMonthData:now];
                [resultArray replaceObjectAtIndex:idx withObject:dict];
                *stop = YES;
            }
        }];
    }
    [[NSUserDefaults standardUserDefaults] setValue:resultArray forKey:kCOMonthCost];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSDictionary *)getNowMonthData:(int)now
{
    NSString *nowMonth = [DataCenterShare changeTimeToMonthString:now];
    COOrderModel *model = [COOrderModel new];
    model.year = [DataCenterShare getYear:now];
    model.month = [DataCenterShare getMonth:now];
    
    NSArray *array = [[DBManager shareDB] selectOrderData:model];
    __block float myCost = 0;
    __block float taCost = 0;
    __block float ourCost = 0;

    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        COOrderModel *model = obj;
        if (model.sum < 0) { //只计算消费
            if (model.type == COOrderTypeYours) {
                taCost += model.sum;
            }
            else if (model.type == COOrderTypeMine) {
                myCost += model.sum;
            }
            else if (model.type == COOrderTypeOurs) {
                ourCost += model.sum;
            }
        }
    }];
    NSDictionary *dict = @{kCODate:nowMonth,kCOMyMonthCost:@(myCost),kCOTaMonthCost:@(taCost),kCOOurMonthCost:@(ourCost)};
    return dict;

}

@end
