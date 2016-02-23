//
//  TSMadeQRController.m
//  part time job
//
//  Created by Dylan on 16/2/23.
//  Copyright © 2016年 TS. All rights reserved.
//

#import "TSMadeQRController.h"
#import <QREncoder.h>
@interface TSMadeQRController ()
//存储亮度，0-1
@property (nonatomic,assign)CGFloat brightness;
@end

@implementation TSMadeQRController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CIFilter * filter=[[CIFilter alloc]init];
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView * imageView=[[UIImageView alloc]init];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(150);
        make.center.equalTo(0);//居中
    }];
    //以下获取二维码图片
    DataMatrix * matrix=[QREncoder encodeWithECLevel:QR_ECLEVEL_H version:QR_VERSION_AUTO string:@"没错,这是扫描出来的结果"];
    int qrcondImageDimension= 250;
    UIImage * qrImage=[QREncoder renderDataMatrix:matrix imageDimension:qrcondImageDimension];
    imageView.image=qrImage;
}
//降低亮度
-(void)viewDidDisappear:(BOOL)animated
{
    [UIScreen mainScreen].brightness=self.brightness;
}
//调亮亮度，提高用户体验
-(void)viewDidAppear:(BOOL)animated
{
    self.brightness = [UIScreen mainScreen].brightness;//记录亮度
    [UIScreen mainScreen].brightness=1.0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
