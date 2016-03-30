//
//  ArrayDataSource.m
//  TransitionTest
//
//  Created by Valentina Chernoeva on 25.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "ArrayDataSource.h"
#import "Utils.h"

@interface ArrayDataSource ()

@property (copy, nonatomic) NSArray *items;
@property (copy, nonatomic) NSString *cellIdentifier;
@property (copy, nonatomic) TableViewCellConfigureBlock configureCellBlock;

@end

@implementation ArrayDataSource

- (instancetype)init {
    return [self initWithItems:nil cellIdentifier:nil configureCellBlock:nil];
}

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)cellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock {
    self = [super init];
    if (self) {
        self.items = [items copy];
        self.cellIdentifier = [cellIdentifier copy];
        self.configureCellBlock = [configureCellBlock copy];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.items.count) {
        return nil;
    }
    return self.items[indexPath.row];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    PERFORM_BLOCK_IF_NOT_NIL(self.configureCellBlock, cell, item);
    return cell;
}

@end
