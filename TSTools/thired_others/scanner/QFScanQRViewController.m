//
//  QFScanQRViewController.m
//  jianzhi
//
//  Created by 王广威 on 16/2/23.
//  Copyright © 2016年 北京千锋-王广威. All rights reserved.
//

#import "QFScanQRViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QFScanQRViewController ()

//
@property (nonatomic, strong) AVCaptureDevice *device;
// 从硬件摄像头输入数据
@property (nonatomic, strong) AVCaptureDeviceInput *input;
// 识别二维码之后的输出数据
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
// 预览扫描视频的 layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) UILabel *resultLabel;

@end

@implementation QFScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self configCapture];
}

- (void)configCapture {
	
}

// 因为打开摄像头需要很长时间，写到视图已经出现的方法里，可以防止阻塞视图出现。
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self setUpCamera];
}
// 开启摄像头，配置界面
- (void)setUpCamera {
	
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
