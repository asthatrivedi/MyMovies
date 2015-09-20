//
//  Location.h
//  MyMovies
//
//  Created by Trivedi, Astha on 19/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@class Movie;

extern NSString * const kLocationEntity;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) Movie *latlong;

+ (CLLocationCoordinate2D)getLocationFromAddressString: (NSString*) addressStr;
- (void)setLatLongForCoordinate;

@end
