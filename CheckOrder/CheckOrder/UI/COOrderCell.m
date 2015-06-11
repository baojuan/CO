//
//  COOrderCell.m
//  CheckOrder
//
//  Created by baojuan on 15/6/11.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COOrderCell.h"

@implementation COOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)deleteButtonClilck:(id)sender
{
    if (self.deleteHandler) {
        self.deleteHandler();
    }
}
- (IBAction)editButtonClick:(id)sender
{
    
    if (self.editHandler) {
        self.editHandler();
    }
}
- (void)setSelectedCell:(BOOL)selectedCell
{
    self.editButton.hidden = self.deleteButton.hidden = !selectedCell;
}
@end
