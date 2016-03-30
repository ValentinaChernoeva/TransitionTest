//
//  Animator.h
//  TransitionTest
//
//  Created by Valentina Chernoeva on 25.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TransitioningType) {
    TransitioningFromUserToProfile,
    TransitioningFromProfileToUser
};

@interface Animator : NSObject <UIViewControllerAnimatedTransitioning>

@property (strong, nonatomic) UIView *fromView;
@property (strong, nonatomic) UIView *toView;

@end
