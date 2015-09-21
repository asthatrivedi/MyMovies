//
//  MovieDetailViewModel.m
//  MyMovies
//
//  Created by Trivedi, Astha on 16/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "MovieDetailViewModel.h"

#import "DetailItemViewModel.h"
#import "Movie.h"
#import "Location.h"

@implementation MovieDetailViewModel

+ (MovieDetailViewModel *)movieDetailViewModel:(Movie *)movie {
    
    MovieDetailViewModel *cellViewModel = [[MovieDetailViewModel alloc] init];
    cellViewModel.title = movie.title;
    cellViewModel.year = movie.year;
    cellViewModel.actors = movie.actors;
    cellViewModel.director = movie.director;
    cellViewModel.production = movie.production;
    cellViewModel.writer = movie.writer;
    cellViewModel.movieId = movie.movieId;
    cellViewModel.latlong = movie.latlong;
    
    return cellViewModel;
}

- (NSArray *)detailItemsFromViewModel {
    
    NSMutableArray *detailItems = [NSMutableArray array];
    
    [detailItems addObject:[DetailItemViewModel viewModelWithInfoType:@"Actors" andValue:self.actors]];
    [detailItems addObject:[DetailItemViewModel viewModelWithInfoType:@"director" andValue:self.director]];
    [detailItems addObject:[DetailItemViewModel viewModelWithInfoType:@"Production" andValue:self.production]];
    [detailItems addObject:[DetailItemViewModel viewModelWithInfoType:@"Year" andValue:self.year]];
    if ([self.writer length] > 0)
        [detailItems addObject:[DetailItemViewModel viewModelWithInfoType:@"Writer" andValue:self.writer]];
    
    return detailItems;
}


@end
