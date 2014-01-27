//
//  DataParser.m
//  PocketDF
//
//  Created by Alex on 25/01/14.
//  Copyright (c) 2014 Chilaquil. All rights reserved.
//

#import "DataParser.h"
#import "AFHTTPRequestOperationManager.h"

static NSString * const BaseURL = @"http://ojodf.com/api.php?";

@implementation DataParser

-(void) getData:(NSString *)path forModule:(NSString *)module withSuccessBlock:(void (^)(NSDictionary* dictDataSet))success {
    // __block NSArray *arrDataSet;
    __block NSDictionary *dictDataSet;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL=[NSString stringWithFormat:@"%@%@",BaseURL,path];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            dictDataSet = [self parseData:module nsData:responseObject];
            success(dictDataSet);
        }
        else{
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        NSLog(@"Error: %@", error);
    }];
}

-(id)parseData:(NSString *)module nsData:(id)nsData{
    NSMutableDictionary *dictDataSet;
    NSArray *arrDataSet;
    
    
    if ([module isEqualToString:@"CALIDAD_DEL_AIRE"]){
        
        // image                    // url a imagen de la ciudad
        // location                 // nombre de la ubicacion
        // quality                  // calidad del aire
        // uv                       // nivel de rayos ultraviolete
        // rec_clothing             // recomendacion de vestimenta
        // rec_protection           //  recomendacion de proteccion
        // rec_transport            //  recomendacion de transporte
        // rec_general              //  recomendaciones generales
        // temp_condition           //  condicion del clima
        // temp_current             //  temperatura actual
        // temp_high                //  temperatura maxima
        // temp_low                 //  temperatura minima
        
        dictDataSet = [[NSMutableDictionary alloc]init];
        
        [dictDataSet setObject:[nsData valueForKey:@"image"] forKey:@"image"];
        [dictDataSet setObject:[nsData valueForKey:@"location"] forKey:@"location"];
        [dictDataSet setObject:[nsData valueForKey:@"quality"] forKey:@"quality"];
        [dictDataSet setObject:[nsData valueForKey:@"uv"] forKey:@"uv"];
        [dictDataSet setObject:[[nsData valueForKey:@"recomendations"] valueForKey:@"clothing"] forKey:@"rec_clothing"];
        [dictDataSet setObject:[[nsData valueForKey:@"recomendations"] valueForKey:@"protection"] forKey:@"rec_protection"];
        [dictDataSet setObject:[[nsData valueForKey:@"recomendations"] valueForKey:@"transport"] forKey:@"rec_transport"];
        [dictDataSet setObject:[[nsData valueForKey:@"recomendations"] valueForKey:@"general"] forKey:@"rec_general"];
        [dictDataSet setObject:[[nsData valueForKey:@"temperature"] valueForKey:@"condition"] forKey:@"temp_condition"];
        [dictDataSet setObject:[[nsData valueForKey:@"temperature"] valueForKey:@"current"] forKey:@"temp_current"];
        [dictDataSet setObject:[[nsData valueForKey:@"temperature"] valueForKey:@"high"] forKey:@"temp_high"];
        [dictDataSet setObject:[[nsData valueForKey:@"temperature"] valueForKey:@"low"] forKey:@"temp_low"];
        
        return dictDataSet;
    }else if( [module isEqualToString:@"ECOBICI"]){
        arrDataSet = [[dictDataSet valueForKey:@"ecobici"] valueForKey:@"viajes"];
        
        
        //Categoria: viajes
        //String action;	        //accion de la toma de bici
        //int bike;                 //Número de la bicicleta
        //int cust_id;              //id del usuario
        //String date_arrived;      //Fecha y hora en la que se dejo la bici
        //String date_removed;      //Fecha y hora en la que se tomo la bici
        //int station_arrived;      //Estacion de llegada
        //int station_removed;      //Estacion de salida
        
        return arrDataSet;
        
    }else{
        return nil;
    }
}


-(void)getDataCalidadDelAireLatitude:(NSString *)latitude longitude:(NSString *)longitude withSuccessBlock:(void (^)(NSDictionary* dictDataSet))success{
    
    NSString *path=[NSString stringWithFormat:@"latitude=%@&longitude=%@",latitude,longitude];
    [self getData:path forModule:@"CALIDAD_DEL_AIRE" withSuccessBlock:success];
}

@end
