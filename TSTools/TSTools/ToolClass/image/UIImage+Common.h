//
//  UIImage+Common.h
//  TSTools
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)
/**
 *  通过颜色获取图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 *  截图方法,已图片左上角为起点，注意图片大小
 */
- (UIImage *)getImageWithRect:(CGRect)myImageRect;
@end
