//
//  MovieListTableViewController.m
//  MyMovies
//
//  Created by Trivedi, Astha on 14/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "MovieListTableViewController.h"

#import "MovieListTableViewCell.h"
#import "MovieListViewModel.h"
#import "MoviesService.h"
#import "Utils.h"

@interface MovieListTableViewController ()

@property (nonatomic, strong) MovieListViewModel *viewModel;

@end

@implementation MovieListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Movies";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_handleUpdateDataNotification:)
                                                 name:kMovieResultsKey
                                               object:nil];
    self.tableView.estimatedRowHeight = 111;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.viewModel.movieList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieListTableViewCell *cell = (MovieListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setupMovieListCellWithViewModel:[self.viewModel.movieList objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - Private Helper Methods


- (void)_handleUpdateDataNotification:(NSNotification *)notif {
    self.viewModel = [[MoviesService sharedService] movieList];
    [self.tableView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
