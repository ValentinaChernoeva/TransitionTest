//
//  UserProfileViewController.m
//  TransitionTest
//
//  Created by Valentina Chernoeva on 25.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "UserProfileViewController.h"
#import "User.h"

@interface UserProfileViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillOfViews];
}

- (void)fillOfViews {
    self.nameLabel.text = self.user.name;
    self.emailLabel.text = self.user.email;
}

@end
