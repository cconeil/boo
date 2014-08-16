//
//  BCLaunchViewController.m
//  Boo
//
//  Created by Chris O'Neil on 8/14/14.
//  Copyright (c) 2014 Chris O'Neil. All rights reserved.
//

#import "BCLaunchViewController.h"

@interface BCLaunchViewController ()
@end

@implementation BCLaunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.backgroundImageView.image = [UIImage imageNamed:@"launch_mask_large"];
    self.backgroundImageView.contentMode = UIViewContentModeCenter;
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.backgroundImageView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.navigationController popViewControllerAnimated:YES];
}
 
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
