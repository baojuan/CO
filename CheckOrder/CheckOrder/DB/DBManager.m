//
//  DBManager.m
//  CheckOrder
//
//  Created by baojuan on 15/5/19.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "DBManager.h"
#import "COCategoryModel.h"
#import "COOrderModel.h"

@interface DBManager ()
@property (nonatomic, strong) FMDatabase *db;
@end


@implementation DBManager

+ (DBManager *)shareDB
{
    static DBManager *st = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        st = [[DBManager alloc] init];
    });
    return st;
}

- (id)init
{
    if (self = [super init]) {
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentDirectory = [directoryPaths objectAtIndex:0];
        //定义记录文件全名以及路径的字符串filePath
        NSString *filePath = [documentDirectory stringByAppendingPathComponent:dbName];
        
//#warning 测试代码
//        [fileManager removeItemAtPath:filePath error:nil];
//#pragma -
        
        //查找文件，如果不存在，就创建一个文件
        if (![fileManager fileExistsAtPath:filePath]) {
            [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        }
        self.db = [FMDatabase databaseWithPath:filePath];
        [self.db open];
        [self.db setShouldCacheStatements:NO];

    }
    return self;
}

- (BOOL)createTable
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS COCategory (categoryId int, name varchar(8),   type tinyint, icon tinyint,  updateTime int); \n CREATE TABLE IF NOT EXISTS COOrder (orderId int,  category tinyint, sum float,  orderTime int,   updateTime int, day tinyint,    month tinyint,  year tinyint,   type tinyint,   ps varchar(255))";
    return [self.db executeStatements:sql];
}


#pragma mark - category

- (BOOL)insertCategoryData:(id)obj
{
    COCategoryModel *model = obj;
    if ([model isKindOfClass:[COCategoryModel class]]) {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO COCategory (categoryId, name, type, icon, updateTime) VALUES (%d, '%@', %hd, %hd, %d)",model.categoryId,model.name, model.type, model.icon, model.updateTime];
        return [self.db executeUpdate:sql];
    }
    return NO;
}

- (BOOL)deleteCategoryData:(id)obj
{
    COCategoryModel *model = obj;
    if ([model isKindOfClass:[COCategoryModel class]]) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM COCategory WHERE categoryId=%d",model.categoryId];
        return [self.db executeUpdate:sql];
    }
    return NO;
}

- (BOOL)updateCategoryData:(id)obj
{
    COCategoryModel *model = obj;
    if ([model isKindOfClass:[COCategoryModel class]]) {
        NSString *sql = [NSString stringWithFormat:@"UPDATE COCategory SET name='%@', type=%hd, icon=%hd, updateTime=%d WHERE categoryId=%d",model.name,model.type,model.icon,model.updateTime,model.categoryId];
        return [self.db executeUpdate:sql];
    }
    return NO;
}

- (NSArray *)selectCategoryData:(id)obj
{
    COCategoryModel *model = obj;
    if (![model isKindOfClass:[COCategoryModel class]] || [model isEmptyModel]) {
        return nil;
    }
    NSDictionary *selectDict = [model changeModelToDictionary];
    NSMutableString *where = [[NSMutableString alloc] init];
    [selectDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [where appendString:[NSString stringWithFormat:@"%@=%@ and ",key,obj]];
    }];
    if (where.length > 0) {
        [where deleteCharactersInRange:NSMakeRange([where length] -5, 5)];
    }
    if (where) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM COCategory WHERE %@",where];
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        FMResultSet *result = [self.db executeQuery:sql];
        while (result.next) {
            COCategoryModel *model = [[COCategoryModel alloc] init];
            model.categoryId = [result intForColumn:@"categoryId"];
            model.name = [result stringForColumn:@"name"];
            model.type = [result intForColumn:@"type"];
            model.icon = [result intForColumn:@"icon"];
            model.updateTime = [result intForColumn:@"updateTime"];
            [resultArray addObject:model];
        }
        return resultArray;
    }
    return nil;
}

#pragma mark - order

- (BOOL)insertOrderData:(id)obj
{
    COOrderModel *model = obj;
    if ([model isKindOfClass:[COOrderModel class]]) {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO COOrder (orderId, category, sum, orderTime, updateTime, day, month, year, type, ps) VALUES (%d, %d, %f, %d, %d, %d, %hd, %hd, %hd, '%@')",model.orderId,model.category.categoryId, model.sum, model.orderTime, model.updateTime, model.day, model.month, model.year, model.type, model.ps];
        BOOL result = [self.db executeUpdate:sql];
        return result;
    }
    return NO;
}

- (BOOL)deleteOrderData:(id)obj
{
    COOrderModel *model = obj;
    if ([model isKindOfClass:[COOrderModel class]]) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM COOrder WHERE orderId=%d",model.orderId];
        return [self.db executeUpdate:sql];
    }
    return NO;
}

- (BOOL)updateOrderData:(id)obj
{
    COOrderModel *model = obj;
    if ([model isKindOfClass:[COOrderModel class]]) {
        NSString *sql = [NSString stringWithFormat:@"UPDATE COOrder SET category=%d, sum=%f, orderTime=%d, updateTime=%d, day=%hd, month=%hd, year=%hd, type=%hd, ps='%@' WHERE orderId=%d",model.category.categoryId,model.sum,model.orderTime,model.updateTime,model.day, model.month, model.year, model.type, model.ps, model.orderId];
        return [self.db executeUpdate:sql];
    }
    return NO;
}

- (NSArray *)selectOrderData:(id)obj
{
    COOrderModel *model = obj;
    if (![model isKindOfClass:[COOrderModel class]]) {
        return nil;
    }
    NSDictionary *selectDict = [model changeModelToDictionary];
    
    NSMutableString *where = [[NSMutableString alloc] init];
    [selectDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![key isEqualToString:@"sum"]) {
            [where appendString:[NSString stringWithFormat:@"%@=%@ and ",key,obj]];
        }
    }];
    if (where.length > 0) {
        [where deleteCharactersInRange:NSMakeRange([where length] -5, 5)];
    }
    if (where) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM COOrder WHERE %@ ORDER BY orderTime DESC",where];
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        FMResultSet *result = [self.db executeQuery:sql];
        while (result.next) {
            COOrderModel *model = [[COOrderModel alloc] init];
            model.orderId = [result intForColumn:@"orderId"];
            COCategoryModel *category = [COCategoryModel new];
            category.categoryId = [result intForColumn:@"category"];
            model.category = [[self selectCategoryData:category] firstObject];
            model.sum = [result doubleForColumn:@"sum"];
            model.orderTime = [result intForColumn:@"orderTime"];
            model.updateTime = [result intForColumn:@"updateTime"];
            model.day = [result intForColumn:@"day"];
            model.month = [result intForColumn:@"month"];
            model.year = [result intForColumn:@"year"];
            model.type = [result intForColumn:@"type"];
            model.ps = [result stringForColumn:@"ps"];
            if (model.ps.length == 0) {
                model.ps = @"";
            }
            [resultArray addObject:model];
        }
        return resultArray;
    }
    return nil;
}


@end
