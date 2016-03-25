//
//  NavigationControllerDelegate.m
//  TransitionTest
//
//  Created by Valentina Chernoeva on 25.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "Animator.h"
#import "UserProfileViewController.h"

@interface NavigationControllerDelegate ()

@property (weak, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) Animator* animator;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;

@end

@implementation NavigationControllerDelegate

- (void)awakeFromNib {
    [super awakeFromNib];
    self.animator = [Animator new];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

    if (operation == UINavigationControllerOperationPush) {
        return self.animator;
    }
    
    return nil;
}

@end
