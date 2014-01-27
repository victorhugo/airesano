//
//  IntroViewController.m
//  PocketDF
//
//  Created by Victor Hugo Pérez Alvarado on 1/25/14.
//  Copyright (c) 2014 Chilaquil. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

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
    
    self.view.backgroundColor = [UIColor blackColor];
    
    BOOL dir;
  
    if([[NSFileManager defaultManager] fileExistsAtPath:[[NSBundle mainBundle] pathForResource:@"intro" ofType:@"mov"] isDirectory:&dir]){
        NSLog(@"File exits");
    }else{
        NSLog(@"File doesnot exists");
    }
    
    [[STVideoPlayer shared] playVideoWithRect:CGRectMake(0.0, 178.0, 320.0, 211.0) filePath:[[NSBundle mainBundle] URLForResource:@"intro2" withExtension:@"mov"] andView:self.view];
    
	// Do any additional setup after loading the view.
    self.manager = [[LocationManager alloc]init];
    [self.manager startTracking];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipe:(id)sender {
  UIViewController *controller =  [self.storyboard instantiateViewControllerWithIdentifier:@"dashboardID"];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
