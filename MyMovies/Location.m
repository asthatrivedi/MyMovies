//
//  Location.m
//  MyMovies
//
//  Created by Trivedi, Astha on 19/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "Location.h"
#import "Movie.h"


NSString * const kLatLongUrl = @"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@";
NSString * const kLocationEntity = @"Location";

@implementation Location

@dynamic latitude;
@dynamic longitude;
@dynamic location;
@dynamic latlong;


+ (CLLocationCoordinate2D)getLocationFromAddressString: (NSString*) addressStr {
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:kLatLongUrl, esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    
    return center;
}

- (void)setLatLongForCoordinate {
    
    CLLocationCoordinate2D coordinate = [Location getLocationFromAddressString:self.location];
    
    self.latitude = @(coordinate.latitude);
    self.longitude = @(coordinate.longitude);
}


@end
