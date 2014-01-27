//
//  APNManager.h
//  AtomixMag
//
//  Created by VIctor Hugo Pérez Alvarado on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfoHandler.h"
#import <AFNetworking.h>

@interface APNManager : NSObject

+(void) registerDeviceToken:(NSData *)devToken;

@end
