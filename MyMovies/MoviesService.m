//
//  MoviesService.m
//  MyMovies
//
//  Created by Trivedi, Astha on 15/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "MoviesService.h"
#import <MapKit/MapKit.h>

#import "AppDelegate.h"
#import "Movie.h"
#import "MovieDetailViewModel.h"
#import "MovieListViewModel.h"
#import "NetworkService.h"


NSString * const kBaseUrl = @"https://data.sfgov.org/resource/yitu-d5am.json?";
NSString * const kReloadUrl = @"https://data.sfgov.org/resource/yitu-d5am.json?$limit=10&$offset=10";
NSString * const kLimitKey = @"$limit=%ld";
NSString * const kOffsetKey = @"&$offset=%ld";

NSString * const kPlaceImageUrl = @"https://maps.googleapis.com/maps/api/streetview?size=400x300&location=%@,%@&heading=151.78&pitch=-0.76&key=AIzaSyAmBUFhXk1XMEPTvcC7JefhF_LTehWKvXw";

NSInteger const kPageLimit = 10;

@interface MoviesService ()

@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic, strong) MovieListViewModel *moviesViewModel;

@end

@implementation MoviesService

#pragma mark - Singleton Initializer

+ (instancetype)sharedService {
    
    static dispatch_once_t dispatchOnce;
    static MoviesService *sharedService;
    
    dispatch_once(&dispatchOnce, ^{
        sharedService = [[MoviesService alloc] init];
        sharedService.movies = [[NSMutableArray alloc] init];
    });
    
    return sharedService;
}

- (void)getMovies {

    NSURL *url = [NSURL URLWithString:[self prepareUrlIsReload:NO]];
    
    __weak NSManagedObjectContext *managedContext =
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    
    [self.movies removeAllObjects];
    [self.movies addObjectsFromArray:[Movie getMoviesFromCoreDataIfExistWithManageContext:managedContext]];
    
    if ([self.movies count] > 0) {
        if (!self.moviesViewModel) {
            self.moviesViewModel = [[MovieListViewModel alloc] init];
        }
        [self.moviesViewModel viewModelWithMovieFetchObjects:self.movies];
        [self _contentAddedNotificationForError:nil];
    }
    else  {
        [self _searchMoviesFromServerWithUrl:url];
    }
}

- (void)loadMoreMovies {
    NSURL *url = [NSURL URLWithString:[self prepareUrlIsReload:YES]];
    [self _searchMoviesFromServerWithUrl:url];
}


- (void)_searchMoviesFromServerWithUrl:(NSURL *)url {
    [[NetworkService sharedService] operationWith:url completionWithSuccess:^(id responseObject) {
        
        __weak NSManagedObjectContext *managedContext =
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
        
        NSInteger nextIndex = [self.movies count] == 0 ? 0 : [self.movies count] - 1;
        
        NSArray *tempArray = [Movie parseMovieResultsJson:(NSArray *)responseObject
                                                    index:nextIndex
                                           managedContext:managedContext];
        
        [self.movies addObjectsFromArray:tempArray];
        
        NSError *error = nil;
        
        [managedContext save:&error];
        
        if (!self.moviesViewModel) {
            self.moviesViewModel = [[MovieListViewModel alloc] init];
        }
        [self.moviesViewModel viewModelWithMovieFetchObjects:self.movies];
        [self _contentAddedNotificationForError:nil];

        NSString *errorString;
        if (error) {
            NSLog(@"Database inster failure error %@", error.description);
            errorString = error.description;
        }
        else {
            NSLog(@" Database insert success");
        }
        
    } withFailure:^(NSError *error) {
        NSLog(@"Server Error: %@", error);
        
        [self _contentAddedNotificationForError:error.description];
    }];
}


- (MovieListViewModel *)movieList {
    return self.moviesViewModel;
}

- (void)sortMoviesWithParameter:(kSortParameter)parameter {
    
    [self.moviesViewModel.movieList sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        MovieDetailViewModel *viewModel1 = (MovieDetailViewModel *)obj1;
        MovieDetailViewModel *viewModel2 = (MovieDetailViewModel *)obj2;
        
        switch (parameter) {
            case kSortParameterDistance:
                return [viewModel1.title compare:viewModel2.title];

            case kSortParameterMovieName:
                return [viewModel1.title compare:viewModel2.title];
            
            case kSortParameterYear: {
                NSInteger year1 = [viewModel1.year integerValue];
                NSInteger year2 = [viewModel2.year integerValue];
                if (year1 < year2) {
                    return NSOrderedAscending;
                }
                else if (year2 < year1){
                    return NSOrderedDescending;
                }
                else {
                    return NSOrderedSame;
                }
            }
            default:
                break;
        }
    }];
    
    [self _contentAddedNotificationForError:nil];
}

- (NSString *)prepareUrlIsReload:(BOOL)isReload {
    
    NSString *limit = [NSString stringWithFormat:kLimitKey,(long)kPageLimit];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",kBaseUrl,limit];

    if (isReload) {
        NSString *offset = [NSString stringWithFormat:kOffsetKey,(unsigned long)[self.movies count]];
        urlString = [urlString stringByAppendingString:offset];
    }
    return urlString;
}


#pragma mark - Provate Helper Methods

- (void)_contentAddedNotificationForError:(NSString *)errorDescription {
    static NSNotification *notification = nil;
    static dispatch_once_t onceToken;
    
    if (!errorDescription)
        errorDescription = @"";
    
    dispatch_once(&onceToken, ^{
        
        notification = [NSNotification notificationWithName:kMovieResultsKey
                                                     object:nil
                                                   userInfo:@{kErrorKey : errorDescription}];
    });
    
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification
                                               postingStyle:NSPostASAP
                                               coalesceMask:NSNotificationCoalescingOnName
                                                   forModes:nil];
}


@end
