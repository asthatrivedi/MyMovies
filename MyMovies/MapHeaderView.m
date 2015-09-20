//
//  MapHeaderView.m
//  MyMovies
//
//  Created by Trivedi, Astha on 18/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "MapHeaderView.h"
#import <MapKit/MapKit.h>


@interface MapHeaderView () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end

@implementation MapHeaderView

- (void)setupLocation:(Location *)location {
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [location.latitude doubleValue];
    coordinate.longitude = [location.longitude doubleValue];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coordinate;
    [self.mapView addAnnotation:point];
}


@end
