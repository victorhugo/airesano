//
//  IntroViewController.h
//  PocketDF
//
//  Created by Victor Hugo Pérez Alvarado on 1/25/14.
//  Copyright (c) 2014 Chilaquil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STVideoPlayer.h"
#import "LocationManager.h"

@interface IntroViewController : UIViewController


@property (nonatomic, strong) LocationManager *manager;
- (IBAction)swipe:(id)sender;

@end
