//
//  Movie.m
//  MyMovies
//
//  Created by Trivedi, Astha on 15/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "Movie.h"
#import "Location.h"


@implementation Movie

@dynamic actors;
@dynamic director;
@dynamic latlong;
@dynamic location;
@dynamic movieId;
@dynamic production;
@dynamic title;
@dynamic writer;
@dynamic year;


NSString * const kTitle = @"title";
NSString * const kYear = @"release_year";
NSString * const kWriter = @"writer";
NSString * const kDirector = @"director";
NSString * const kProduction = @"production_company";
NSString * const kLocation = @"locations";
NSString * const kActor = @"actor";

NSString * const kMovieIDPredicate = @"movieId == %ld";
NSString * const kMovieEntity = @"Movie";


+ (NSArray *)getMoviesFromCoreDataIfExistWithManageContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Movie"];
    
    NSError *error = nil;
    
    return [context executeFetchRequest:fetch error:&error];
}


+ (NSArray *)parseMovieResultsJson:(NSArray *)jsonResponse
                             index:(NSInteger)index
                    managedContext:(NSManagedObjectContext *)managedContext
{
    NSMutableArray *inResults = [NSMutableArray array];
    NSInteger nextIndex = index + 1;
    for (NSDictionary *inResult in jsonResponse) {
        [inResults addObject:[Movie _parseIndividualMovieJson:inResult
                                                        index:nextIndex
                                                manageContext:managedContext]];
        nextIndex++;
    }
    
    return inResults;
}

#pragma mark - Private Helper Methods


+ (NSString *)_actorsStringFromJson:(NSDictionary *)json {
    NSInteger index = 1;
    NSString *actorsString = json[[NSString stringWithFormat:@"%@_%ld",kActor,(long)index]];
    index++;
    
    while (index <= 3) {
        NSString *nextActor = json[[NSString stringWithFormat:@"%@_%ld",kActor,(long)index]];
        if ([nextActor length])
        {
            actorsString = [actorsString stringByAppendingString:[NSString stringWithFormat:@", %@",nextActor]];
        }
        index++;
    }
    
    return actorsString;
}


+ (NSString *)_getFullLocationAddress:(NSString *)address {
    
    if (address) {
        return [NSString stringWithFormat:@"%@ %@", address, @", San Francisco"];
    }
    else {
        return @"San Francisco";
    }
}


+ (Movie *)_parseIndividualMovieJson:(NSDictionary *)resultJson
                               index:(NSInteger)index
                       manageContext:(NSManagedObjectContext *)context {
    
    // Fetch first to ensure there are no duplicate entries.
    NSString *movieIdString = [NSString stringWithFormat:@"%@_%ld",resultJson[kTitle],index];
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:kMovieEntity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:kMovieIDPredicate, @(movieIdString.hash)];
    [fetch setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:fetch error:&error];
    
    Movie *inMovie;
    
    if ([results count] == 0) {
        
        // Add a new entry.
        inMovie =
            (Movie *)[NSEntityDescription insertNewObjectForEntityForName:kMovieEntity
                                                    inManagedObjectContext:context];
        
        inMovie.title = resultJson[kTitle];
        inMovie.movieId = @(movieIdString.hash);
        inMovie.year = resultJson[kYear];
        inMovie.director = resultJson[kDirector];
        inMovie.production = resultJson[kProduction];
        inMovie.writer = resultJson[kWriter];
        inMovie.actors = [Movie _actorsStringFromJson:resultJson];
        
        Location *inLocation = [NSEntityDescription insertNewObjectForEntityForName:kLocationEntity
                                                             inManagedObjectContext:context];
        inLocation.location = [Movie _getFullLocationAddress:resultJson[kLocation]];
        [inLocation setLatLongForCoordinate];
        inMovie.latlong = inLocation;
    }
    else {
        inMovie = [results firstObject];
    }
    
    return inMovie;
}

@end
