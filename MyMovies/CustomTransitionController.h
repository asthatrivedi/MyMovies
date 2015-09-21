//
//  CustomTransitionController.h
//  MyMovies
//
//  Created by Trivedi, Astha on 20/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTransitionController : UIPercentDrivenInteractiveTransition

@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, assign) BOOL shouldCompleteTransition;
@property (nonatomic, assign) BOOL transitionInProgress;

- (void)attachToViewController:(UIViewController *)viewController;

@end
