//
//  ProfileViewController.m
//  TransitionTest
//
//  Created by Valentina Chernoeva on 25.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "ProfileViewController.h"
#import "Animator.h"
#import "TransitionProtocol.h"
#import "User.h"

@interface ProfileViewController () <TransitionProtocol>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configurateView];
}

- (void)configurateView {
    self.nameLabel.text = self.user.name;
    self.emailLabel.text = self.user.email;
}

#pragma mark - TransitionProtocol

- (UIView *)transitionView {
    return self.headerView;
}

@end
