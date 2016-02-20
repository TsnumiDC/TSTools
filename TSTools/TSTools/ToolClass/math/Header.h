//
//  Header.h
//  TSTools
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#ifndef TSTools_Header_h
#define TSTools_Header_h
//-------------------获取设备大小-------------------------
// NavBar高度
#define TSNavigationBarHeight 44.0
// 状态栏高度
#define TSStatusBarHeight (20.0)
//屏幕宽度高度
#define TSScreW [UIScreen mainScreen].bounds.size.width
#define TSScreH [UIScreen mainScreen].bounds.size.height
//主屏幕大小
#define TSScreFrame [UIScreen mainScreen].bounds

//-------------------获取设备控制器-------------------------
//主屏幕
#define TSKeyWindow [UIApplication sharedApplication].keyWindow

//-----------------------颜色-----------------------------
//随机颜色
// 随机数
#define WArcNum(x) arc4random_uniform(x)
// 颜色
#define WColorRGB(r, g, b) WColorRGBA(r, g, b, 1.000f)
#define WColorRGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
// 随机颜色
#define WArcColor WColorRGB(WArcNum(128) + 128, WArcNum(128) + 128, WArcNum(128) + 128)

//深绿
#define TSGreen TSColorRGB(38, 204, 92)

#endif
