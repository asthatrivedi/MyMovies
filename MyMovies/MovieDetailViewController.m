//
//  MovieDetailViewController.m
//  MyMovies
//
//  Created by Trivedi, Astha on 14/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "MovieDetailViewController.h"

#import "DetailItemTableViewCell.h"
#import "ImageHeader.h"
#import "MovieDetailViewModel.h"
#import "MapHeaderView.h"
#import "Utils.h"

@interface MovieDetailViewController ()

@property (nonatomic, strong) MovieDetailViewModel *viewModel;
@property (nonatomic, strong) NSArray *detailItems;

@end

@implementation MovieDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.viewModel.title;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(_handleImageDownloadedNotif:)
//                                                 name:kImageDownloadedKey
//                                               object:nil];
    
//    [self _setupTableViewHeader];
    
    self.tableView.estimatedRowHeight = 49;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
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
    DetailItemTableViewCell *cell = (DetailItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"detailCell"
                                                                                               forIndexPath:indexPath];
    
    [cell setupViewModel:[self.detailItems objectAtIndex:indexPath.row]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    MapHeaderView *headerView = (MapHeaderView *)[tableView dequeueReusableCellWithIdentifier:@"mapHeader"];
    
    [headerView setupLocation:self.viewModel.latlong];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 244.f;
}

#pragma mark - Private Helper Methods

- (void)_handleImageDownloadedNotif:(NSNotification *)notif {
    
}

- (void)_setupTableViewHeader {
    
    ImageHeader *header = (ImageHeader *)[self.tableView dequeueReusableCellWithIdentifier:@"tableHeader"];
    // setup image here.
    self.tableView.tableHeaderView = header;
}

@end
