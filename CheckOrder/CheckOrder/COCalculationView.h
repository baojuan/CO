//
//  COCalculationView.h
//  CheckOrder
//
//  Created by baojuan on 15/6/3.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COCalculationView : UIView
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberButton;
@property (weak, nonatomic) IBOutlet UIButton *cleanButton;
@property (weak, nonatomic) IBOutlet UIButton *pointButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *resultButton;
- (void)setCategoryText:(NSString *)text;
@property (nonatomic, copy)void(^okButtonHandle)();
- (CGFloat)getSumPrice;
@end
