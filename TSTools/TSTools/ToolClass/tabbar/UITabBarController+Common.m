//
//  UITabBarController+Common.m
//  TSTools
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import "UITabBarController+Common.h"

@implementation UITabBarController (Common)

-(void)addChildViewController:(UIViewController *)childController WithTitle:(NSString *)title andSelectImage:(NSString  *)selectImageName andimage:(NSString *)imageName
{
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:childController];
    childController.title=title;
    nav.tabBarItem.title=title;
    //设置字体颜色
    NSDictionary * attributeNormal=@{NSForegroundColorAttributeName:[UIColor colorWithRed:169/256.0f green:169/256.0f blue:169/256.0f alpha:1]};
    [nav.tabBarItem setTitleTextAttributes:attributeNormal forState:UIControlStateNormal];
    
    NSDictionary * attributeSelect=@{NSForegroundColorAttributeName:[UIColor colorWithRed:38/256.0f green:203/256.0f blue:92/256.0f alpha:1]};
    [nav.tabBarItem setTitleTextAttributes:attributeSelect forState:UIControlStateSelected];
    
    nav.tabBarItem.image=[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage=[[UIImage imageNamed:selectImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}
@end
