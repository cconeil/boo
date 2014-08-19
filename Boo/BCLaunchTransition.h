//
//  BCLaunchTransition.h
//  Boo
//
//  Created by Chris O'Neil on 8/15/14.
//  Copyright (c) 2014 Chris O'Neil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCLaunchTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter = isPresenting) BOOL presenting;

@end
