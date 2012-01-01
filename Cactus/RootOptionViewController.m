//
//  RootOptionViewController.m
//  Cactus
//
//  Created by nthu on 12/1/1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootOptionViewController.h"


@implementation RootOptionViewController
@synthesize superViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    birthdayList=[[FBListViewController alloc] initWithNibName:@"FBListViewController" bundle:nil];
    weather=[[LocalWeatherViewController alloc] init];
}

-(IBAction)back:(id)sender{
    //NSLog(@">>>>touch toolbar"); 
    [self.view removeFromSuperview];
}

-(IBAction)toWeather:(id)sender
{
    [superViewController.navigationController pushViewController:weather animated:YES];
}

-(IBAction)toBirthday:(id)sender
{
    //[superViewController.navigationController setNavigationBarHidden:NO animated:NO];
    [superViewController.navigationController pushViewController:birthdayList animated:YES];
}

-(IBAction)toReminder:(id)sender
{

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
