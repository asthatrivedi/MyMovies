//
//  Utils.h
//  MyMovies
//
//  Created by Trivedi, Astha on 17/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString * const kDetailIdentifier;
extern NSString * const kErrorKey;
extern NSString * const kMovieDetailIdentifier;
extern NSString * const kMovieResultsKey;

#define kSystemTintColor [UIColor whiteColor]

typedef enum {
    kSortParameterDistance = 0,
    kSortParameterMovieName,
    kSortParameterYear
}kSortParameter;

@interface Utils : NSObject

@end
