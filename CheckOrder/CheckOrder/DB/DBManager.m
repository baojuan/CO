//
//  DBManager.m
//  CheckOrder
//
//  Created by baojuan on 15/5/19.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "DBManager.h"
#import <objc/runtime.h>

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

- (BOOL)createTableForClasses:(NSArray *)classArray
{
    NSDictionary *tableDict = [self sqlTableDictionary:classArray];
    
    NSMutableString *sql = [[NSMutableString alloc] init];

    
    [tableDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSDictionary *attributeDict = obj;
        if ([attributeDict isKindOfClass:[NSDictionary class]]) {
            NSMutableString *attributeSQL = [[NSMutableString alloc] init];

            [attributeDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [attributeSQL appendString:[NSString stringWithFormat:@"%@ %@,",key,obj]];
            }];
            if (attributeDict) {
                [attributeSQL deleteCharactersInRange:NSMakeRange([attributeSQL length] - 1, 1)];
                NSString *createTableString = [[NSString alloc] initWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@);\n",key,attributeSQL];
                
                [sql appendString:createTableString];
            }
        }
    }];
    
    [self.db executeStatements:sql withResultBlock:^int(NSDictionary *resultsDictionary) {
        NSLog(@"1q23");
        return 0;
    }];
    
    
    
    return YES;
}




#pragma mark - private method
- (NSString *)sqlKeyAttribute:(NSString *)attribute
{
    NSArray *array = [attribute componentsSeparatedByString:@","];
    __block NSString *sqlAttribute = nil;
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            NSString *first = obj;
            NSRange tiRange = [first rangeOfString:@"Ti"];
            if (tiRange.length != 0) {
                sqlAttribute = @"int";
                return ;
            }
            NSRange tsRange = [first rangeOfString:@"Ts"];
            if (tsRange.length != 0) {
                sqlAttribute = @"tinyint";
                return ;
            }
            NSRange stringRange = [first rangeOfString:@"NSString"];
            if (stringRange.length != 0) {
                sqlAttribute = @"varchar";
            }
        }
        if (idx == 1) {
            NSString *second = obj;
            NSRange range = [second rangeOfString:@"&"];
            if (range.length != 0) {
                sqlAttribute = @"tinyint"; //自定义类型 只存id
                return ;
            }
        }
    }];
    return sqlAttribute;
}

- (NSDictionary *)sqlTableDictionary:(NSArray *)classArray
{
    NSMutableDictionary *tableDict = [[NSMutableDictionary alloc] init];
    
    [classArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        NSString *className = obj;
        if ([className isKindOfClass:[NSString class]]) {
            unsigned int outCount, i;
            objc_property_t *properties = class_copyPropertyList(NSClassFromString(className), &outCount);
            for (i=0; i<outCount; i++) {
                objc_property_t property = properties[i];
                NSString * key = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
                NSString * attribute = [[NSString alloc]initWithCString:property_getAttributes(property)  encoding:NSUTF8StringEncoding];
                [dict setValue:[self sqlKeyAttribute:attribute] forKey:key];
            }
            NSString *tableName = [[className componentsSeparatedByString:@"Model"] firstObject];
            [tableDict setValue:dict forKey:tableName];
        }
        
    }];
    return tableDict;
}

@end
