//
//  TSMathTool.m
//  TSTools
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import "TSMathTool.h"

@implementation TSMathTool

/*
 //使用reacocoa
 RAC(self.loadBtn,enabled)=[RACSignal combineLatest:@[self.phoneNumberField.rac_textSignal,self.pswField.rac_textSignal] reduce:^id(NSString * phoneNumber,NSString * psw){
 NSLog(@"%@,%@",phoneNumber,psw);
 return @(phoneNumber.length==11&&psw.length>=6);
 }];
 */


//推送到最上层逻辑
/*
- (void)gotoRegisteVC {
    [QFBackView hideView];
    QFTabViewController *tabVC = (QFTabViewController *)[[UIApplication sharedApplication].delegate window].rootViewController;
    UINavigationController *currentNaviController = [tabVC selectedViewController];
    QFRegisterViewController *registerVC = [[QFRegisterViewController alloc] init];
    [currentNaviController pushViewController:registerVC animated:YES];
}
*/
@end
