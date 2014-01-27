//
//  DashboardController.m
//  PocketDF
//
//  Created by Victor Hugo Pérez Alvarado on 1/25/14.
//  Copyright (c) 2014 Chilaquil. All rights reserved.
//

#import "DashboardController.h"
#import "UIImageView+AFNetworking.h"


@interface DashboardController ()

@end

@implementation DashboardController

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
    [self.headerImage setImage:[UIImage imageNamed:@"1600.jpg"]];
    
    self.parser = [[DataParser alloc]init];
    self.location = [[LocationManager alloc]init];
    self.location.delegate = self;
    
    [self.iconoCondicionClima setImage:[UIImage imageNamed:@"soleadoicono.png"]];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificacion) name:@"remoteAdvise" object:nil];
}

-(void) notificacion{
    [SVProgressHUD showErrorWithStatus:@"Alerta de Contingencia ambiental"];
    
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"metal_gear_alert" ofType:@"mp3"];
    NSURL *pathURL = [NSURL fileURLWithPath : path];
    
    SystemSoundID audioEffect;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
    AudioServicesPlaySystemSound(audioEffect);
    
    // call the following function when the sound is no longer used
    // (must be done AFTER the sound is done playing)
//    AudioServicesDisposeSystemSoundID(audioEffect);
    
}

-(void) updateInterfaceWithImagePath:(NSString*)imagePath{
    
//    [self.headerImage setImageWithURLRequest:[NSURLRequest requestWithURL:
////            [NSURL URLWithString:@"http://ojodf.com/thumb.php?url=http://webcamsdemexico.net/mexicodf4/2014-01-25/xga/1200.jpg"]] placeholderImage:[UIImage imageNamed:@"backHeader.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//      [NSURL URLWithString:imagePath]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//
//        
//        NSLog(@"Exito de imagen: %@", image);
//        [UIView animateWithDuration:0.5 animations:^{
//            self.headerImage.alpha = 0.0;
//        } completion:^(BOOL finished) {
//            [self.headerImage setImage:image];
//            [UIView animateWithDuration:0.5 animations:^{
//                            self.headerImage.alpha = 1.0;
//            } completion:^(BOOL finished) {
//                NSLog(@"->");
//            }];
//        }];
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        NSLog(@"Fail: %@", error);
//    }];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
//    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imagePath]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
        return [documentsDirectoryPath URLByAppendingPathComponent:[targetPath lastPathComponent]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        
        UIImage *imagen = [UIImage imageWithContentsOfFile:[filePath  path]];
        NSLog(@"Imagen: %@", imagen);
        [self.headerImage setImage:imagen];
    }];
    [downloadTask resume];
    
}

-(void)updateData{
    [self.location startTracking];
}

-(void) newLocationWithLatitude:(double)latitude andLongitude:(double)longitude{
    [self.parser getDataCalidadDelAireLatitude:[NSString stringWithFormat:@"%f", latitude] longitude:[NSString stringWithFormat:@"%f", longitude] withSuccessBlock:^(NSDictionary *data) {
        NSLog(@"Data: %@", data);
        NSString *imageURL = [data valueForKey:@"image"];
        
        self.temperatura.text = [NSString stringWithFormat:@"%@º C", [data valueForKey:@"temp_current"]];
        self.maxMinTemp.text = [NSString stringWithFormat:@"MAX %@º - MIN %@º", [data valueForKey:@"temp_high"], [data valueForKey:@"temp_low"]];

        self.calidadAire.text = [data valueForKey:@"quality"];
        self.radiacionUV.text = [data valueForKey:@"uv"];
        
        int opcionSemaforo = random() % 2;
        switch (opcionSemaforo) {
            case 0:
                self.semaforoVista.backgroundColor  = [UIColor greenColor];
                break;

            case 1:
                self.semaforoVista.backgroundColor  = [UIColor yellowColor];
                break;

            case 2:
                self.semaforoVista.backgroundColor  = [UIColor redColor];
                break;
                
            default:
                break;
        }
        
        
        [self updateInterfaceWithImagePath:imageURL];
        [self.recomendations updateDataWithData:data];
        
        
        int opcionClima = random() % 3;
        switch (opcionClima) {
            case 0:
                [self.iconoCondicionClima setImage:[UIImage imageNamed:@"soleadoicono.png"]];
                break;
            case 1:
                [self.iconoCondicionClima setImage:[UIImage imageNamed:@"lluvioso.png"]];
                break;
                
            case 2:
                [self.iconoCondicionClima setImage:[UIImage imageNamed:@"nublado.png"]];
                break;

                
            default:
                [self.iconoCondicionClima setImage:[UIImage imageNamed:@"soleadoicono.png"]];
        }

        [SVProgressHUD dismiss];
    }];
    
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"recomendationsSegue"]) {
        self.recomendations =   segue.destinationViewController;
    }
}



-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        // Put in code here to handle shake
        

        [self updateData];
        [SVProgressHUD showWithStatus:@"Cargando..."];
        
        NSLog(@"Acutalizando datos");
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
