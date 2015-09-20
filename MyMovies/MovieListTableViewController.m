//
//  MovieListTableViewController.m
//  MyMovies
//
//  Created by Trivedi, Astha on 14/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "MovieListTableViewController.h"

#import "MovieDetailViewController.h"
#import "MovieListTableViewCell.h"
#import "MovieListViewModel.h"
#import "MoviesService.h"
#import "Utils.h"

@interface MovieListTableViewController ()

@property (nonatomic, strong) MovieListViewModel *viewModel;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) BOOL isLoadingMoreResults;

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
    MovieListTableViewCell *cell =
        (MovieListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                                  forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setupMovieListCellWithViewModel:[self.viewModel.movieList objectAtIndex:indexPath.row]];
    
    if (!self.isLoadingMoreResults && indexPath.row == ([self.viewModel.movieList count] - 1)) {
        self.isLoadingMoreResults = YES;
        [self _loadMoreMovies];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
    [self _showMovieDetailViewWithIndex:indexPath.row];
}

#pragma mark - Button Actions

- (IBAction)_showActionSheetToSortData:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Distance" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [[MoviesService sharedService] sortMoviesWithParameter:kSortParameterDistance];

        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Movie Name" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [[MoviesService sharedService] sortMoviesWithParameter:kSortParameterMovieName];

        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Year" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [[MoviesService sharedService] sortMoviesWithParameter:kSortParameterYear];

        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - Private Helper Methods


- (void)_handleUpdateDataNotification:(NSNotification *)notif {
    
    NSDictionary *userInfo = notif.userInfo;
    NSString *errorString = userInfo[kErrorKey];
    
    self.isLoadingMoreResults = NO;
    
    if ([errorString length]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                        message:errorString
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else {
        self.viewModel = [[MoviesService sharedService] movieList];
        if ([self.viewModel.movieList count] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"No Movies Playing in your area."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        [self.tableView reloadData];
    }
}

- (void)_loadMoreMovies {
    [[MoviesService sharedService] loadMoreMovies];
}

- (void)_showMovieDetailViewWithIndex:(NSInteger)index {
    MovieDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"movieDetail"];
    [controller setupViewModel:[self.viewModel.movieList objectAtIndex:index]];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
