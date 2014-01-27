//
//  DataParser.h
//  PocketDF
//
//  Created by Alex on 25/01/14.
//  Copyright (c) 2014 Chilaquil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataParser : NSObject

-(void) getData:(NSString *)path forModule:(NSString *)module withSuccessBlock:(void (^)(NSDictionary* dictDataSet))success;
-(void)getDataCalidadDelAireLatitude:(NSString *)latitude longitude:(NSString *)longitude withSuccessBlock:(void (^)(NSDictionary* dictDataSet))success;

@end