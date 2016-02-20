//
//  UITabBarController+Common.h
//  TSTools
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (Common)
/**
 *  搭建框架，输入控制器，返回带有
 */
-(void)addChildViewController:(UIViewController *)childController WithTitle:(NSString *)title andSelectImage:(NSString  *)selectImageName andimage:(NSString *)imageName;
@end
