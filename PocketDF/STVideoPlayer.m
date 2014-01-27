//
//  STVideoPlayer.m
//  String
//
//  Created by Victor Hugo Pérez Alvarado on 2/21/13.
//  Copyright (c) 2013 String Publisher. All rights reserved.
//

#import "STVideoPlayer.h"

CGFloat kMovieViewOffsetX = 0.0;
CGFloat kMovieViewOffsetY = 0.0;


@implementation STVideoPlayer


+ (STVideoPlayer*)shared {
    static dispatch_once_t once;
    static STVideoPlayer *sharedSession;
    dispatch_once(&once, ^ {
        sharedSession = [[STVideoPlayer alloc]init];
    });
    return sharedSession;
}

-(id)init{

    self = [super init];
    if(self){
    }
    return self;
}

-(void) didChangePageWithIndex:(NSNotification *) notification{
    [self.player stop];
//    [self deletePlayerAndNotificationObservers];
}

//-(void)playVideoAtPath:(NSString*)path andView:(UIView*)videoView andRect:(STRect)rect{
//    
//    NSLog(@"Se indica al reproductor iniciar con archivo: %@", path);
//    [videoView addSubview:[self.player view]];
//    [self.player play];
//}

-(void)playVideoWithRect:(CGRect)rect filePath:(NSURL*)movieURL andView:(UIView*)vista
{
    if(self.player != nil){
        [self.player stop];
        if(self.player.view.superview){
            [self.player.view removeFromSuperview];
        }
        [self deletePlayerAndNotificationObservers];
    }

    NSLog(@"Se indica al reproductor iniciar con archivo: %@", movieURL);
    
    /* Create a new movie player object. */
    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    
    if (player)
    {
        /* Save the movie object. */
        self.player = player;
        
        /* Register the current object as an observer for the movie
         notifications. */
        [self installMovieNotificationObservers];
        
        /* Specify the URL that points to the movie file. */
        [player setContentURL:movieURL];
        
        /* If you specify the movie type before playing the movie it can result
         in faster load times. */
        [player setMovieSourceType:MPMovieSourceTypeFile];
        
        /* Apply the user movie preference settings to the movie player object. */
        [self applyUserSettingsToMoviePlayer];
        
        
        CGRect viewInsetRect = CGRectInset (CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height),
                                            kMovieViewOffsetX,
                                            kMovieViewOffsetY );
        /* Inset the movie frame in the parent view frame. */
        [[player view] setFrame:viewInsetRect];
        
        [player view].backgroundColor = [UIColor clearColor];
        [player view].alpha = 0.0;
        
        [vista addSubview: [player view]];

        /* To present a movie in your application, incorporate the view contained
         in a movie player’s view property into your application’s view hierarchy.
         Be sure to size the frame correctly. */
        [UIView animateWithDuration:1.0 animations:^{
            [player view].alpha = 1.0;

        }];
    }
    
    [self.player play];
}

-(void)applyUserSettingsToMoviePlayer
{
    MPMoviePlayerController *player = self.player;
    if (player)
    {
        player.scalingMode = MPMovieScalingModeAspectFit;
        player.backgroundView.backgroundColor = [UIColor clearColor];
        
        
        player.controlStyle = MPMovieControlStyleNone;
        player.fullscreen = NO;
        
        
//        if ([MoviePlayerUserPrefs backgroundImageUserSetting] == YES)
//        {
//            [self.movieBackgroundImageView setFrame:[self.view bounds]];
//            [player.backgroundView addSubview:self.movieBackgroundImageView];
//        }
//        else
//        {
//            [self.movieBackgroundImageView removeFromSuperview];
//        }
        
        /* Indicate the movie player allows AirPlay movie playback. */
        player.allowsAirPlay = NO;
    }
}

-(void)installMovieNotificationObservers
{
    
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:MPMoviePlayerLoadStateDidChangeNotification
                                               object:self.player];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.player];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:self.player];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:self.player];
}

