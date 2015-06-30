//
//  COMonthStatisticsCell.m
//  CheckOrder
//
//  Created by baojuan on 15/6/30.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COMonthStatisticsCell.h"

@interface COMonthStatisticsCell ()
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UILabel *taLabel;
@property (weak, nonatomic) IBOutlet UILabel *ourLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainLabel;

@end

@implementation COMonthStatisticsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
