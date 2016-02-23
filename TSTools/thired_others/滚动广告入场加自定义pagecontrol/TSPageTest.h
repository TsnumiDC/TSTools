//
//  TSPageTest.h
//  TSScrollViewAndPageController
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 TS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSPageTest;
@protocol TSPageTestDelegate <NSObject>

-(void)TSPageTestWithIndex:(NSInteger)index;

@end


@interface TSPageTest : UIView
@property (nonatomic,assign)NSInteger pageNumber;
@property (nonatomic,assign)NSInteger pageNow;
@property (nonatomic,weak)id<TSPageTestDelegate>delegate;
@property (nonatomic,copy)NSMutableArray * btnArray;
+(id)pageControlWithFrame:(CGRect)frame andNodeNumber:(NSInteger)number;
-(id)initWithFrame:(CGRect)frame andNodeNumber:(NSInteger)number;

@end
