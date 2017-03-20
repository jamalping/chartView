//
//  StatisView.h
//  DrawVIewDemo
//
//  Created by YZR on 17/3/16.
//  Copyright © 2017年 YZR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ChartTypeHistogram,
    ChartTypeLine,
} ChartType;

@interface StatisView : UIView

@property (nonatomic,copy)NSArray *datas; // 数据源

@property (nonatomic,assign)ChartType chartType; // 图标类型

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)dataAry chartType:(ChartType)chartType;

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)dataAry;


@end
