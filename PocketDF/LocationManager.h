//
//  LocationManager.h
//  PocketDF
//
//  Created by Victor Hugo Pérez Alvarado on 1/25/14.
//  Copyright (c) 2014 Chilaquil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol ActualizarLocationProtocol <NSObject>

-(void) newLocationWithLatitude:(double)latitude andLongitude:(double)longitude;

@end


@interface LocationManager : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    NSInteger _counter;
    
    BOOL _flag;
}

-(void) startTracking;
@property (nonatomic, strong) id <ActualizarLocationProtocol>delegate;

@end
