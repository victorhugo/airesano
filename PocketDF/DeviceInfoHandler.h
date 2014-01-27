//
//  DeviceInfoHandler.h
//  String
//
//  Created by Victor Hugo Pérez Alvarado on 7/10/13.
//  Copyright (c) 2013 String Publisher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfoHandler : NSObject

@property (nonatomic, strong) NSString* userID;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic, strong) NSString *deviceName;
@property (nonatomic, strong) NSString *deviceModel;
@property (nonatomic, strong) NSString *systemVersion;
@property (nonatomic, strong) NSString *pushBadge;
@property (nonatomic, strong) NSString *pushAlert;
@property (nonatomic, strong) NSString *pushSound;





@end
