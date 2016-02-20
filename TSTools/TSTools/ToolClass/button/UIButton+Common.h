//
//  UIButton+Common.h
//  TSTools
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Common)

/**
 *  返回一个有下划线的按钮
 */
+(UIButton *)btnWithUnderLineForTitle:(NSString *)title andColor:(UIColor *)color;
/**
 *  设置不同状态背景色，通过转化成图片得到
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
