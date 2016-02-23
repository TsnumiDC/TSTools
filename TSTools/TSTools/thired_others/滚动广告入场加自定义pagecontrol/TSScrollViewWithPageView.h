//
//  TSScrollViewWithPageController.h
//  TSScrollViewAndPageController
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 TS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSPageTest.h"
@interface TSScrollViewWithPageView : UIView<UIScrollViewDelegate,TSPageTestDelegate>
@property (nonatomic,weak)UIScrollView * scrollView;
@property (nonatomic,strong)TSPageTest * pageController;
@property (nonatomic,weak)NSTimer * timer;

+(id)scrollViewWithFrame:(CGRect)frame andImages:(NSArray *)images;

-(void)timerStart;

@end
