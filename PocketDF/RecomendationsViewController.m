//
//  RecomendationsViewController.m
//  PocketDF
//
//  Created by Victor Hugo Pérez Alvarado on 1/26/14.
//  Copyright (c) 2014 Chilaquil. All rights reserved.
//

#import "RecomendationsViewController.h"

@interface RecomendationsViewController ()

@end

@implementation RecomendationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    self.scroll.frame.size = CGSizeMake(320, 334);
    self.scroll.contentSize = CGSizeMake(320, 1000);
    
    [self.medioTransporte setImage:[UIImage imageNamed:@"bici.png"]];
    [self.formaProteccion setImage:[UIImage imageNamed:@"lentes.png"]];
    [self.tipoActividad setImage:[UIImage imageNamed:@"interior.png"]];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateDataWithData:(NSDictionary*)data{
    self.lugarCercano.text = [data objectForKey:@"location"];
    
    int opcionTransporte = random() % 3;
    switch (opcionTransporte) {
        case 0:
            [self.medioTransporte setImage:[UIImage imageNamed:@"bici.png"]];
            break;
        case 1:
            [self.medioTransporte setImage:[UIImage imageNamed:@"caminar.png"]];
            break;
            
        case 2:
            [self.medioTransporte setImage:[UIImage imageNamed:@"auto.png"]];
            break;
        default:
            [self.medioTransporte setImage:[UIImage imageNamed:@"bici.png"]];
    }

    
    int opcionProteccion = random() % 2;
    switch (opcionProteccion) {
        case 0:
            [self.formaProteccion setImage:[UIImage imageNamed:@"lentes.png"]];
            break;
        case 1:
            [self.formaProteccion setImage:[UIImage imageNamed:@"sombrilla.png"]];
            break;
        default:
            [self.formaProteccion setImage:[UIImage imageNamed:@"fresco.png"]];
    }

    
    int tipoActividad = random() % 2;
    switch (tipoActividad) {
        case 0:
            [self.tipoActividad setImage:[UIImage imageNamed:@"aire_libre.png"]];
            break;
        case 1:
            [self.tipoActividad setImage:[UIImage imageNamed:@"interior.png"]];
            break;
        default:
            [self.tipoActividad setImage:[UIImage imageNamed:@"bici.png"]];
    }
    

    
}
@end
