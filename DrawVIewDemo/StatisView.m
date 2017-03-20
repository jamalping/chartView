//
//  StatisView.m
//  DrawVIewDemo
//
//  Created by YZR on 17/3/16.
//  Copyright © 2017年 YZR. All rights reserved.
//

#import "StatisView.h"
#import "PrefixHeader.h"
#define  RGBColor(r, g, b)   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface StatisView ()

@property (nonatomic, assign)CGFloat X; // 坐标系X坐标
@property (nonatomic, assign)CGFloat Y; // 坐标系Y坐标
@property (nonatomic, assign)CGFloat gap; // 坐标轴到边距的距离
@property (nonatomic, assign)CGFloat xGap; // 坐标轴到边距的距离
@property (nonatomic, assign)CGFloat yGap; // 坐标轴到边距的距离

@end

@implementation StatisView

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame data:nil];
}

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)dataAry {
    return [self initWithFrame:frame data:dataAry chartType:ChartTypeLine];
}

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)dataAry chartType:(ChartType)chartType {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:(240)/255.0 green:(240)/255.0 blue:(240)/255.0 alpha:1.0];
        
        _X = 50;
        _Y = frame.size.height - _X;
        _gap = _X;
        self.chartType = chartType;
        
        self.datas = [NSArray array];
        if (dataAry) {
            self.datas = dataAry;
        }
        [self creatCoordinateSystemWithFrame:frame];
    }
    return self;
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    
    _yGap = (self.frame.size.height-_gap*2)/self.datas.count;
    _xGap = (self.frame.size.width-_gap*2)/self.datas.count;
    
    [self creatChart];
}

// 获取Y左边数值
- (NSInteger)getYdata {
    // 升序排列
    NSArray *result = [self.datas sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return  [obj1 integerValue] < [obj2 integerValue] ? NSOrderedAscending : NSOrderedDescending;
    }];
    
    NSString *largestData = [result lastObject];
    NSInteger length = largestData.length;
    NSString *a = [largestData substringWithRange:NSMakeRange(0, 2)];
    NSInteger r = [a integerValue]/4+1;
    NSInteger res = r * pow(10, length-2);
    return  res;
}

// 根据数据画图表
- (void)creatChart {
    if (self.chartType == ChartTypeLine) { // 画折线
        {
            UIBezierPath *zPath = [UIBezierPath bezierPath];
            UIBezierPath *oPath;
            for (int i = 1; i <= self.datas.count; i++) {
                NSInteger data = [self.datas[i-1] integerValue];
                CGPoint point = CGPointMake(_X+_xGap*(i-0.5), _Y-data*(self.frame.size.width-_gap*2)/([self getYdata]*4));
                
                if (i==1) {
                    [zPath moveToPoint:point];
                }else {
                    [zPath addLineToPoint:point];
                }
                
                oPath  = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_X+_xGap*(i-0.5), _Y-data*(self.frame.size.width-_gap*2)/([self getYdata]*4)) radius:1 startAngle:0 endAngle:2*M_PI clockwise:YES];
                CAShapeLayer *oLayer = [CAShapeLayer layer];
                oLayer.lineWidth = 1; //线宽
                oLayer.strokeColor = [UIColor redColor].CGColor; //   边线颜色
                oLayer.fillColor = nil;
                oLayer.path = oPath.CGPath;
                [self.layer addSublayer:oLayer];
            }
            CAShapeLayer *zLayer = [CAShapeLayer layer];
            zLayer.lineWidth = 0.5; //线宽
            zLayer.strokeColor = [UIColor blackColor].CGColor; //   边线颜色
            zLayer.fillColor = nil;
            zLayer.path = zPath.CGPath;
            [self.layer addSublayer:zLayer];
        }
    }else {// 画柱
        {
            UIBezierPath *dPath = [UIBezierPath bezierPath];
            for (int i = 1; i <= self.datas.count; i++) {
                NSInteger data = [self.datas[i-1] integerValue];
                [dPath moveToPoint:CGPointMake(_X+_xGap*(i-1), _Y)];
                [dPath addLineToPoint:CGPointMake(_X+_xGap*i, _Y)];
                [dPath addLineToPoint:CGPointMake(_X+_xGap*i, _Y-data*(self.frame.size.width-_gap*2)/([self getYdata]*4))];
                [dPath addLineToPoint:CGPointMake(_X+_xGap*(i-1), _Y-data*(self.frame.size.width-_gap*2)/([self getYdata]*4))];
            }
            CAShapeLayer *dLayer = [CAShapeLayer layer];
            dLayer.lineWidth = 0.5; //线宽
            dLayer.strokeColor = [UIColor blackColor].CGColor; //   边线颜色
            [dLayer setFillColor:[UIColor redColor].CGColor]; // 填充颜色
            dLayer.path = dPath.CGPath;
            [self.layer addSublayer:dLayer];
        }
    }
}

