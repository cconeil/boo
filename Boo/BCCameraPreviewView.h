//
//  BCCameraPreviewView.h
//  Boo
//
//  Created by Chris O'Neil on 8/16/14.
//  Copyright (c) 2014 Chris O'Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCaptureSession;

@interface BCCameraPreviewView : UIView
@property (nonatomic) AVCaptureSession *session;
@end