/* Handle movie load state changes. */
- (void)loadStateDidChange:(NSNotification *)notification
{
    NSLog(@"Cambio de estados");
	MPMoviePlayerController *player = notification.object;
	MPMovieLoadState loadState = player.loadState;
    
	/* The load state is not known at this time. */
	if (loadState & MPMovieLoadStateUnknown)
	{
//        [self.overlayController setLoadStateDisplayString:@"n/a"];
        
        NSLog(@"Load State: unknown");
	}
	
	/* The buffer has enough data that playback can begin, but it
	 may run out of data before playback finishes. */
	if (loadState & MPMovieLoadStatePlayable)
	{
        self.player.view.alpha = 1.0;
      NSLog(@"Load State: playable");
	}
	
	/* Enough data has been buffered for playback to continue uninterrupted. */
	if (loadState & MPMovieLoadStatePlaythroughOK)
	{
        // Add an overlay view on top of the movie view
//        [self addOverlayView];
        
        
        NSLog(@"Load State: playthrough ok");
	}
	
	/* The buffering of data has stalled. */
	if (loadState & MPMovieLoadStateStalled)
	{
//        [overlayController setLoadStateDisplayString:@"stalled"];
        NSLog(@"Load State: stalled");

	}
}

/* Called when the movie playback state has changed. */
- (void) moviePlayBackStateDidChange:(NSNotification*)notification
{
	MPMoviePlayerController *player = notification.object;
    
	/* Playback is currently stopped. */
	if (player.playbackState == MPMoviePlaybackStateStopped)
	{
        NSLog(@"PlayBack State: stopped");
	}
	/*  Playback is currently under way. */
	else if (player.playbackState == MPMoviePlaybackStatePlaying)
	{
        NSLog(@"PlayBack State: playing");
	}
	/* Playback is currently paused. */
	else if (player.playbackState == MPMoviePlaybackStatePaused)
	{
        NSLog(@"PlayBack State: paused");
	}
	/* Playback is temporarily interrupted, perhaps because the buffer
	 ran out of content. */
	else if (player.playbackState == MPMoviePlaybackStateInterrupted)
	{
        NSLog(@"PlayBack State: interrupted");
	}
}


/* Notifies observers of a change in the prepared-to-play state of an object
 conforming to the MPMediaPlayback protocol. */
- (void) mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
	// Add an overlay view on top of the movie view
//    [self addOverlayView];
}

/*  Notification called when the movie finished playing. */
- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    NSNumber *reason = [[notification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
	switch ([reason integerValue])
	{
            /* The end of the movie was reached. */
		case MPMovieFinishReasonPlaybackEnded:
            /*
             Add your code here to handle MPMovieFinishReasonPlaybackEnded.
             */
            NSLog(@"Playback ended");
			break;
            
            /* An error was encountered during playback. */
		case MPMovieFinishReasonPlaybackError:
            NSLog(@"An error was encountered during playback");
//            [self performSelectorOnMainThread:@selector(displayError:) withObject:[[notification userInfo] objectForKey:@"error"]
//                                waitUntilDone:NO];
                NSLog(@"Playback error");
//            [self removeMovieViewFromViewHierarchy];
//            [self removeOverlayView];
//            [self.backgroundView removeFromSuperview];
			break;
            
            /* The user stopped playback. */
		case MPMovieFinishReasonUserExited:
                        NSLog(@"Playback stoped");
//            [self removeMovieViewFromViewHierarchy];
//            [self removeOverlayView];
//            [self.backgroundView removeFromSuperview];
			break;
            
		default:
			break;
	}
}

/* Remove the movie notification observers from the movie object. */
-(void)removeMovieNotificationHandlers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:self.player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:self.player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.player];
}

/* Delete the movie player object, and remove the movie notification observers. */
-(void)deletePlayerAndNotificationObservers
{
    NSLog(@"Se elimina video de memoria");
    [self removeMovieNotificationHandlers];
    self.player = nil;
}

@end
