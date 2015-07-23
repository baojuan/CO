//
//  COWatchDataCenter.m
//  CheckOrder
//
//  Created by baojuan on 15/7/22.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COWatchDataCenter.h"
static COWatchDataCenter * st_center = nil;
@implementation COWatchDataCenter
+ (COWatchDataCenter *)share
{
    if (!st_center) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            st_center = [COWatchDataCenter new];
        });
    }
    return st_center;
}
- (COOrderModel *)model
{
    if (!_model) {
        _model = [COOrderModel new];
    }
    return _model;
}

- (void)cleanModel
{
    _model = nil;
}
- (void)configWithOriginDataTaName:(NSString *)taName myName:(NSString *)myName taMoney:(float)taMoney myMoney:(float)myMoney
{
    _taName = taName;
    _myName = myName;
    _taMoney = taMoney;
    _myMoney = myMoney;
}

@end
