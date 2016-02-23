//
//  QFScanQRCodeViewController.m
//  jianzhi
//
//  Created by 王广威 on 16/2/22.
//  Copyright © 2016年 北京千锋-王广威. All rights reserved.
//

#import "QFScanQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>


static NSInteger WScanWidth = 260;
static NSInteger WBottomPedding = 170;

@interface QFScanQRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>
{
	int _num;
	BOOL _upOrdown;
	NSTimer *_timer;
	CGFloat _oriBrightess;
}
@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession * session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;
@property (retain, nonatomic) UIImageView *line;
@property (strong, nonatomic) UILabel *resultLabel;

@end

@implementation QFScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.750];
	
	_upOrdown = NO;
	_num = 0;
	_line = [[UIImageView alloc] initWithFrame:CGRectMake((WScreenWidth - WScanWidth) / 2 + 5, WScreenHeight - WScanWidth - 165, WScanWidth - 10, 2)];
	_line.image = [UIImage imageNamed:@"ScanLine"];
}

- (void)animation {
	if (_upOrdown == NO) {
		_num ++;
		CGPoint center = _line.center;
		center.y += 2;
		_line.center = center;
		if (2 * _num == WScanWidth - 10) {
			_upOrdown = YES;
		}
	}
	else {
		_num --;
		CGPoint center = _line.center;
		center.y -= 2;
		_line.center = center;
		if (_num == 0) {
			_upOrdown = NO;
		}
	}
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[self setupCamera];
}


- (void)setupCamera {
	NSError *error;
	// Device
	_device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	
	// Input
	_input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
	
	if (!_input) {
		WLog(@"%@", [error localizedFailureReason]);
		return;
	}
	AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
	if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
		WLog(@"没有打开照相机的权限");
		return;
	}
	// Output
	_output = [[AVCaptureMetadataOutput alloc] init];
	
	[_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
	
	// Session
	_session = [[AVCaptureSession alloc] init];
	[_session setSessionPreset:AVCaptureSessionPresetHigh];
	if ([_session canAddInput:self.input]){
		[_session addInput:self.input];
	}
	
	if ([_session canAddOutput:self.output]){
		[_session addOutput:self.output];
	}
	
	// 条码类型 AVMetadataObjectTypeQRCode
	_output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
	
	// Preview
	_preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
	_preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
	_preview.backgroundColor = [UIColor colorWithWhite:0.000 alpha:1].CGColor;
	_preview.frame = CGRectMake(0, 0, WScreenWidth, WScreenHeight);
	[self.view.layer insertSublayer:self.preview atIndex:0];
//	
//	//计算 rectOfInterest 注意x,y交换位置
//	[_output setRectOfInterest:CGRectMake((WScreenHeight - 170 - WScanWidth)/ WScreenHeight ,(WScreenWidth - WScanWidth) / 2/ WScreenWidth , WScanWidth / WScreenHeight , WScanWidth / WScreenWidth)];
//	
//	CALayer *interestLayer = [CALayer layer];
//	interestLayer.frame = CGRectMake((WScreenWidth - WScanWidth) / 2, WScreenHeight - WScanWidth - 170, WScanWidth, WScanWidth);
//	
//	[interestLayer setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ScanBorder"]].CGColor];
//	[self.view.layer addSublayer:interestLayer];
//	
//	[self createBackLayerWithFrame:CGRectMake(0, 0, (WScreenWidth - WScanWidth) / 2, WScreenHeight)];
//	[self createBackLayerWithFrame:CGRectMake((WScreenWidth - WScanWidth) / 2 + WScanWidth, 0, (WScreenWidth - WScanWidth) / 2, WScreenHeight)];
//	[self createBackLayerWithFrame:CGRectMake((WScreenWidth - WScanWidth) / 2, 0, WScanWidth, WScreenHeight - WScanWidth - 170)];
//	[self createBackLayerWithFrame:CGRectMake((WScreenWidth - WScanWidth) / 2, WScreenHeight - 170, WScanWidth, 170)];
//	
//	
//	UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//	[scanButton setTitle:@"取消" forState:UIControlStateNormal];
//	[scanButton setTitleColor:WColorMain forState:UIControlStateNormal];
//	scanButton.titleLabel.font = [UIFont systemFontOfSize:15];
//	scanButton.frame = CGRectMake((WScreenWidth - 60) / 2, WScreenHeight - 80, 60, 40);
//	[scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:scanButton];
//	
//	UILabel * resultLabel = [[UILabel alloc] init];
//	resultLabel.numberOfLines = 0;
//	resultLabel.textAlignment = NSTextAlignmentCenter;
//	resultLabel.textColor=[UIColor whiteColor];
//	self.resultLabel = resultLabel;
//	[self.view addSubview:resultLabel];
//	[resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.top.equalTo(@32);
//		make.height.greaterThanOrEqualTo(@32);
//		make.left.equalTo(@(WPedding));
//		make.centerX.equalTo(@0);
//	}];
//	resultLabel.backgroundColor = WColorMain;
//	resultLabel.alpha = 0.33f;
	
	// Start
	[_session startRunning];
	[self.view addSubview:_line];
	_timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}

- (void)createBackLayerWithFrame:(CGRect)frame{
	CALayer *backLayer = [CALayer layer];
	backLayer.frame = frame;
	backLayer.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.550].CGColor;
	[self.view.layer addSublayer:backLayer];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
	NSString *stringValue;
	if (metadataObjects != nil && [metadataObjects count] >0){
		AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
		stringValue = metadataObject.stringValue;
		self.resultLabel.text = stringValue;
		
		[_session stopRunning];
		[_timer setFireDate:[NSDate distantFuture]];
	}else {
		
	}
}

- (void)backAction {
//	[self dismissViewControllerAnimated:YES completion:nil];
	
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
}

- (void)dealloc {
	[_session stopRunning];
	[_timer setFireDate:[NSDate distantFuture]];
	[_timer invalidate];
	_timer = nil;
	_session = nil;
	_device = nil;
	_input = nil;
	_output = nil;
}

- (BOOL)prefersStatusBarHidden {
	return YES;
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
