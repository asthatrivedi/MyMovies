//
//  MovieDetailViewModel.h
//  MyMovies
//
//  Created by Trivedi, Astha on 16/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Movie;

@interface MovieDetailViewModel : NSObject

@property (nonatomic, retain) NSString * actors;
@property (nonatomic, retain) NSString * director;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * production;
@property (nonatomic, retain) NSString * writer;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, assign) NSNumber * movieId;

+ (MovieDetailViewModel *)movieDetailViewModel:(Movie *)movie;

- (NSArray *)detailItemsFromViewModel;

@end
