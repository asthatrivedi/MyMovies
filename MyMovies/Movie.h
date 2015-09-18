//
//  Movie.h
//  MyMovies
//
//  Created by Trivedi, Astha on 15/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location;

@interface Movie : NSManagedObject

@property (nonatomic, retain) NSString * actors;
@property (nonatomic, retain) NSString * director;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * production;
@property (nonatomic, retain) NSString * writer;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, assign) NSNumber * movieId;


+ (NSArray *)getMoviesFromCoreDataIfExistWithManageContext:(NSManagedObjectContext *)context;

+ (NSArray *)parseMovieResultsJson:(NSArray *)jsonResponse
                             index:(NSInteger)index
                    managedContext:(NSManagedObjectContext *)managedContext;

@end
