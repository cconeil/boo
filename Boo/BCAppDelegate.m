//
//  BCAppDelegate.m
//  Boo
//
//  Created by Chris O'Neil on 8/14/14.
//  Copyright (c) 2014 Chris O'Neil. All rights reserved.
//

#import "BCAppDelegate.h"
#import "BCHomeViewController.h"
#import "BCLaunchViewController.h"
#import "BCLaunchTransition.h"

@interface BCAppDelegate () <UINavigationControllerDelegate>
@property (nonatomic, strong) UINavigationController *rootNavigationController;
@end

@implementation BCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    self.rootNavigationController = [[UINavigationController alloc] initWithRootViewController:[BCHomeViewController homeViewController]];
    self.rootNavigationController.navigationBar.hidden = YES;
    self.rootNavigationController.delegate = self;
    self.window.rootViewController = self.rootNavigationController;

    // Add the Launch View Controller to Pop with a fancy animation
    BCLaunchViewController *launchViewController = [[BCLaunchViewController alloc] initWithNibName:nil bundle:nil];
    BCLaunchTransition *launchTransition = [[BCLaunchTransition alloc] init];
    launchTransition.presenting = NO;
    launchViewController.transitionController = launchTransition;

    [self.rootNavigationController pushViewController:launchViewController animated:NO];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop && [fromVC respondsToSelector:@selector(transitionController)]) {
        return ((BCLaunchViewController *)fromVC).transitionController;
    }
    return nil;
}

@end
