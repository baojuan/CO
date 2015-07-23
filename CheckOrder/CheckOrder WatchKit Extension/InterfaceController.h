//
//  InterfaceController.h
//  CheckOrder WatchKit Extension
//
//  Created by baojuan on 15/7/22.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *taMoneyLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *myMoneyLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *taNameLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *myNameLabel;

@end
