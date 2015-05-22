//
//  AppDelegate.m
//  CheckOrder
//
//  Created by baojuan on 15/5/19.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "AppDelegate.h"
#import "DBManager.h"
#import "CODataCenter.h"

#import "COCategoryModel.h"
#import "COOrderModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [CODataCenter settingApp:[COAPPSetting new]];
    
    
    BOOL success = [[DBManager shareDB] createTable];
    
//    COCategoryModel *model = [COCategoryModel new];
//    
//    model.categoryId = 123;
//    model.name = @"fenlei";
//    model.type = 1;
//    model.updateTime = 100000990;
//    model.icon = 34;
//    
//    [[DBManager shareDB] insertCategoryData:model];
//    model.name = @"name";
//    model.type = 122;
//    model.updateTime = 200000990;
//    model.icon = 222;
//    [[DBManager shareDB] updateCategoryData:model];
//
//    COCategoryModel *smodel = [COCategoryModel new];
//    
//    smodel.categoryId = 123;
//
//    [[DBManager shareDB] selectCategoryData:smodel];
    
//    
//    COOrderModel *model = [COOrderModel new];
//    
//    model.orderId = 1123;
//    model.category = smodel;
//    model.type = 1;
//    model.updateTime = 100000990;
//    model.orderTime = 33333333;
//    model.ps = @"pspspsps";
//    model.year = 1234;
//    model.month = 3;
//    model.day = 4;
//    model.sum = 100.00;
//    
//    [[DBManager shareDB] insertOrderData:model];
//    model.category = smodel;
//    model.type = 122;
//    model.updateTime = 200000990;
//    model.orderTime = 600000990;
//    model.ps = @"yyyyy";
//    model.year = 2222;
//    model.month = 0;
//    model.day = 0;
//    model.sum = 500.00;
//    [[DBManager shareDB] updateOrderData:model];
//    [[DBManager shareDB] deleteOrderData:model];
//
//    COOrderModel *ssmodel = [COOrderModel new];
//    
//    ssmodel.orderId = 1123;
//    
//    [[DBManager shareDB] selectOrderData:ssmodel];

    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
