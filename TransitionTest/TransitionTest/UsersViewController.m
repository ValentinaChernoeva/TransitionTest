//
//  UsersViewController.m
//  TransitionTest
//
//  Created by Valentina Chernoeva on 25.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "UsersViewController.h"
#import "ArrayDataSource.h"
#import "UIView+Addition.h"
#import "User.h"
#import "UserInfoViewCell.h"
#import "UserProfileViewController.h"

@interface UsersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ArrayDataSource *usersArrayDataSource;

@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)setupTableView {
    
    TableViewCellConfigureBlock configureCell = ^(UserInfoViewCell *cell, User *user) {
        cell.nameLabel.text = user.name;
        cell.emailLabel.text = user.email;
    };
    
    
    NSArray *users = [self items];
    self.usersArrayDataSource = [[ArrayDataSource alloc] initWithItems:users
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
    UserProfileViewController *profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
    profileVC.user = [self.usersArrayDataSource itemAtIndexPath:indexPath];
    [self.navigationController pushViewController:profileVC animated:YES];
}


@end
