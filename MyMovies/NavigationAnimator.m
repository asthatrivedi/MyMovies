//
//  NavigationAnimator.m
//  MyMovies
//
//  Created by Trivedi, Astha on 20/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "NavigationAnimator.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation NavigationAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
    
  
    /*
    UIView *containerView = [transitionContext containerView];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    
    CGFloat direction = self.reverse? -1 : 1;
    CGFloat constant = -0.005;
    
    toView.layer.anchorPoint = CGPointMake(direction == 1 ? 0 : 1, 0.5);
    toView.layer.anchorPoint = CGPointMake(direction == 1 ? 1 : 0, 0.5);
    
    CATransform3D viewFromTransform = CATransform3DMakeRotation(direction * (CGFloat)M_PI_2, 0.0, 1.0, 0.0);
    CATransform3D viewToTransform = CATransform3DMakeRotation(-direction * (CGFloat)M_PI_2, 0.0, 1.0, 0.0);
    viewFromTransform.m34 = constant;
    viewToTransform.m34 = constant;
    
    containerView.transform = CGAffineTransformMakeTranslation(direction * containerView.frame.size.width/2.0, 0);
    toView.layer.transform = viewToTransform;
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        containerView.transform = CGAffineTransformMakeTranslation(-direction * containerView.frame.size.width/2.0, 0);
        fromView.layer.transform = viewFromTransform;
        toView.layer.transform =  CATransform3DIdentity;

    } completion:^(BOOL finished) {
        finished = YES;
        containerView.transform = CGAffineTransformIdentity;
        fromView.layer.transform = CATransform3DIdentity;
        toView.layer.transform = CATransform3DIdentity;
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        
        if ([transitionContext transitionWasCancelled]) {
            [toView removeFromSuperview];
        }
        else {
            [fromView removeFromSuperview];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
     */
}

@end
