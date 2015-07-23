//
//  COCategorysController.m
//  CheckOrder
//
//  Created by baojuan on 15/7/22.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COCategorysController.h"
#import "COCategoryModel.h"
#import "DBManager.h"
#import "COCategorysCell.h"




@interface COCategorysController ()
@property (weak, nonatomic) IBOutlet WKInterfaceTable *table;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation COCategorysController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self readCategorys];
    // Configure interface objects here.
}
- (void)readCategorys
{
    [WKInterfaceController openParentApplication:@{@"type":@"categorys"} reply:^(NSDictionary *replyInfo, NSError *error) {
        NSArray *array = [replyInfo valueForKey:@"categorys"];
        NSMutableArray *resultArray = [NSMutableArray new];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            COCategoryModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
            [resultArray addObject:model];
        }];
        self.dataArray = resultArray;
    }];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSInteger count = [self.dataArray count] % 2 == 0 ? [self.dataArray count] / 2:[self.dataArray count] / 2 + 1;
    [self.table setNumberOfRows:count withRowType:@"MyTableRowController"];

    for (int i = 0; i < count; i++) {
        COCategorysCell *cell = [self.table rowControllerAtIndex:i];
        COCategoryModel *model1 = self.dataArray[i*2];
        cell.model1 = model1;
        [cell.firstImage setImage:[UIImage imageNamed:[self iconName:[NSString stringWithFormat:@"%d",model1.icon]]]];
        [cell.firstTitle setText:model1.name];

        if (i * 2 + 1 < [self.dataArray count]) {
            COCategoryModel *model2 = self.dataArray[i*2+1];
            cell.model2 = model2;
            [cell.secondButton setHidden:NO];
            [cell.secondImage setImage:[UIImage imageNamed:[self iconName:[NSString stringWithFormat:@"%d",model2.icon]]]];
            [cell.secondTitle setText:model2.name];
        }
        else {
            [cell.secondButton setHidden:YES];
            cell.model2 = nil;
        }
    }
}

- (NSString *)iconName:(NSString *)key
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"categoryIcon" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return [dict valueForKey:key];
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


@end



