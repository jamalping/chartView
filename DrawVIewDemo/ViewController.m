//
//  ViewController.m
//  DrawVIewDemo
//
//  Created by YZR on 17/3/16.
//  Copyright © 2017年 YZR. All rights reserved.
//

#import "ViewController.h"
#import "StatisView.h"
#import "CycleChartView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    StatisView *view = [[StatisView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width) data:@[@"36",@"85",@"48",@"110"] chartType:ChartTypeHistogram];
    [self.view addSubview:view];
    
    CycleChartView *cycleChartView = [[CycleChartView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width, self.view.frame.size.width-100, self.view.frame.size.width-100) amount:100];
    [self.view addSubview:cycleChartView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
