//
//  BCCameraPreviewView.m
//  Boo
//
//  Created by Chris O'Neil on 8/16/14.
//  Copyright (c) 2014 Chris O'Neil. All rights reserved.
//

#import "BCCameraPreviewView.h"
#import <AVFoundation/AVFoundation.h>

@implementation BCCameraPreviewView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (Class)layerClass
{
	return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureSession *)session
{
	return [(AVCaptureVideoPreviewLayer *)[self layer] session];
}

- (void)setSession:(AVCaptureSession *)session
{
	[(AVCaptureVideoPreviewLayer *)[self layer] setSession:session];
}

@end
