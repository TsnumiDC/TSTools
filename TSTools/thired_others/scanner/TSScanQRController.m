//
//  TSScanQRController.m
//  part time job
//
//  Created by Dylan on 16/2/23.
//  Copyright © 2016年 TS. All rights reserved.
//

#import "TSScanQRController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIControl+ActionBlocks.h"
#import "TSMadeQRController.h"
#define QRW 160
//这个代理用于输出的识别
@interface TSScanQRController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    //控制扫描动画的参数
    int _num;
    BOOL _upOrdown;
    NSTimer *_timer;
}
//捕捉视频流的设备
@property (nonatomic,strong)AVCaptureDevice * device;
//从摄像头捕捉到的图片
@property (nonatomic,strong)AVCaptureDeviceInput * input;
//识别二维码之后的输出
@property (nonatomic,strong)AVCaptureMetadataOutput * output;
//会话，管理输入与输出
@property (nonatomic,strong)AVCaptureSession * session;
//预览扫描的layer
@property (nonatomic,strong)AVCaptureVideoPreviewLayer * previewLayer;
//输出结果展示
@property (nonatomic,strong)UILabel * resultLabel;

@property (nonatomic,strong)UIImageView * scanImage;
@end

@implementation TSScanQRController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configCapture];
    [self configSubViews];
    
    // Do any additional setup after loading the view.
}
//写在视图出现方法，可以防止阻塞视图出现，因为打开摄像头需要很长时间
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupCamera];
}
- (void)configCapture {
    NSError *error = nil;
    // Device
    // 创建一个捕捉视频流的设备
    // AVMediaTypeVideo 视频
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    // 捕捉到的视频输入流
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    
    if (!_input) {
        WLog(@"%@", [error localizedFailureReason]);
        return;
    }
    // 如果还没有获取过摄像头权限，申请获取权限，如果用户拒绝了，就直接退出。
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        WLog(@"没有打开照相机的权限");
        return;
    }
    
    
    // Output
    // 视频输出流，输出流把内容发送给 MetadataObject 进行识别。
    _output = [[AVCaptureMetadataOutput alloc] init];
    
    // dispatch_get_main_queue 在主线程刷新。
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session 输入输出流中间处理的桥梁。
    _session = [[AVCaptureSession alloc] init];
    // AVCaptureSessionPresetHigh 捕捉到的信息的分辨率，1080p.
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 分别桥接输入输出流
    if ([_session canAddInput:self.input]){
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output]){
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    // 二维码（条形码） AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    // 预览视频的 layer
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    // AVLayerVideoGravityResizeAspectFill
    // 相当于 UIView 的 contentMode，内容填充方式
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.backgroundColor = [UIColor colorWithWhite:0.000 alpha:1].CGColor;
    _previewLayer.frame = CGRectMake(0, 0, WScreenWidth, WScreenHeight);
    // 将 _previewLayer 插入到 self.view.layer 的上面。
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    // rectOfInterest 代表我们识别二维码的区域。
    // 圆角的二维码和被挡住一部分的二维码特别难以识别，缩小识别范围可以提升识别速度。
    // _output 的 rectOfInterest，是以图片形式识别二维码的，图片是横着的，手机屏幕是竖着的。
    // x 和 y 是反着的， 宽和高也是反着的。x\y\width\height 的值，都是在 0 - 1 之间。
    // 以比例的方式设置。
    _output.rectOfInterest = CGRectMake(0.25, 0.25, 0.5, 0.5);
    
    //
    //	CALayer *
    
    
}

//开启摄像头，配置界面
-(void)setupCamera
{
    //开始捕捉视频
    [_session startRunning];
}
//布局子视图
-(void)configSubViews
{
    //显示扫码结果
    self.resultLabel=[[UILabel alloc]init];
    [self.view addSubview:self.resultLabel];
    self.resultLabel.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.6];
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(49);
        make.height.equalTo(48);
        make.centerX.equalTo(0);
    }];
    //返回按钮
    UIButton * cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-48);
        make.left.equalTo(16);
        make.width.equalTo((TSScreW-16*4)/3);
        make.height.equalTo(48);
    }];
    [cancelBtn handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        //返回功能
        [self dismissViewControllerAnimated:YES completion:^{
            [_session stopRunning];
            _session=nil;
            _device=nil;
            _input=nil;
            _output=nil;
        }];
    }];
    //闪光灯按钮
    UIButton * flashBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [flashBtn setTitle:@"打开闪光灯" forState:UIControlStateNormal];
    [self.view addSubview:flashBtn];
    [flashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-48);
        make.left.equalTo(cancelBtn.mas_right).offset(16);
        make.width.equalTo(cancelBtn.mas_width);
        make.height.equalTo(48);
    }];
    [flashBtn handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        //打开与关闭闪光灯功能
        AVCaptureTorchMode torch = self.input.device.torchMode;
        switch (_input.device.torchMode) {
            case AVCaptureTorchModeAuto:
                break;
            case AVCaptureTorchModeOff:
                torch = AVCaptureTorchModeOn;
                break;
            case AVCaptureTorchModeOn:
                torch = AVCaptureTorchModeOff;
                break;
            default:
                break;
        }
        
        [_input.device lockForConfiguration:nil];
        _input.device.torchMode = torch;
        [_input.device unlockForConfiguration];
    }];
    //我的二维码
    UIButton * myQRBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [myQRBtn setTitle:@"查看我的二维码" forState:UIControlStateNormal];
    [self.view addSubview:myQRBtn];
    [myQRBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-48);
        make.left.equalTo(flashBtn.mas_right).offset(16);
        make.width.equalTo(flashBtn.mas_width);
        make.height.equalTo(48);
    }];
    [myQRBtn handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        //显示我的二维码
        TSMadeQRController * madeQR=[TSMadeQRController new];
        [self.navigationController pushViewController:madeQR animated:YES];
    }];
    //设置边框
    UIImageView * borderImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ScanBorder"]];
    [self.view addSubview:borderImage];
    [borderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.bottom.equalTo(myQRBtn.mas_top).offset(-100);
        make.size.equalTo(CGSizeMake(QRW, QRW));
    }];
    //设置动画
    UIImageView * scanImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ScanLine"]];
    self.scanImage=scanImage;
    [borderImage addSubview:scanImage];
    [scanImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(0);
        make.width.equalTo(borderImage);
    }];
    _upOrdown = NO;
    _num = 0;
	_timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}
-(void)animation
{
    //0.02s运动一次，如果到达底部返回
    if (_upOrdown == NO) {
        _num ++;
        CGPoint center = self.scanImage.center;
         NSLog(@"%@",NSStringFromCGPoint(center));
        center.y += 2;
        self.scanImage.center = center;
        NSLog(@"%@",NSStringFromCGPoint(center));
        NSLog(@"%@",NSStringFromCGPoint(self.scanImage.center));
        if (2 * _num == QRW - 10) {
            _upOrdown = YES;
            
        }
    }
    else {
        _num --;
        CGPoint center = _scanImage.center;
        center.y -= 2;
        _scanImage.center = center;
        if (_num == 0) {
            _upOrdown = NO;
        }
    }

}
//隐藏顶部状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;
    if (metadataObjects != nil && [metadataObjects count] > 0){
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        self.resultLabel.text = stringValue;
    }else {
        
    }
}

@end
