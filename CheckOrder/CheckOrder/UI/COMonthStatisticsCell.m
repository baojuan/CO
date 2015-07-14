//
//  COMonthStatisticsCell.m
//  CheckOrder
//
//  Created by baojuan on 15/6/30.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COMonthStatisticsCell.h"
#import "CODataCenter.h"

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

- (void)configWithData:(NSDictionary *)dict
{
    self.monthLabel.text = [NSString stringWithFormat:@"%@",[dict valueForKey:kCODate]];
    self.myLabel.text = [NSString stringWithFormat:@"%@",[dict valueForKey:kCOMyMonthCost]];
    self.taLabel.text = [NSString stringWithFormat:@"%@",[dict valueForKey:kCOTaMonthCost]];
    self.ourLabel.text = [NSString stringWithFormat:@"%@",[dict valueForKey:kCOOurMonthCost]];
    self.remainLabel.text = @"000";

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
