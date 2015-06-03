//
//  COCalculationView.m
//  CheckOrder
//
//  Created by baojuan on 15/6/3.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COCalculationView.h"

static NSInteger kDeleteButtonTag = 101;
static NSInteger kCleanButtonTag = 102;
static NSInteger kPointButtonTag = 103;
static NSInteger kAddButtonTag = 104;

static NSInteger kResultButtonTag = 105;

static NSInteger kOkButtonTag = 106;

@interface COCalculationView ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (nonatomic, assign) CGFloat sumPrice;
@property (nonatomic, assign) CGFloat nowInputPrice;
@property (nonatomic, assign) BOOL havePoint;

@end

@implementation COCalculationView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UIView *containerView = [[[UINib nibWithNibName:@"COCalculationView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}

- (IBAction)addButtonClick:(id)sender
{
    self.resultButton.hidden = NO;
    self.okButton.hidden = YES;
    self.sumPrice += self.nowInputPrice;
    self.nowInputPrice = 0;
    self.priceLabel.text = [self priceAddSymbol:self.sumPrice];
    self.havePoint = NO;
}
- (IBAction)resultButtonClick:(id)sender
{
    self.resultButton.hidden = YES;
    self.okButton.hidden = NO;
    
    self.sumPrice += self.nowInputPrice;
    self.nowInputPrice = 0;
    self.priceLabel.text = [self priceAddSymbol:self.sumPrice];

}
- (IBAction)deleteButtonClick:(id)sender
{
    if (self.nowInputPrice == 0) {
        return;
    }
    if (self.havePoint) {
        NSInteger now = self.nowInputPrice * 100;
        NSInteger a = now % 100;
        NSInteger b = a % 10;
        if (a >= 0 && b > 0) {
            self.nowInputPrice = floor(self.nowInputPrice * 10) / 10 ;
        }
        else if (a > 0 && b == 0) {
            self.nowInputPrice = floor(self.nowInputPrice) ;
        }
    }
    else {
        self.nowInputPrice /= 10;
        self.nowInputPrice = floor(self.nowInputPrice);
    }
    //退成了0
    if (self.nowInputPrice == 0) {
        self.havePoint = NO;
    }
    self.priceLabel.text = [self priceAddSymbol:self.nowInputPrice];

}
- (IBAction)cleanButtonClick:(id)sender
{
    self.sumPrice = 0;
    self.nowInputPrice = 0;
    self.priceLabel.text = [self priceAddSymbol:self.sumPrice];
    self.havePoint = NO;
}
- (IBAction)pointButtonClick:(id)sender
{
    if (self.havePoint) {
        return;
    }
    self.havePoint = YES;
}
- (IBAction)numberButtonClick:(id)sender
{
    NSInteger number = ((UIButton *)sender).tag - 1000;
    if (self.havePoint) {
        NSInteger now = self.nowInputPrice * 100;
        NSInteger a = now % 100;
        NSInteger b = a % 10;
        if (a < 0) {
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
    self.priceLabel.text = [self priceAddSymbol:self.nowInputPrice];
}

- (NSString *)priceAddSymbol:(CGFloat)price
{
    return [NSString stringWithFormat:@"￥%.2f",price];
}

@end
