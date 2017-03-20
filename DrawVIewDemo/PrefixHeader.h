//
//  PrefixHeader.h
//  DrawVIewDemo
//
//  Created by YZR on 17/3/20.
//  Copyright © 2017年 YZR. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h

//字符串是否为空
#define xpStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define xpArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define xpDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define xpObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//获取屏幕宽度与高度
#define xpScreenWidth \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)
#define xpScreenHeight \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)
#define xpScreenSize \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)

//一些缩写
#define xpApplication        [UIApplication sharedApplication]
#define xpKeyWindow          [UIApplication sharedApplication].keyWindow
#define xpAppDelegate        [UIApplication sharedApplication].delegate
#define xpUserDefaults       [NSUserDefaults standardUserDefaults]
#define xpNotificationCenter [NSNotificationCenter defaultCenter]

//APP版本号
#define xpAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]
//获取当前语言
#define xpCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否为iPhone
#define xpISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define xpISiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//获取沙盒Document路径
#define xpDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define xpTempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define xpCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//真机
#endif

#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif

//开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

//颜色
#define xpRGBColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define xpRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define xpRandomColor           kRGBColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

#define xpColorWithHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

//弱引用/强引用
#define xpWeak(type)   __weak typeof(type) weak##type = type;
#define xpStrong(type) __strong typeof(type) type = weak##type;

//由角度转换弧度
#define xpDegreesToRadian(x)      (M_PI * (x) / 180.0)
//由弧度转换角度
#define xpRadianToDegrees(radian) (radian * 180.0) / (M_PI)

//获取一段时间间隔
#define xpStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define xpEndTime   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

#endif /* PrefixHeader_h */
