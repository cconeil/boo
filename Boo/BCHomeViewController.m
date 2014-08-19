//
//  BCHomeViewController.m
//  Boo
//
//  Created by Chris O'Neil on 8/14/14.
//  Copyright (c) 2014 Chris O'Neil. All rights reserved.
//

#import "BCHomeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "BCCameraPreviewView.h"

NSString * const BCHomeViewControllerDidLaunchCameraNotification = @"BCHomeViewControllerDidLaunchCameraNotification";

@interface BCHomeViewController ()

@property (nonatomic, strong) BCCameraPreviewView *previewView;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDeviceInput *videoDeviceInput;
@property (nonatomic) dispatch_queue_t sessionQueue;
@property (nonatomic, assign) BOOL deviceAuthorized;

@end

@implementation BCHomeViewController

+ (instancetype)homeViewController
{
    return [[BCHomeViewController alloc] initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        [self checkDeviceAuthorizationStatus];

        self.captureSession = [[AVCaptureSession alloc] init];
        self.sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL);

        dispatch_async(self.sessionQueue, ^{
            AVCaptureDevice *videoDevice = [BCHomeViewController deviceWithMediaType:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionFront];
            AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];

            if ([self.captureSession canAddInput:videoDeviceInput]) {
                [self.captureSession addInput:videoDeviceInput];
                self.videoDeviceInput = videoDeviceInput;
                [self.captureSession startRunning];

                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:BCHomeViewControllerDidLaunchCameraNotification object:nil userInfo:nil];
                });
            }
        });

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.previewView = [[BCCameraPreviewView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.previewView];
    self.previewView.session = self.captureSession;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)checkDeviceAuthorizationStatus
{
	NSString *mediaType = AVMediaTypeVideo;

	[AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
		if (granted) {
			self.deviceAuthorized = YES;
		} else {
			dispatch_async(dispatch_get_main_queue(), ^{
				[[[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"We don't have permission to use Camera, please change privacy settings" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
				[self setDeviceAuthorized:NO];
			});
		}
	}];
}

+ (AVCaptureDevice *)deviceWithMediaType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position
{
	NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
	AVCaptureDevice *captureDevice = [devices firstObject];

	for (AVCaptureDevice *device in devices) {
		if (device.position == position) {
			return device;
		}
	}

	return captureDevice;
}

@end
