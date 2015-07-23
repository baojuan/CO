//
//  COCategorysCell.m
//  CheckOrder
//
//  Created by baojuan on 15/7/23.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COCategorysCell.h"
#import "COWatchDataCenter.h"

@implementation COCategorysCell
- (IBAction)firstButtonClick {
    WatchCenter.model.category = self.model1;
}
- (IBAction)secondButtonClick {
    WatchCenter.model.category = self.model2;
}

@end
