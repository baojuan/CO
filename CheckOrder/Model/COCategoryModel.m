//
//  CategoryModel.m
//  CheckOrder
//
//  Created by baojuan on 15/5/19.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COCategoryModel.h"

@implementation COCategoryModel
- (id)init
{
    if (self = [super init]) {
        self.categoryId = -1;
        self.name = nil;
        self.type = -1;
        self.icon = -1;
        self.updateTime = -1;
    }
    return self;
}
- (BOOL)isEmptyModel
{
    if (self.categoryId != -1) {
        return NO;
    }
    if (self.type != -1) {
        return NO;
    }
    return YES;
}
- (NSDictionary *)changeModelToDictionary
{
    NSMutableDictionary *resultDict = [NSMutableDictionary new];
    if (self.categoryId != -1) {
        [resultDict setValue:@(self.categoryId) forKey:@"categoryId"];
    }
    if (self.name.length > 0) {
        [resultDict setValue:self.name forKey:@"name"];
    }
    if (self.type != -1) {
        [resultDict setValue:@(self.type) forKey:@"type"];
    }
    if (self.icon != -1) {
        [resultDict setValue:@(self.icon) forKey:@"icon"];
    }
    if (self.updateTime != -1) {
        [resultDict setValue:@(self.updateTime) forKey:@"updateTime"];
    }
    return resultDict;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [super encodeWithCoder:encoder];//不要忘了这个
    [encoder encodeInt:self.categoryId forKey:@"categoryId"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeInt:self.type forKey:@"type"];
    [encoder encodeInt:self.icon forKey:@"icon"];
    [encoder encodeInt:self.updateTime forKey:@"updateTime"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];//不要忘了这个
    self.categoryId = [aDecoder decodeIntForKey:@"categoryId"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.type = [aDecoder decodeIntForKey:@"type"];
    self.icon = [aDecoder decodeIntForKey:@"icon"];
    self.updateTime = [aDecoder decodeIntForKey:@"updateTime"];
    
    
    return self;
}
@end
