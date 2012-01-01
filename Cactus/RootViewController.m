//
//  RootViewController.m
//  Cactus
//
//  Created by nthu on 12/1/1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "RootViewController.h"
#import "LocalWeatherViewController.h"

@interface RootViewController()  
- (void) drawButton;
@end

@implementation RootViewController
@synthesize optionController;

- (void)drawButton
{
	UIImage * btnpic1 = [UIImage imageNamed:@"pic1.png"];
    [cactusbutton setImage:btnpic1 forState:UIControlStateNormal];
	
	[cactusbutton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	
}

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
    //LocalWeatherViewController *weather=[[LocalWeatherViewController alloc] init];
    //[self.navigationController pushViewController:weather animated:YES];
    [self drawButton];
    optionController=[[RootOptionViewController alloc] initWithNibName:@"RootOptionViewController" bundle:nil]; 
    optionController.superViewController=self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


-(IBAction)buttonClicked:(id)sender {
    //change the button view
    
    UIImage * btnpic2 = [UIImage imageNamed:@"pic2.png"];
    [cactusbutton setImage:btnpic2 forState:UIControlStateHighlighted];
    
    /* if (cactusbutton.selected == YES)
     {
     UIImage * btnpic1 = [UIImage imageNamed:@"pic1.png"];
     [cactusbutton setBackgroundImage:btnpic1 forState:UIControlStateSelected];
     }else{
     UIImage * btnpic2 = [UIImage imageNamed:@"pic2.png"];
     [cactusbutton setBackgroundImage:btnpic2 forState:UIControlStateNormal];
     }*/
    
    [self.view addSubview:optionController.view];  
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
