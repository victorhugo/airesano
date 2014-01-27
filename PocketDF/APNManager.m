//
//  APNManager.m
//  AtomixMag
//
//  Created by VIctor Hugo Pérez Alvarado on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "APNManager.h"

@implementation APNManager


+(void) registerDeviceToken:(NSData *)devToken{
    
    DeviceInfoHandler *device = [[DeviceInfoHandler alloc]init];
    
    // Get Bundle Info for Remote Registration (handy if you have more than one app)
	device.appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
	device.appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	
	// Check what Notifications the user has turned on.  We registered for all three, but they may have manually disabled some or all of them.
	NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
	
	// Set the defaults to disabled unless we find otherwise...
	device.pushBadge = (rntypes & UIRemoteNotificationTypeBadge) ? @"1" : @"0";
	device.pushAlert = (rntypes & UIRemoteNotificationTypeAlert) ? @"1" : @"0";
	device.pushSound = (rntypes & UIRemoteNotificationTypeSound) ? @"1" : @"0";
	
	// Get the users Device Model, Display Name, Unique ID, Token & Version Number
	UIDevice *dev = [UIDevice currentDevice];

    device.deviceName = [dev.name stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
	device.deviceModel = [dev.model stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
	device.systemVersion = dev.systemVersion;
	
	// Prepare the Device Token for Registration (remove spaces and < >)
	device.token = [[[[devToken description]
                               stringByReplacingOccurrencesOfString:@"<"withString:@""] 
                              stringByReplacingOccurrencesOfString:@">" withString:@""] 
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"token": device.token};
    [manager POST:@"http://ojodf.com/token.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Token enviadp: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
//        [[STWebServicesManager shared] requestDeviceRegistrationWithDevice:device withSuccessBlock:^(NSString *msg) {
//            NSLog(@"Registro de token completed");
//        } errorBlock:^(NSString *errorDescription) {
//            NSLog(@"Registro de token failed %@", errorDescription);
//        }];
    
   
    

    
    
//	NSString *urlString = [NSString stringWithFormat:@"/push/en/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, deviceToken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
//	
	
    // Register the Device Data
	// !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
//	NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//

//    #ifdef DEBUG
//	NSLog(@"Register URL: %@", url);
//	NSLog(@"Return Data: %@", [[[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSISOLatin1StringEncoding] autorelease]);
//    #endif

}


@end
