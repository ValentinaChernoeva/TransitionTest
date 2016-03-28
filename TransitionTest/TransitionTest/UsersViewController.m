//
//  UsersViewController.m
//  TransitionTest
//
//  Created by Valentina Chernoeva on 25.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "UsersViewController.h"
#import "Animator.h"
#import "ArrayDataSource.h"
#import "UIView+Addition.h"
#import "UIViewController+Storyboard.h"
#import "User.h"
#import "UserInfoViewCell.h"
#import "ProfileViewController.h"

@interface UsersViewController () <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ArrayDataSource *usersArrayDataSource;
@property (strong, nonatomic) Animator *animator;

@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)setupTableView {
    
    TableViewCellConfigureBlock configureCell = ^(UserInfoViewCell *cell, User *user) {
        cell.nameLabel.text = user.name;
        cell.emailLabel.text = user.email;
    };
    
    self.usersArrayDataSource = [[ArrayDataSource alloc] initWithItems:[self items]
                                                         cellIdentifier:[UserInfoViewCell reuseIdentifier]
                                                     configureCellBlock:configureCell];
    self.tableView.dataSource = self.usersArrayDataSource;
}

- (NSArray <User*> *)items {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10 ; i++) {
        User *user = [User new];
        user.name = [NSString stringWithFormat:@"User %d", i];
        user.email = [NSString stringWithFormat:@"Email %d", i];
        [array addObject:user];
    }
    return array;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileViewController *profileVC = [ProfileViewController instantiateFromMainStoryboard];
    profileVC.user = [self.usersArrayDataSource itemAtIndexPath:indexPath];
    self.selectedCell = [tableView cellForRowAtIndexPath:indexPath];

    [self.navigationController pushViewController:profileVC animated:YES];

}

#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    Animator *animator = [[Animator alloc] init];
    if (operation == UINavigationControllerOperationPush) {
         animator.transitioningType = TransitioningFromUserToProfile;
    } else {
        animator.transitioningType = TransitioningFromProfileToUser;
    }
    return animator;
}
@end
