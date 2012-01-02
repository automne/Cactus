//
//  DetailViewController.m
//  Cactus
//
//  Created by Automne on 12/31/11.
//  Copyright (c) 2011 Automne. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

NSString *picture;

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController
@synthesize detailItem=_detailItem;
@synthesize detailDescriptionLabel=_detailDescriptionLabel;
@synthesize birthdayLabel=_birthdayLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release]; 
        _detailItem = [newDetailItem retain]; 
        
        // Update the view.
        [self configureView];
    }
    picture = [self.detailItem valueForKey:@"uid"];
    picture=[picture stringByAppendingString:@"/picture"];
    wrapper = [[FBRequestWrapper alloc] initWithGraphPath:picture];
    [wrapper sendRequestWithDelegate:self];
    activity = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(30, 40, 30, 30)];
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    
    [self.view addSubview:activity];

    //activity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //[activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    //[activity hidesWhenStopped];
    [activity startAnimating];
}


- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        
        self.detailDescriptionLabel.text = [self.detailItem valueForKey:@"name"];
        
        NSString *bd=[self.detailItem valueForKey:@"birthday"];
        if(![bd isEqualToString:@"13/00"]){
            self.birthdayLabel.text=[self.detailItem valueForKey:@"birthday"];
        }else{
            self.birthdayLabel.text=nil;
        };
        
        self.title = [self.detailItem valueForKey:@"name"];
        self.birthdayLabel.enabled=NO;
        self.birthdayLabel.borderStyle=UITextBorderStyleNone;
        self.detailDescriptionLabel.enabled=NO;
        self.detailDescriptionLabel.borderStyle=UITextBorderStyleNone;
    }
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
    [imageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [imageView.layer setBorderWidth: 0.8];
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated
{
    imageView.image=nil;
    [super viewWillAppear:animated];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) dealloc
{
    [_detailItem release];
    [_detailDescriptionLabel release];
    [activity release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) finishedPublishingPost:(FBRequestWrapper *)_request
{
    imageView.image=[UIImage imageWithData:wrapper.parsedResult];

    [activity stopAnimating];
    
}

-(void) failedToPublishPost:(FBRequestWrapper *)_request
{
    
}

- (IBAction) textFieldReturn:(id)sender
{
	[sender resignFirstResponder];
}




@end
