//
//  NSObject+DateChange.h
//  CheckOrder
//
//  Created by baojuan on 15/6/10.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DateChange)
- (int)nowTime;

- (int)getDay:(int)time;
- (int)getMonth:(int)time;
- (int)getYear:(int)time;

- (NSString *)changeTimeToString:(int)time;

- (NSString *)changeTimeToMonthString:(int)time;
/**
 *  将yyyy-MM-dd 转成时间戳
 *
 *  @param string
 *
 *  @return 
 */
- (int)changeStringToTime:(NSString *)string;
@end
