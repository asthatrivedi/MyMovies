//
//  CustomTransitionController.m
//  MyMovies
//
//  Created by Trivedi, Astha on 20/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "CustomTransitionController.h"

@interface CustomTransitionController ()

@end

@implementation CustomTransitionController


- (void)attachToViewController:(UIViewController *)viewController {
    self.navController = viewController.navigationController;
    [self _setupGestureRecognizer:viewController.view];
}

#pragma mark - Private Helper Methods

- (void)_setupGestureRecognizer:(UIView *)view {
    [view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(_handlePanGesture:)]];
}

- (void)_handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    
    CGPoint viewTranslation = [panGesture translationInView:panGesture.view.superview];
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            [self.navController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGFloat constant = (CGFloat)fminf(fmaxf(viewTranslation.x/200.0, 0.0), 1.0);
            self.shouldCompleteTransition = constant > 0.5;
            [self updateInteractiveTransition:constant];
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            self.transitionInProgress = NO;
            if (!self.shouldCompleteTransition || panGesture.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            }
            else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