// 画坐标点的值
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    NSInteger dataInt = [self getYdata];
    for (int i = 1; i <= self.datas.count; i++) {
        NSInteger data = [self.datas[i-1] integerValue];
        [[NSString stringWithFormat:@"%ld",dataInt*i] drawInRect:CGRectMake(20, _Y-_yGap*i-8, _gap, 30) withAttributes:@{
                                                          NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]
                                                          }];
        [[NSString stringWithFormat:@"%d",i] drawInRect:CGRectMake(21+_xGap*i, _Y+5, _xGap, 30) withAttributes:@{
                                                                             NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]
                                                                             }];
        [[NSString stringWithFormat:@"%@",self.datas[i-1]] drawInRect:CGRectMake(_xGap*(i), _Y-data*(self.frame.size.width-_gap*2)/([self getYdata]*4)-20, _gap, 30) withAttributes:@{
                                                                                          NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]
                                                                                          }];
    }
    
    [@"季度" drawInRect:CGRectMake(rect.size.height-_gap, _Y+5, _xGap, 30) withAttributes:@{
                                                                                                          NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]
                                                                                                          }];
    [@"需求量" drawInRect:CGRectMake(20, rect.size.height-_gap-_yGap*4-40, _gap, 30) withAttributes:@{
                                                                            NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]
                                                                            }];
}

// 画坐标系
- (void)creatCoordinateSystemWithFrame:(CGRect)frame {
    // 先画X，Y轴
    UIBezierPath *xPath = [UIBezierPath bezierPath];
    // 坐标轴的x坐标和y坐标
    CGFloat x = 50;
    CGFloat y = frame.size.height - x;
    CGFloat gap = x;
    // 坐标点之间的间隔
    CGFloat yGap = (frame.size.height-gap*2)/self.datas.count;
    CGFloat xGap = (frame.size.width-gap*2)/self.datas.count;
    {
        // x轴
        [xPath moveToPoint:CGPointMake(x-10, y)];
        [xPath addLineToPoint:CGPointMake(frame.size.width - x+ 10,y)];
        
        // x箭头
        [xPath moveToPoint:CGPointMake(frame.size.width -x-2+10, y-2)];
        [xPath addLineToPoint:CGPointMake(frame.size.width -x+10, y)];
        [xPath addLineToPoint:CGPointMake(frame.size.width -x-2+10, y+2)];
        
        // x轴坐标点
        for (int i = 1; i <= self.datas.count; i++) {
            [xPath moveToPoint:CGPointMake(x+i*xGap, y)];
            [xPath addLineToPoint:CGPointMake(x+i*xGap,y+2)];
        }
    }
    
    {
        // Y轴
        [xPath moveToPoint:CGPointMake(x, frame.origin.y + x-10)];
        [xPath addLineToPoint:CGPointMake(x,frame.size.height - x+10)];
        
        // Y箭头
        [xPath moveToPoint:CGPointMake(x-2, frame.origin.y + x+2-10)];
        [xPath addLineToPoint:CGPointMake(x, frame.origin.y + x-10)];
        [xPath addLineToPoint:CGPointMake(x+2, frame.origin.y + x+2-10)];
        
        // Y轴坐标点
        
        for (int i = 1; i <= self.datas.count; i++) {
            [xPath moveToPoint:CGPointMake(x, y-yGap*i)];
            [xPath addLineToPoint:CGPointMake(x-2,y-yGap*i)];
        }
    }
    
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 0.5; //线宽
    lineLayer.strokeColor = [UIColor blackColor].CGColor; //   边线颜色
    [lineLayer setFillColor:[UIColor clearColor].CGColor]; // 填充颜色
    lineLayer.path = xPath.CGPath;
    [self.layer addSublayer:lineLayer];
    self.layer.backgroundColor = [UIColor cyanColor].CGColor;
}
@end
