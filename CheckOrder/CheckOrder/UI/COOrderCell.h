//
//  COOrderCell.h
//  CheckOrder
//
//  Created by baojuan on 15/6/11.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic, copy) void(^editHandler)(void);
@property (nonatomic, copy) void(^deleteHandler)(void);
@property (nonatomic, assign) BOOL selectedCell;

@end
