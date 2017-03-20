//
//  CycleChartView.m
//  DrawVIewDemo
//
//  Created by YZR on 17/3/20.
//  Copyright © 2017年 YZR. All rights reserved.
//

#import "CycleChartView.h"


#define xpColor(r,g,b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1]
@interface CycleChartView()

@property (nonatomic,assign)CGPoint chartCenter; // 图表的中心店
@property (nonatomic,assign)CGFloat R;           // 半径
@property (nonatomic,assign)CGFloat startAngle;  // 开始弧度
@property (nonatomic,assign)CGFloat endAngle;    // 最终弧度

@end

@implementation CycleChartView

- (instancetype)initWithFrame:(CGRect)frame amount:(CGFloat)amount {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        // 设置好默认值
        _chartCenter = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
        _R = self.frame.size.width/4;
        _startAngle = 2*M_PI/3;
        _endAngle = 7*M_PI/3;
        
        self.amout = amount;
        [self initCycleChart];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame amount:0];
}

// 画出圆环
- (void)initCycleChart {
    [self initCycleLineWithStartAngle:2*M_PI/3 endAngle:7*M_PI/3 color:xpColor(0, 0, 0) needTracingPoint:NO];
    [self initCycleLineWithStartAngle:2*M_PI/3 endAngle:M_PI color:xpColor(152, 191, 175) needTracingPoint:YES];
    [self initCycleLineWithStartAngle:M_PI endAngle:2*M_PI color:xpColor(97, 132	, 160) needTracingPoint:YES];
    [self initCycleLineWithStartAngle:0 endAngle:1*M_PI/3 color:xpColor(157, 68, 56) needTracingPoint:YES];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //
    [[NSString stringWithFormat:@"用户注册量:%d",(int)_amout] drawAtPoint:CGPointMake(10, 10) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor]}];
    // 画坐标值
    NSInteger count = (2*M_PI-_startAngle)/M_PI*30+( _endAngle-2*M_PI)/M_PI*30;
    for (int i = 0; i <= count; i++) {
        if (i%5 == 0) {
            CGFloat x1 = (_R-27)*cosf(_startAngle+i*M_PI/30)+_chartCenter.x;
            CGFloat y1 = (_R-27)*sinf(_startAngle+i*M_PI/30)+_chartCenter.y;
            
            //
            NSString *pointStr = [NSString stringWithFormat:@"%d",100*i/5];
            NSDictionary *attributDic = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor blackColor]};
            CGSize size = [pointStr sizeWithAttributes:attributDic];
            // 字符串起始位置的坐标根据相对半径的左边偏移字符串size的一半距离
            [pointStr drawAtPoint:CGPointMake(x1-size.width/2, y1-size.height/2) withAttributes:attributDic];
        }
    }
}

// 创建圆环段
- (void)initCycleLineWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color needTracingPoint:(BOOL)needTracingPoint {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:_chartCenter radius:_R startAngle:startAngle endAngle:endAngle clockwise:YES];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 6.f;//线条大小
    layer.strokeColor = color.CGColor;//线条颜色
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    
    // 画坐标点
    if (!needTracingPoint) {
        return;
    }
    NSInteger count = endAngle/M_PI*30-startAngle/M_PI*30;
    for (int i = 0; i <= count; i++) {
        UIBezierPath *pointPath = [UIBezierPath bezierPath];
        // 获取点的起始坐标
        CGFloat x = (_R+layer.lineWidth/2)*cosf(startAngle+i*M_PI/30)+_chartCenter.x;
        CGFloat y = (_R+layer.lineWidth/2)*sinf(startAngle+i*M_PI/30)+_chartCenter.y;
        // 获取终点的坐标
        CGFloat r0 = i%5==0 ? _R-12 : _R-8;
        CGFloat x1 = r0*cosf(startAngle+i*M_PI/30)+_chartCenter.x;
        CGFloat y1 = r0*sinf(startAngle+i*M_PI/30)+_chartCenter.y;
        
        [pointPath moveToPoint:CGPointMake(x, y)];
        [pointPath addLineToPoint:CGPointMake(x1, y1)];
        
        CAShapeLayer *pointLayer = [CAShapeLayer layer];
        pointLayer.fillColor = [UIColor clearColor].CGColor;
        
        pointLayer.lineWidth = i%5==0 ? 2.f : 1.f;//线条大小
        pointLayer.strokeColor = color.CGColor;//线条颜色
        pointLayer.path = pointPath.CGPath;
        [self.layer addSublayer:pointLayer];
    }
}

// 根据数量设置指针位置
- (void)setAmout:(CGFloat)amout {
    _amout = amout;
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 偏移弧度
    CGFloat offInset = amout/1000*(_endAngle - _startAngle)+_startAngle;
    //计算指针四个点的坐标
    CGFloat x0 = (_R-14)*cosf(offInset)+_chartCenter.x;
    CGFloat y0 = (_R-14)*sinf(offInset)+_chartCenter.y;
    
    CGFloat x1 = 10*cosf(offInset+M_PI/2)+_chartCenter.x;
    CGFloat y1 = 10*sinf(offInset+M_PI/2)+_chartCenter.y;
    
    CGFloat x2 = 20*cosf(offInset+M_PI)+_chartCenter.x;
    CGFloat y2 = 20*sinf(offInset+M_PI)+_chartCenter.y;
    
    CGFloat x3 = 10*cosf(offInset-M_PI/2)+_chartCenter.x;
    CGFloat y3 = 10*sinf(offInset-M_PI/2)+_chartCenter.y;
    
    [path moveToPoint:CGPointMake(x0, y0)];
    [path addLineToPoint:CGPointMake(x1, y1)];
    [path addLineToPoint:CGPointMake(x2, y2)];
    [path addLineToPoint:CGPointMake(x3, y3)];
    
    CAShapeLayer *pointLayer = [CAShapeLayer layer];
    pointLayer.fillColor = [UIColor purpleColor].CGColor;
    
    pointLayer.strokeColor = [UIColor purpleColor].CGColor;
    pointLayer.path = path.CGPath;
    [self.layer addSublayer:pointLayer];
    
    [self setNeedsDisplay];
}



@end
