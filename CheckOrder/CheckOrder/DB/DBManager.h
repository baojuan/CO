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

- (BOOL)createTableForClasses:(NSArray *)classArray;

@end
