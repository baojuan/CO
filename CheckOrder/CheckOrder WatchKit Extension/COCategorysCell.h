//
//  COCategorysCell.h
//  CheckOrder
//
//  Created by baojuan on 15/7/23.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>
#import "COCategoryModel.h"

@interface COCategorysCell : NSObject
@property (nonatomic, strong)COCategoryModel *model1;
@property (nonatomic, strong)COCategoryModel *model2;

@property (weak, nonatomic) IBOutlet WKInterfaceButton *firstButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *secondButton;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *firstImage;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *firstTitle;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *secondImage;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *secondTitle;

@end
