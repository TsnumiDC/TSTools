//
//  UIButton+Common.m
//  TSTools
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import "UIButton+Common.h"
#import "UIImage+Common.h"
@implementation UIButton (Common)

+(UIButton *)btnWithUnderLineForTitle:(NSString *)title andColor:(UIColor *)color
{
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    NSDictionary * attribute=@{NSForegroundColorAttributeName:color,NSUnderlineStyleAttributeName:@(1)};
    NSMutableAttributedString * attributeStr=[[NSMutableAttributedString alloc]initWithString:title];
    [attributeStr setAttributes:attribute range:NSMakeRange(0, title.length)];
    [btn setAttributedTitle:attributeStr forState:UIControlStateNormal];
    return btn;
}
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    self.layer.masksToBounds = YES;
    [self setBackgroundImage:[UIImage imageWithColor:backgroundColor] forState:state];
}
@end
