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
#import "SettingViewController.h"
#import "COWatchDataCenter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if ([CODataCenter isFirstOpenApp]) {
        UIViewController *rootViewController = self.window.rootViewController;
        SettingViewController *controller = [[SettingViewController alloc] init];
        controller.finishBlock = ^(COAPPSetting *setting) {
            [CODataCenter settingApp:setting];
            [[DBManager shareDB] createTable];
            [self createSysCategory];
            [CODataCenter firstOpenApp];
            self.window.rootViewController = rootViewController;
        };
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        self.window.rootViewController = nav;
    }
    
    
    NSUserDefaults *userdefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.bj.co"];

    NSArray *array = [userdefault valueForKey:@"WatchOrders"];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        COOrderModel *order = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
        [[DBManager shareDB] insertOrderData:order];
        if (order.type == COOrderTypeYours) {
            [CODataCenter changeTaSumMoney:order.sum];
        }
        else if (order.type == COOrderTypeMine) {
            [CODataCenter changeMySumMoney:order.sum];
        }
        else if (order.type == COOrderTypeOurs) {
            [CODataCenter changeTaSumMoney:[CODataCenter taShouldPay:order.sum]];
            [CODataCenter changeMySumMoney:[CODataCenter meShouldPay:order.sum]];
        }
    }];
    [userdefault setValue:@[] forKey:@"WatchOrders"];
    [userdefault synchronize];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [CODataCenter calculationMonthCost];
    });
    
    
    
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


- (void)createSysCategory
{
    COCategoryModel *model1 = [COCategoryModel new];
    
    model1.categoryId = 1;
    model1.name = @"工资";
    model1.type = 0;
    model1.updateTime = 0;
    model1.icon = 1;
    
    [[DBManager shareDB] insertCategoryData:model1];
    
    
    COCategoryModel *model2 = [COCategoryModel new];
    
    model2.categoryId = 2;
    model2.name = @"奖金";
    model2.type = 0;
    model2.updateTime = 0;
    model2.icon = 2;
    
    [[DBManager shareDB] insertCategoryData:model2];
    
    
    
    COCategoryModel *model3 = [COCategoryModel new];
    
    model3.categoryId = 3;
    model3.name = @"用餐";
    model3.type = 1;
    model3.updateTime = 0;
    model3.icon = 3;
    
    [[DBManager shareDB] insertCategoryData:model3];
    
    
    
    COCategoryModel *model4 = [COCategoryModel new];
    
    model4.categoryId = 4;
    model4.name = @"住房";
    model4.type = 1;
    model4.updateTime = 0;
    model4.icon = 4;
    
    [[DBManager shareDB] insertCategoryData:model4];
    
    
    
    COCategoryModel *model5 = [COCategoryModel new];
    
    model5.categoryId = 5;
    model5.name = @"宠物";
    model5.type = 1;
    model5.updateTime = 0;
    model5.icon = 5;
    
    [[DBManager shareDB] insertCategoryData:model5];
    
    
    
    COCategoryModel *model6 = [COCategoryModel new];
    
    model6.categoryId = 6;
    model6.name = @"购物";
    model6.type = 1;
    model6.updateTime = 0;
    model6.icon = 6;
    
    [[DBManager shareDB] insertCategoryData:model6];
    
    
    
    COCategoryModel *model7 = [COCategoryModel new];
    
    model7.categoryId = 7;
    model7.name = @"交通";
    model7.type = 1;
    model7.updateTime = 0;
    model7.icon = 7;
    
    [[DBManager shareDB] insertCategoryData:model7];
    
    
    COCategoryModel *model8 = [COCategoryModel new];
    
    model8.categoryId = 8;
    model8.name = @"其他";
    model8.type = 1;
    model8.updateTime = 0;
    model8.icon = 8;
    
    [[DBManager shareDB] insertCategoryData:model8];

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


-(void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply{
    NSString *type = [userInfo valueForKey:@"type"];
    if ([type isEqualToString:@"settings"]) {
        NSString *taName = [CODataCenter taName];
        NSString *myName = [CODataCenter myName];
        float taSumMoney = [CODataCenter taSumMoney];
        float mySumMoney = [CODataCenter mySumMoney];
        NSDictionary *dict = @{@"settings":@{@"taName":taName,@"myName":myName,@"taMoney":@(taSumMoney),@"myMoney":@(mySumMoney)}};
        reply(dict);
    }
    else if ([type isEqualToString:@"categorys"]) {
        COCategoryModel *model = [COCategoryModel new];
        model.type = 0;
        NSArray *inArray = [[DBManager shareDB] selectCategoryData:model];
        model.type = 1;
        NSArray *outArray = [[DBManager shareDB] selectCategoryData:model];
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:inArray];
        [array addObjectsFromArray:outArray];
        
        NSMutableArray *replyArray = [NSMutableArray new];
        [inArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            COCategoryModel *model = obj;
            [replyArray addObject:[NSKeyedArchiver archivedDataWithRootObject:model]];
        }];
        [outArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            COCategoryModel *model = obj;
            [replyArray addObject:[NSKeyedArchiver archivedDataWithRootObject:model]];
        }];
        
        NSDictionary *dict = @{@"categorys":replyArray};
        reply(dict);
    }
    reply(@{});
}

@end
