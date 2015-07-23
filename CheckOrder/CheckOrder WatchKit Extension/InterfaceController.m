//
//  InterfaceController.m
//  CheckOrder WatchKit Extension
//
//  Created by baojuan on 15/7/22.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "InterfaceController.h"
#import "COWatchDataCenter.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    [WKInterfaceController openParentApplication:@{@"type":@"settings"} reply:^(NSDictionary *replyInfo, NSError *error) {
        NSDictionary *dict = [replyInfo valueForKey:@"settings"];
        NSString *taName = [dict valueForKey:@"taName"];
        NSString *myName = [dict valueForKey:@"myName"];
        float taMoney = [[dict valueForKey:@"taMoney"] floatValue];
        float myMoney = [[dict valueForKey:@"myMoney"] floatValue];

        [self.taNameLabel setText:[NSString stringWithFormat:@"%@的",taName]];
        [self.myNameLabel setText:[NSString stringWithFormat:@"%@的",myName]];
        [self.taMoneyLabel setText:[NSString stringWithFormat:@"%.2f",taMoney]];
        [self.myMoneyLabel setText:[NSString stringWithFormat:@"%.2f",myMoney]];
    }];

}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}



@end



