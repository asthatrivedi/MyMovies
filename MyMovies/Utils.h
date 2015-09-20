//
//  Utils.h
//  MyMovies
//
//  Created by Trivedi, Astha on 17/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kMovieResultsKey;
extern NSString * const kImageDownloadedKey;
extern NSString * const kErrorKey;

typedef enum {
    kSortParameterDistance = 0,
    kSortParameterMovieName,
    kSortParameterYear
}kSortParameter;

@interface Utils : NSObject

@end
