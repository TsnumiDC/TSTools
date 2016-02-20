//
//  UIButton+BackgroundColor.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by 符现超 on 15/5/9.
//  Copyright (c) 2015年 http://weibo.com/u/1655766025 All rights reserved.
//

#import "UIButton+BackgroundColor.h"
#import "UIControl+ActionBlocks.h"

@implementation UIButton (BackgroundColor)
/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
	self.layer.masksToBounds = YES;
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}
//使用颜色返回图片
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
//设置具有下划线的按钮
+(UIButton *)btnWithUnderLineForTitle:(NSString *)title andColor:(UIColor *)color
{
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    NSDictionary * attribute=@{NSForegroundColorAttributeName:color,NSUnderlineStyleAttributeName:@(1)};
    NSMutableAttributedString * attributeStr=[[NSMutableAttributedString alloc]initWithString:title];
    [attributeStr setAttributes:attribute range:NSMakeRange(0, title.length)];
    [btn setAttributedTitle:attributeStr forState:UIControlStateNormal];
    return btn;
}
- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state {
	self.layer.borderWidth = 1.0f;
	
}

@end
