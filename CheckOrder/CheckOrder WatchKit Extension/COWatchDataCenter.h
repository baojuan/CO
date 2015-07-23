//
//  COWatchDataCenter.h
//  CheckOrder
//
//  Created by baojuan on 15/7/22.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COOrderModel.h"

#define WatchCenter [COWatchDataCenter share]
@interface COWatchDataCenter : NSObject
+ (COWatchDataCenter *)share;

@property (nonatomic, strong)COOrderModel *model;

- (void)cleanModel;

@property (nonatomic, copy, readonly)NSString *taName;
@property (nonatomic, copy, readonly)NSString *myName;
@property (nonatomic, assign, readonly)float taMoney;
@property (nonatomic, assign, readonly)float myMoney;

- (void)configWithOriginDataTaName:(NSString *)taName myName:(NSString *)myName taMoney:(float)taMoney myMoney:(float)myMoney;
@end
