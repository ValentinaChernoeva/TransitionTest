//
//  UsersViewController.m
//  TransitionTest
//
//  Created by Valentina Chernoeva on 25.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "UsersViewController.h"
#import "ArrayDataSource.h"
#import "NavigationDelegate.h"
#import "TransitionProtocol.h"
#import "ProfileViewController.h"
#import "UIView+Addition.h"
#import "UIViewController+Storyboard.h"
#import "User.h"
#import "UserInfoViewCell.h"


@interface UsersViewController () <TransitionProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ArrayDataSource *usersArrayDataSource;
@property (strong, nonatomic) NavigationDelegate *navigationDelegate;
@property (assign, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationDelegate = [[NavigationDelegate alloc] init];
    [self setupTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self.navigationDelegate;
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
    self.selectedIndexPath = indexPath;

    [self.navigationController pushViewController:profileVC animated:YES];

}

#pragma mark - TransitionProtocol

- (UIView *)transitionView {
    return [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
}
@end
