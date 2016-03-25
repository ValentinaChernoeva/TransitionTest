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

@interface UsersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ArrayDataSource *photosArrayDataSource;

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
    
    
    NSArray *users = [self users];
    self.photosArrayDataSource = [[ArrayDataSource alloc] initWithItems:users
                                                         cellIdentifier:[UserInfoViewCell reuseIdentifier]
                                                     configureCellBlock:configureCell];
    self.tableView.dataSource = self.photosArrayDataSource;
}

- (NSArray *)users {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10 ; i++) {
        User *user = [User new];
        user.name = [NSString stringWithFormat:@"User %d", i];
        user.email = [NSString stringWithFormat:@"Email %d", i];
        [array addObject:user];
    }
    return array;
}

@end
