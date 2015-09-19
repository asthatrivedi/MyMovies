//
//  MovieDetailViewController.m
//  MyMovies
//
//  Created by Trivedi, Astha on 14/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "MovieDetailViewController.h"

#import "DetailItemTableViewCell.h"
#import "MovieDetailViewModel.h"

@interface MovieDetailViewController ()

@property (nonatomic, strong) MovieDetailViewModel *viewModel;
@property (nonatomic, strong) NSArray *detailItems;

@end

@implementation MovieDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.viewModel.title;
}

- (void)setupViewModel:(MovieDetailViewModel *)inViewModel {
    self.viewModel = inViewModel;
    self.detailItems = [inViewModel detailItemsFromViewModel];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.detailItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailItemTableViewCell *cell = (DetailItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    [cell setupViewModel:[self.detailItems objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
