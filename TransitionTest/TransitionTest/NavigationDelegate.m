//
//  NavigationDelegate.m
//  TransitionTest
//
//  Created by Valentina Chernoeva on 30.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "NavigationDelegate.h"
#import "Animator.h"
#import "ProfileViewController.h"
#import "UsersViewController.h"

@implementation NavigationDelegate

#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    Animator *animator = [[Animator alloc] init];
    
    if (operation == UINavigationControllerOperationPush) {
        animator.fromView = ((UsersViewController *)fromVC).selectedCell;
        animator.toView = ((ProfileViewController *)toVC).headerView;
    } else if ([fromVC isKindOfClass:[self class]]) {
        return nil;
    } else {
        animator.fromView = ((ProfileViewController *)fromVC).headerView;
        animator.toView = ((UsersViewController *)toVC).selectedCell;
    }
    return animator;
}

@end
