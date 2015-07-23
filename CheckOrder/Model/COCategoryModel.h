//
//  CategoryModel.h
//  CheckOrder
//
//  Created by baojuan on 15/5/19.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COModel.h"

@interface COCategoryModel : COModel<NSCoding>
@property (nonatomic, assign) int categoryId;
@property (nonatomic, copy) NSString * name;
/**
 *  0 表示收入  1表示支出
 */
@property (nonatomic, assign) short type;
@property (nonatomic, assign) short icon;
@property (nonatomic, assign) int updateTime;
@end
