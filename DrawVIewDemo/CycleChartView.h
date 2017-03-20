//
//  CycleChartView.h
//  DrawVIewDemo
//
//  Created by YZR on 17/3/20.
//  Copyright © 2017年 YZR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleChartView : UIView

@property (nonatomic,assign)CGFloat amout;

- (instancetype)initWithFrame:(CGRect)frame amount:(CGFloat)amount;

@end
