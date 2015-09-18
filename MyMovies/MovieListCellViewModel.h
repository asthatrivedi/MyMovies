//
//  MovieListCellViewModel.h
//  MyMovies
//
//  Created by Trivedi, Astha on 16/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Movie.h"

@interface MovieListCellViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *actor;
@property (nonatomic, strong) NSString *location;

+ (MovieListCellViewModel *)movieListCellViewModel:(Movie *)movie;

@end
