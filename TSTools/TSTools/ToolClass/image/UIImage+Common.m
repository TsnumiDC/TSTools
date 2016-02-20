//
//  UIImage+Common.m
//  TSTools
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)
/**
 *  tintColor属性可以调整图片颜色通道
 *
 */
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (UIImage *)getImageWithRect:(CGRect)myImageRect
{
    //大图bigImage
    //定义myImageRect，截图的区域
    CGImageRef imageRef = self.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = CGRectGetWidth(myImageRect);
    size.height = CGRectGetHeight(myImageRect);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return smallImage;
}
@end
