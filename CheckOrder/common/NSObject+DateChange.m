//
//  NSObject+DateChange.m
//  CheckOrder
//
//  Created by baojuan on 15/6/10.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "NSObject+DateChange.h"

@implementation NSObject (DateChange)
- (int)nowTime
{
    return [[NSDate date] timeIntervalSince1970];
}

- (int)getDay:(int)time
{
    NSString *string = [self changeTimeToString:time];
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSArray *resultArray = [array[0] componentsSeparatedByString:@"-"];
    return [resultArray[2] intValue];
}
- (int)getMonth:(int)time
{
    NSString *string = [self changeTimeToString:time];
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSArray *resultArray = [array[0] componentsSeparatedByString:@"-"];
    return [resultArray[1] intValue];
}
- (int)getYear:(int)time
{
    NSString *string = [self changeTimeToString:time];
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSArray *resultArray = [array[0] componentsSeparatedByString:@"-"];
    return [resultArray[0] intValue];
}

- (NSString *)changeTimeToString:(int)time
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",date);
    return [formatter stringFromDate:date];
}
- (NSString *)changeTimeToMonthString:(int)time
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",date);
    return [formatter stringFromDate:date];
}

- (int)changeStringToTime:(NSString *)string
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [formatter dateFromString:string];
    return [date timeIntervalSince1970];

}

@end
