//
//  ProfileViewController.h
//  TransitionTest
//
//  Created by Valentina Chernoeva on 25.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) User *user;

@end
