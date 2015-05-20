//
//  DBManager+CreateDBTable.h
//  CheckOrder
//
//  Created by baojuan on 15/5/20.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "DBManager.h"

@interface DBManager (CreateDBTable)
- (NSString *)createTableForClasses:(NSArray *)classArray;

@end
