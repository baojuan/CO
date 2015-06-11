//
//  SettingViewController.h
//  CheckOrder
//
//  Created by baojuan on 15/6/11.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CODataCenter.h"

@interface SettingViewController : UIViewController
@property (nonatomic, copy) void(^finishBlock)(COAPPSetting *setting);
@end
