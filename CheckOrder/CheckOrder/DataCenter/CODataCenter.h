//
//  CODataCenter.h
//  CheckOrder
//
//  Created by baojuan on 15/5/22.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(short, COOrderCoinType)
{
    COOrderCoinTypeYours = 0,
    COOrderCoinTypeMine = 1,
};

@interface COAPPSetting : NSObject
@property (nonatomic, assign) COOrderCoinType coinToWho;
@property (nonatomic, copy) NSString * taName;
@property (nonatomic, copy) NSString * myName;
@property (nonatomic, assign) float taOriginMoney;
@property (nonatomic, assign) float myOriginMoney;

@end


@interface CODataCenter : NSObject

+ (void)settingApp:(COAPPSetting *)setting;

+ (COOrderCoinType)coinToWho;
+ (float)taSumMoney;
+ (float)mySumMoney;

+ (NSString *)taName;
+ (NSString *)myName;

+ (void)changeMySumMoney:(float)money;
+ (void)changeTaSumMoney:(float)money;

//计算一笔账单每人该付多少钱
+ (float)taShouldPay:(float)orderMoney;
+ (float)meShouldPay:(float)orderMoney;

@end
