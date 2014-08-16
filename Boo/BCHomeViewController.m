//
//  BCHomeViewController.m
//  Boo
//
//  Created by Chris O'Neil on 8/14/14.
//  Copyright (c) 2014 Chris O'Neil. All rights reserved.
//

#import "BCHomeViewController.h"

@interface BCHomeViewController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation BCHomeViewController

+ (instancetype)homeViewController {
    return [[BCHomeViewController alloc] initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.backgroundImageView.image = [UIImage imageNamed:@"home_view"];
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.backgroundImageView];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
