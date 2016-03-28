//
//  Animator.m
//  TransitionTest
//
//  Created by Valentina Chernoeva on 25.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "Animator.h"
#import "UserProfileViewController.h"
#import "UserInfoViewCell.h"

@implementation Animator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    UserProfileViewController *toViewController = (UserProfileViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UserInfoViewCell *cell = self.selectedCell;
    UIView *cellSnapshot = [cell snapshotViewAfterScreenUpdates:NO];
    cellSnapshot.frame = [containerView convertRect:cell.frame fromView:cell.superview];
    cell.hidden = YES;
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0.f;
    toViewController.headerView.hidden = YES;
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:cellSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        toViewController.view.alpha = 1.f;
        
        CGRect frame = [containerView convertRect:toViewController.headerView.frame fromView:toViewController.view];
        CGRect newFrame = cellSnapshot.frame;
        newFrame.origin = frame.origin;
        cellSnapshot.frame = newFrame;
    } completion:^(BOOL finished) {
        toViewController.headerView.hidden = NO;
        cell.hidden = NO;
        [cellSnapshot removeFromSuperview];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

}

@end
