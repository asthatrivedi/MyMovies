//
//  MovieListCellViewModel.m
//  MyMovies
//
//  Created by Trivedi, Astha on 16/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "MovieListCellViewModel.h"

#import "Movie.h"

@implementation MovieListCellViewModel

+ (MovieListCellViewModel *)movieListCellViewModel:(Movie *)movie {
    
    MovieListCellViewModel *cellViewModel = [[MovieListCellViewModel alloc] init];
    cellViewModel.title = movie.title;
    cellViewModel.year = movie.year;
    cellViewModel.actor = movie.actors;
    cellViewModel.location = movie.location;
    
    return cellViewModel;
}

@end
