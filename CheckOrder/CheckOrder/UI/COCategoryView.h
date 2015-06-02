//
//  CategoryView.h
//  CheckOrder
//
//  Created by baojuan on 15/6/2.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COCategoryView : UIView
@property (nonatomic, assign)CGFloat maxWidth;


- (void)insertIntoCategoryArray:(NSArray *)categoryArray;
@property (nonatomic, copy)void(^categoryClick)(NSInteger index);


@end
