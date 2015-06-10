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

@end
