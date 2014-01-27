//
//  AppDelegate.m
//  PocketDF
//
//  Created by Victor Hugo Pérez Alvarado on 1/23/14.
//  Copyright (c) 2014 Chilaquil. All rights reserved.
//

#import "AppDelegate.h"
#import "DataParser.h"

@implementation AppDelegate{
    NSString *Path;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //@"http://datos.labplc.mx/movilidad/ecobici/usuario/1857415316.json

    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Push Notification services
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"deviceToken"];
    
    
    [APNManager registerDeviceToken:deviceToken];
    
}

//El app recibe una notificacion cuando esta abierta
-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"Received notification: %@", userInfo);
//    NSLog(@"String ID: %@", [userInfo objectForKey:@"string_id"]);

    [[NSNotificationCenter defaultCenter]postNotificationName:@"remoteAdvise" object:nil userInfo:@{@"mensaje":@"contingencia"}];
    
//    if ([userInfo objectForKey:@"string_id"] != nil) {
//        //        [[NSNotificationCenter defaultCenter]postNotificationName:@"beginStringIntelligentInstall" object:nil userInfo:@{@"string_id":[userInfo objectForKey:@"string_id"]}];
//        
//
//    }
}

@end
