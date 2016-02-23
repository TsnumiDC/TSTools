//
//  TSPageTest.m
//  TSScrollViewAndPageController
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 TS. All rights reserved.
//

#import "TSPageTest.h"

@implementation TSPageTest

+(id)pageControlWithFrame:(CGRect)frame andNodeNumber:(NSInteger)number
{
    TSPageTest * pageControl=[[TSPageTest alloc]initWithFrame:frame];
    
    return pageControl;
}
-(void)setPageNumber:(NSInteger)pageNumber
{
    _pageNumber=pageNumber;
    CGFloat temp=self.frame.size.width/pageNumber;
    NSMutableArray * tempArray=[NSMutableArray array];
    for (int i=0; i<pageNumber; i++)
    {
        CGFloat  btnX=i*temp;
        CGFloat  btnY=0;
        CGFloat  btnW=10;
        CGFloat  btnH=10;
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitle:[NSString stringWithFormat:@"%d",(i+1)] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%d",(i+1)] forState:UIControlStateHighlighted];
        btn.titleEdgeInsets=UIEdgeInsetsMake(30, 0, 0, 0);
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

        [self addSubview:btn];
        btn.tag=i;
        [btn addTarget:self action:@selector(pageContolBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        [tempArray addObject:btn];
        [btn setBackgroundColor:[UIColor yellowColor]];
        
    }
    
    self.btnArray=tempArray;
}
-(id)initWithFrame:(CGRect)frame andNodeNumber:(NSInteger)number//该方法可以保存局部！而，类方法不可以
{
    if (self=[super initWithFrame:frame])
    {
        [self setPageNumber:number];
        self.pageNow=0;
    }

    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.btnArray=[NSMutableArray array];
    }
    return  self;
}
//拖动图片的时候点也变
//点击点的时候，图片也跟着动  通过协议实现
-(void)setPageNow:(NSInteger)pageNow
{
    _pageNow=pageNow;
    for (UIButton * temp in self.btnArray)
    {
        temp.selected=NO;
        temp.userInteractionEnabled=YES;
        temp.backgroundColor=[UIColor yellowColor];
        if (temp.tag==pageNow)
        {
            temp.selected=YES;
            temp.userInteractionEnabled=NO;
            temp.backgroundColor=[UIColor redColor];
        }
    }

    NSLog(@"%ld",pageNow);
}
-(void)pageContolBtnTouch:(UIButton *)btn
{
    for (UIButton * temp in self.btnArray)
    {
        temp.selected=NO;
        temp.userInteractionEnabled=YES;
        temp.backgroundColor=[UIColor yellowColor];
    }
    btn.backgroundColor=[UIColor redColor];
    btn.selected=YES;
    btn.userInteractionEnabled=NO;
    self.pageNow=btn.tag;
    if (self.delegate!=nil) {
        [self.delegate TSPageTestWithIndex:btn.tag];
    }
    NSLog(@"%@  %ld",NSStringFromSelector(_cmd) ,btn.tag);
}


@end
