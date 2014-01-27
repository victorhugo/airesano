//
//  STVideoPlayer.h
//  String
//
//  Created by Victor Hugo Pérez Alvarado on 2/21/13.
//  Copyright (c) 2013 String Publisher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface STVideoPlayer : NSObject

@property (nonatomic, strong) MPMoviePlayerController *player;

+ (STVideoPlayer*)shared;

-(void)playVideoWithRect:(CGRect)rect filePath:(NSURL*)movieURL andView:(UIView*)vista;

//-(void)playVideoAtPath:(NSString*)path andView:(UIView*)videoView;

//-(void)playVideoWithRect:(STRect)rect filePath:(NSURL*)movieURL andView:(UIView*)vista options:(NSDictionary*)options;

@end
