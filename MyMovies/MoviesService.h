//
//  MoviesService.h
//  MyMovies
//
//  Created by Trivedi, Astha on 15/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Utils.h"

@class MovieListViewModel;

@interface MoviesService : NSObject

+ (instancetype)sharedService;

- (void)getMovies;
- (void)loadMoreMovies;
- (MovieListViewModel *)movieList;
- (void)setupCurrentLocation;
- (void)sortMoviesWithParameter:(kSortParameter)parameter;

@end
