//
//  Animator.m
//  TransitionTest
//
//  Created by Valentina Chernoeva on 25.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "Animator.h"
#import "UsersViewController.h"
#import "ProfileViewController.h"
#import "UserInfoViewCell.h"

@implementation Animator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *fromView = self.fromView;
    UIView *toView = self.toView;

    UIView *snapshot = [fromView snapshotViewAfterScreenUpdates:NO];
    snapshot.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
    fromView.hidden = YES;
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0.f;
    toView.hidden = YES;
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:snapshot];
    
    [UIView animateWithDuration:duration animations:^{
        toViewController.view.alpha = 1.f;
        CGRect frame = [containerView convertRect:toView.frame fromView:toView.superview];
        CGRect newFrame = snapshot.frame;
        newFrame.origin = frame.origin;
        snapshot.frame = newFrame;
    } completion:^(BOOL finished) {
        toView.hidden = NO;
        fromView.hidden = NO;
        [snapshot removeFromSuperview];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

}

@end
