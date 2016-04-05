//
//  Animator.m
//  TransitionTest
//
//  Created by Valentina Chernoeva on 25.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "Animator.h"
#import "TransitionProtocol.h"

@implementation Animator

- (instancetype)initWithOperation:(UINavigationControllerOperation)operation {
    self = [super init];
    if (self) {
        self.operation = operation;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIViewController <TransitionProtocol> *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <TransitionProtocol> *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *fromView = fromViewController.transitionView;
    UIView *toView = toViewController.transitionView;
 
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
        CGRect convertedRect = [containerView convertRect:toView.frame fromView:toView.superview];
        CGFloat translationX = CGRectGetMinX(convertedRect) - CGRectGetMinX(snapshot.frame);
        CGFloat translationY = CGRectGetMinY(convertedRect) - CGRectGetMinY(snapshot.frame);
         snapshot.transform = CGAffineTransformMakeTranslation(translationX, translationY);
    } completion:^(BOOL finished) {
        toView.hidden = NO;
        fromView.hidden = NO;
        [snapshot removeFromSuperview];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
