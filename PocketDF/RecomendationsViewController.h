//
//  RecomendationsViewController.h
//  PocketDF
//
//  Created by Victor Hugo Pérez Alvarado on 1/26/14.
//  Copyright (c) 2014 Chilaquil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecomendationsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UILabel *lugarCercano;
@property (strong, nonatomic) IBOutlet UIImageView *medioTransporte;
@property (strong, nonatomic) IBOutlet UIImageView *formaProteccion;
@property (strong, nonatomic) IBOutlet UIImageView *tipoActividad;

-(void) updateDataWithData:(NSDictionary*)data;

@end
