//
//  BCLaunchTransition.m
//  Boo
//
//  Created by Chris O'Neil on 8/15/14.
//  Copyright (c) 2014 Chris O'Neil. All rights reserved.
//

#import "BCLaunchTransition.h"
#import "BCLaunchViewController.h"
#import "BCHomeViewController.h"

static const CGFloat kTransitionShrinkAnimationDuration = 0.2;
static const CGFloat kTransitionEnlargeAnimationDuration = 0.45;
static const CGFloat kTransitionDuration = kTransitionShrinkAnimationDuration + kTransitionEnlargeAnimationDuration;
static const CGFloat kShrinkScale = 0.925;
static const CGFloat kEnlargeScale = 20.0 / kShrinkScale;

@implementation BCLaunchTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return kTransitionDuration;
}

#pragma mark - transitions
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if(self.isPresenting) {
        [self present:transitionContext]; // This particular transition does not support a presentation animation
    } else {
        [self dismiss:transitionContext];
    }
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor whiteColor];

    BCHomeViewController *toViewController = (BCHomeViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSAssert([toViewController isKindOfClass:[BCHomeViewController class]], @"This transition must pop to a BCHomeViewController");

    BCLaunchViewController *fromViewController = (BCLaunchViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    NSAssert([fromViewController isKindOfClass:[BCLaunchViewController class]], @"This transition must pop from a BCLaunchViewController");

    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    fromViewController.view.backgroundColor = [UIColor clearColor];
    toViewController.view.alpha = 0.0;

    [UIView animateWithDuration:kTransitionShrinkAnimationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toViewController.view.alpha = 1.0;
        fromViewController.view.transform = CGAffineTransformMakeScale(kShrinkScale, kShrinkScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:kTransitionEnlargeAnimationDuration delay:0.075 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            fromViewController.view.transform = CGAffineTransformMakeScale(kEnlargeScale, kEnlargeScale);
            fromViewController.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }];
}

- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext {
    [self doesNotRecognizeSelector:_cmd];
}

@end

