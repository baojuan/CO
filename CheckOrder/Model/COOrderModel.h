//
//  OrderModel.h
//  CheckOrder
//
//  Created by baojuan on 15/5/19.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COModel.h"
#import "COCategoryModel.h"

typedef NS_ENUM(short, COOrderType)
{
    COOrderTypeDefault = -1,
    COOrderTypeYours = 0,
    COOrderTypeOurs = 1,
    COOrderTypeMine = 2,
    COOrderTypeError = 3,
};

@interface COOrderModel : COModel
@property (nonatomic, assign) int orderId;
/**
 *  你 我 共同
 */
@property (nonatomic, assign) COOrderType type;
@property (nonatomic, strong) COCategoryModel * category;
@property (nonatomic, assign) float sum;
/**
 *  备注
 */
@property (nonatomic, copy) NSString * ps;
@property (nonatomic, assign) short year;
@property (nonatomic, assign) short month;
@property (nonatomic, assign) short day;
/**
 *  order 时间 时间戳
 */
@property (nonatomic, assign) int orderTime;
/**
 *  更新时间 时间戳
 */
@property (nonatomic, assign) int updateTime;

@end
