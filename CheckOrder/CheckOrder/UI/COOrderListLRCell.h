//
//  COOrderListLRCell.h
//  CheckOrder
//
//  Created by baojuan on 15/5/21.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COOrderCell.h"

@interface COOrderListLRCell : COOrderCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightDesLabel;
@end
