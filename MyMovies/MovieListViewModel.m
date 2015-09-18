//
//  MovieListViewModel.m
//  MyMovies
//
//  Created by Trivedi, Astha on 16/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "MovieListViewModel.h"

#import "Movie.h"
#import "MovieListCellViewModel.h"
#import "MoviesService.h"
#import "Utils.h"

@implementation MovieListViewModel


+ (MovieListViewModel *)viewModel
{
    return [[MovieListViewModel alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _movieList = [NSMutableArray array];
    }
    return self;
}

- (void)viewModelWithMovieFetchObjects:(NSArray *)inFetchedObjects {
    [self.movieList addObjectsFromArray:[MovieListViewModel _parseFetchObjectsIntoViewModel:inFetchedObjects]];
}

#pragma mark - Private Helper Methods

+ (NSArray  *)_parseFetchObjectsIntoViewModel:(NSArray *)fetchObjects {
    
    NSMutableArray *viewModels = [NSMutableArray array];
    for (Movie *inMovie in fetchObjects) {
        [viewModels addObject:[MovieListCellViewModel movieListCellViewModel:inMovie]];
    }
    
    return viewModels;
}

@end
