//
//  MovieListViewModel.h
//  MyMovies
//
//  Created by Trivedi, Astha on 16/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieListViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *movieList;

+ (MovieListViewModel *)viewModel;
- (void)viewModelWithMovieFetchObjects:(NSArray *)inFetchedObjects;

@end
