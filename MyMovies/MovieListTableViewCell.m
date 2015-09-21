//
//  MovieListTableViewCell.m
//  MyMovies
//
//  Created by Trivedi, Astha on 16/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "MovieListTableViewCell.h"

#import "MovieDetailViewModel.h"
#import "Location.h"

@interface MovieListTableViewCell ()

@property (nonatomic, strong) MovieDetailViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UILabel *actors;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *year;

@end

@implementation MovieListTableViewCell

- (void)setupMovieListCellWithViewModel:(MovieDetailViewModel *)viewModel {
    
    self.viewModel = viewModel;
    
    self.movieTitle.text = viewModel.title;
    self.actors.text = viewModel.actors;
    self.location.text = viewModel.latlong.location;
    self.year.text = viewModel.year;
}

@end
