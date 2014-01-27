//
//  DashboardController.h
//  PocketDF
//
//  Created by Victor Hugo Pérez Alvarado on 1/25/14.
//  Copyright (c) 2014 Chilaquil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataParser.h"
#import "LocationManager.h"
#import <AFURLSessionManager.h>
#import "RecomendationsViewController.h"
#import "SVProgressHUD.h"
#import <AudioToolbox/AudioServices.h>


@interface DashboardController : UIViewController<ActualizarLocationProtocol>

@property (nonatomic, strong)RecomendationsViewController *recomendations;

@property (strong, nonatomic) IBOutlet UILabel *temperatura;
@property (strong, nonatomic) IBOutlet UILabel *maxMinTemp;

@property (strong, nonatomic) IBOutlet UILabel *calidadAire;

@property (strong, nonatomic) IBOutlet UILabel *radiacionUV;

@property (strong, nonatomic) IBOutlet UIImageView *iconoCondicionClima;

@property (strong, nonatomic) IBOutlet UIView *semaforoVista;








@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (nonatomic, strong) DataParser *parser;
@property (nonatomic, strong) LocationManager *location;

@end
