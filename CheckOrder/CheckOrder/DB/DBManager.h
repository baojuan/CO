//
//  DBManager.h
//  CheckOrder
//
//  Created by baojuan on 15/5/19.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

static NSString *dbName = @"CODB.db";

@interface DBManager : NSObject
@property (nonatomic, strong)NSString *test;
+ (DBManager *)shareDB;
- (BOOL)createTable;

#pragma mark - category data
- (BOOL)insertCategoryData:(id)obj;
- (BOOL)deleteCategoryData:(id)obj;
- (BOOL)updateCategoryData:(id)obj;
- (NSArray *)selectCategoryData:(NSDictionary *)selectDict;


#pragma mark - order data
- (BOOL)insertOrderData:(id)obj;
- (BOOL)deleteOrderData:(id)obj;
- (BOOL)updateOrderData:(id)obj;
- (NSArray *)selectOrderData:(NSDictionary *)selectDict;


@end
