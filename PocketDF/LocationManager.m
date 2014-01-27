//
//  LocationManager.m
//  PocketDF
//
//  Created by Victor Hugo Pérez Alvarado on 1/25/14.
//  Copyright (c) 2014 Chilaquil. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

-(id) init{
    if(self = [super init]){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _counter = 0;
        _flag = NO;
    }
    return self;
}

-(void) startTracking{
    [locationManager startUpdatingLocation];
    _flag = YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    if(_flag){

        if (self.delegate != nil) {
            [self.delegate newLocationWithLatitude:newLocation.coordinate.latitude andLongitude:newLocation.coordinate.longitude];
        }
        _flag = NO;
    
    }
    
    
    [locationManager stopUpdatingLocation];
}

@end
