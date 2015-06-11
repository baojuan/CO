//
//  COOrderListLeftCell.h
//  CheckOrder
//
//  Created by baojuan on 15/5/21.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COOrderCell.h"

@interface COOrderListLeftCell : COOrderCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@end
