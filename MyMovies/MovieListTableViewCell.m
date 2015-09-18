//
//  MovieListTableViewCell.m
//  MyMovies
//
//  Created by Trivedi, Astha on 16/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "MovieListTableViewCell.h"

#import "MovieListCellViewModel.h"

@interface MovieListTableViewCell ()

@property (nonatomic, strong) MovieListCellViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UILabel *movieTitleWithYear;
@property (weak, nonatomic) IBOutlet UILabel *actors;
@property (weak, nonatomic) IBOutlet UILabel *location;

@end

@implementation MovieListTableViewCell

- (void)setupMovieListCellWithViewModel:(MovieListCellViewModel *)viewModel {
    
    self.viewModel = viewModel;
    
    self.movieTitleWithYear.text = [NSString stringWithFormat:@"%@ (%@)", viewModel.title, viewModel.year];
    self.actors.text = viewModel.actor;
    self.location.text = viewModel.location;
}

@end
