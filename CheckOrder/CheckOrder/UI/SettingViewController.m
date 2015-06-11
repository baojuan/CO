//
//  SettingViewController.m
//  CheckOrder
//
//  Created by baojuan on 15/6/11.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *myNameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *coinSegment;
@property (weak, nonatomic) IBOutlet UITextField *taMoneyTextField;
@property (weak, nonatomic) IBOutlet UITextField *myMoneyTextField;
@property (strong, nonatomic) COAPPSetting *setting;
@property (assign, nonatomic) int taNegative;
@property (assign, nonatomic) int myNegative;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taNegative = 1;
    self.myNegative = 1;
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view from its nib.
    self.setting.coinToWho = COOrderCoinTypeYours;
    

}

- (COAPPSetting *)setting
{
    if (!_setting) {
        _setting = [COAPPSetting new];
    }
    return _setting;
}
- (IBAction)taMoneyNegative:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.taNegative *= -1;
}
- (IBAction)myMoneyNegative:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.myNegative *= -1;
}

- (IBAction)coinToWho:(UISegmentedControl *)seg
{
    self.setting.coinToWho = seg.selectedSegmentIndex;
}
- (IBAction)okButtonClick:(id)sender
{
    self.setting.taName = self.taNameTextField.text;
    self.setting.myName = self.myNameTextField.text;
    self.setting.taOriginMoney = [self.taMoneyTextField.text floatValue] * self.taNegative;
    self.setting.myOriginMoney = [self.myMoneyTextField.text floatValue] * self.myNegative;
    
    [self.navigationController popViewControllerAnimated:YES];
    if (self.finishBlock) {
        self.finishBlock(self.setting);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
