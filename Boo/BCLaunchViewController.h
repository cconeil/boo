//
//  BCLaunchViewController.h
//  Boo
//
//  Created by Chris O'Neil on 8/14/14.
//  Copyright (c) 2014 Chris O'Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCLaunchViewController : UIViewController
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) id<UIViewControllerAnimatedTransitioning> transitionController;

@end
