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
#import "MapHeaderView.h"
#import "Utils.h"

NSString * const kDetailCellIdentifier = @"detailCell";
NSInteger const kDetailEstimatedRowHeight = 49;
NSString * const kDetailMapHeaderIdentifier = @"mapHeader";
NSInteger const kDetailNumberOfSections = 1;
NSInteger const kDetailSectionHeaderHeight = 244.f;


@interface MovieDetailViewController ()

@property (nonatomic, strong) MovieDetailViewModel *viewModel;
@property (nonatomic, strong) NSArray *detailItems;

@end


@implementation MovieDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.viewModel.title;
    
    self.tableView.estimatedRowHeight = kDetailEstimatedRowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupViewModel:(MovieDetailViewModel *)inViewModel {
    self.viewModel = inViewModel;
    self.detailItems = [inViewModel detailItemsFromViewModel];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return kDetailNumberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.detailItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailItemTableViewCell *cell = (DetailItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kDetailCellIdentifier
                                                                                               forIndexPath:indexPath];
    
    [cell setupViewModel:[self.detailItems objectAtIndex:indexPath.row]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    MapHeaderView *headerView = (MapHeaderView *)[tableView dequeueReusableCellWithIdentifier:kDetailMapHeaderIdentifier];
    [headerView setupLocation:self.viewModel.latlong];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kDetailSectionHeaderHeight;
}


@end
