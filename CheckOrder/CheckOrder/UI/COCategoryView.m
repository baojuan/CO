//
//  CategoryView.m
//  CheckOrder
//
//  Created by baojuan on 15/6/2.
//  Copyright (c) 2015年 baojuan. All rights reserved.
//

#import "COCategoryView.h"
#import "COCategoryModel.h"
#import "COCategorySingleView.h"

static CGFloat xSpace = 5;

static CGFloat ySpace = 5;


@interface COCategoryView ()
@property (nonatomic, strong) NSMutableArray *singleViewArray;
@property (nonatomic, copy) NSArray *categoryArray;

@end

@implementation COCategoryView

- (id)init
{
    if (self = [super init]) {
        self.singleViewArray = [[NSMutableArray alloc] init];
        self.maxWidth = [UIScreen mainScreen].bounds.size.width - 30;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.singleViewArray = [[NSMutableArray alloc] init];
    self.maxWidth = [UIScreen mainScreen].bounds.size.width - 30;
}

- (void)insertIntoCategoryArray:(NSArray *)categoryArray
{
    self.categoryArray = categoryArray;
    [self.singleViewArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = obj;
        [view removeFromSuperview];
    }];
    [self.singleViewArray removeAllObjects];
    
    __block CGFloat x = 0;
    __block CGFloat y = 0;
    
    [categoryArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        COCategoryModel *model = obj;
        
        COCategorySingleView *singleView = [[[NSBundle mainBundle] loadNibNamed:@"COCategorySingleView" owner:self options:nil] lastObject];
        singleView.imageView.image = [UIImage imageNamed:[self iconName:[NSString stringWithFormat:@"%d",model.icon]]];
        singleView.textLabel.text = model.name;
        [singleView.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        singleView.button.tag = 100 + idx;
        CGSize size = singleView.frame.size;
        if (x + size.width > self.maxWidth) {
            x = 0;
            y += ySpace + size.height;
        }
        
        singleView.frame = CGRectMake(x, y, size.width, size.height);
        
        x += size.width + xSpace;
        
        [self addSubview:singleView];
        [self.singleViewArray addObject:singleView];
        
    }];
}

- (NSString *)iconName:(NSString *)key
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"categoryIcon" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return [dict valueForKey:key];
}

- (void)buttonClick:(UIButton *)button
{
    if (self.categoryClick) {
        COCategoryModel *model = self.categoryArray[button.tag - 100];
        self.categoryClick(model);
    }
}

@end
