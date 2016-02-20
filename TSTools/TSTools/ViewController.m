//
//  ViewController.m
//  TSTools
//
//  Created by 晨 on 16/2/20.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Common.h"
#import "UIButton+Submitting.h"
#import "UIImage+RoundedCorner.h"
@interface ViewController ()
@property (strong, nonatomic) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * ima=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:ima];
    UIImage * iamge=[UIImage imageNamed:@"iOS Simulator Screen Shot 2015年12月19日 14.56.35.png"];
    NSLog(@"%@",NSStringFromCGSize(iamge.size));
    UIImage * smallImage=[iamge getImageWithRect:CGRectMake(500, 0, 100, 100)];
    [smallImage roundedCornerImage:0.4 borderSize:10];
    ima.clipsToBounds=NO;
    ima.image=smallImage;
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)test1
{
    self.view.backgroundColor=[UIColor yellowColor];
    UIButton *  btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"11111" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateSelected];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnTouch:(UIButton *)btn
{
    if (!btn.selected) {
        [self.btn beginSubmitting:@"加载中"];
    }
    else
    {
        [btn endSubmitting];
    }
    btn.selected=!btn.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
