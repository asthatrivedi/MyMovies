//
//  MovieDetailViewModel.h
//  MyMovies
//
//  Created by Trivedi, Astha on 16/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Movie;
@class Location;

@interface MovieDetailViewModel : NSObject

@property (nonatomic, strong) NSString * actors;
@property (nonatomic, strong) NSString * director;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * production;
@property (nonatomic, strong) NSString * writer;
@property (nonatomic, strong) NSString * year;
@property (nonatomic, strong) NSNumber * movieId;
@property (nonatomic, strong) Location * latlong;
@property (nonatomic, strong) UIImage *streetViewImage;

+ (MovieDetailViewModel *)movieDetailViewModel:(Movie *)movie;

- (NSArray *)detailItemsFromViewModel;

@end



