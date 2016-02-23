//
//  TSScrollViewWithPageController.m
//  TSScrollViewAndPageController
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 TS. All rights reserved.
//

#import "TSScrollViewWithPageView.h"

@implementation TSScrollViewWithPageView


+(id)scrollViewWithFrame:(CGRect)frame andImages:(NSArray *)images
{
    TSScrollViewWithPageView * tsView=[[TSScrollViewWithPageView alloc]initWithFrame:frame];
    
    [tsView scrollViewWithArray:images];
    
    return tsView;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
//        [self setBackgroundColor:[UIColor redColor]];
        UIImage * image=[UIImage imageNamed:@"guide_bg"];
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        imageview.image=image;
        [self addSubview: imageview];
        UIScrollView * scrollView=[[UIScrollView alloc]init];
        self.scrollView=scrollView;
        self.scrollView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview: self.scrollView];
        
        TSPageTest * pageController=[[TSPageTest alloc]initWithFrame:CGRectMake(self.frame.size.width*0.25, self.frame.size.height*0.9, self.frame.size.width*0.5, 20)];
        self.pageController=pageController;
        self.pageController.pageNow=0;
        self.scrollView.delegate=self;
        self.pageController.delegate=self;
        [self addSubview:pageController];

    }
    return  self;
}
-(id)scrollViewWithArray:(NSArray *)array
{
    self.scrollView.contentSize=CGSizeMake(self.frame.size.width*array.count, self.frame.size.height);
    self.pageController.pageNumber=(NSInteger)array.count;
    int i=0;
    for (NSString * str in array)
    {
        UIImage * image=[UIImage imageNamed:str];
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnX=self.frame.size.width*i;
        CGFloat btnY=0;
        CGFloat btnW=self.frame.size.width;
        CGFloat btnH=self.frame.size.height;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        btn.tag=i;
        [btn addTarget:self action:@selector(imageBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        self.scrollView.pagingEnabled=YES;
        i++;
    }
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(3*self.frame.size.width+100, 500, 200, 80);
    [self.scrollView addSubview:btn];
//    [btn setBackgroundColor:[UIColor brownColor]];
    [btn addTarget:self action:@selector(btntouch) forControlEvents:UIControlEventTouchUpInside];
    return self;
}
#pragma  mark  timer
-(void)timerStart
{
    NSTimer * timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollDidMove) userInfo:nil repeats:YES];
    self.timer=timer;
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self timerStart];
}

-(void)scrollDidMove
{
    NSInteger page=(self.pageController.pageNow>=self.pageController.pageNumber-1)?0:(self.pageController.pageNow+1);
    if (page==self.pageController.pageNumber-1)
    {
        [self.timer invalidate];
    }
    NSLog(@"%@ page:%ld",NSStringFromSelector(_cmd),page);
    self.pageController.pageNow=page;
    self.scrollView.contentOffset=CGPointMake(page*self.frame.size.width, 0);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    self.pageController.pageNow=(int)self.scrollView.contentOffset.x/self.frame.size.width;
}
#pragma  mark btnTouch
-(void)imageBtnTouch:(UIButton * )btn
{
    NSLog(@"%ld",btn.tag);
}
-(void)btntouch
{
//    self.hidden=YES;
    NSLog(@"btnTouch");
    [UIView animateWithDuration:3 animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        self.hidden=YES;
    }];
}
#pragma mark delegate
-(void)TSPageTestWithIndex:(NSInteger)index
{
    self.scrollView.contentOffset=CGPointMake(index*self.frame.size.width, 0);

}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    
}

@end
