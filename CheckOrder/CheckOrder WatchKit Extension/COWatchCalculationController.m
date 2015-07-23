//
//  COWatchCalculationController.m
//  CheckOrder
//
//  Created by baojuan on 15/7/23.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COWatchCalculationController.h"
#import "COWatchDataCenter.h"

@interface COWatchCalculationController ()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *priceLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *one;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *two;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *three;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *four;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *five;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *six;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *seven;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *eight;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *nine;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *zero;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *point;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *clean;



@property (nonatomic, assign) CGFloat sumPrice;
@property (nonatomic, assign) CGFloat nowInputPrice;
@property (nonatomic, assign) BOOL havePoint;


@end

@implementation COWatchCalculationController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)oneClick
{
    [self numberClick:1];

}
- (IBAction)twoClick
{
    [self numberClick:2];

}
- (IBAction)threeClick
{
    [self numberClick:3];

}
- (IBAction)fourClick
{
    [self numberClick:4];

}
- (IBAction)fiveClick
{
    [self numberClick:5];

}
- (IBAction)sixClick
{
    [self numberClick:6];

}
- (IBAction)sevenClick
{
    [self numberClick:7];

}
- (IBAction)eightClick
{
    [self numberClick:8];

}
- (IBAction)nineClick
{
    [self numberClick:9];

}
- (IBAction)zeroClick
{
    [self numberClick:0];
}

- (void)numberClick:(int)number
{
    if (self.havePoint) {
        NSInteger now = self.nowInputPrice * 100;
        NSInteger a = now % 100;
        NSInteger b = a % 10;
        if (a < 0) {
            return;
        }
        else if (a > 0 && b > 0) {
            return;
        }
        else if (a == 0 && b == 0) {
            self.nowInputPrice += number * 0.1;
        }
        else if (a >= 0 && b < 0) {
            self.nowInputPrice += number * 0.1;
        }
        else {
            self.nowInputPrice += number * 0.01;
        }
    }
    else {
        self.nowInputPrice *= 10;
        self.nowInputPrice += number;
        
    }
    [self.priceLabel setText:[self priceAddSymbol:self.nowInputPrice]];
    WatchCenter.model.sum = self.nowInputPrice;
}

- (NSString *)priceAddSymbol:(CGFloat)price
{
    return [NSString stringWithFormat:@"￥%.2f",price];
}


- (IBAction)pointClick
{
    if (self.havePoint) {
        return;
    }
    self.havePoint = YES;
}
- (IBAction)cleanClick
{
    self.sumPrice = 0;
    self.nowInputPrice = 0;
    [self.priceLabel setText:[self priceAddSymbol:self.sumPrice]];
    self.havePoint = NO;
}


@end



