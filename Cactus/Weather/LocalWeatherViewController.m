//
//  LocalWeatherViewController.m
//  LocalWeather
//
//  Created by Automne on 12/30/11.
//  Copyright (c) 2011 Automne. All rights reserved.
//

#import "LocalWeatherViewController.h"
#import "ICB_WeatherConditions.h"
#import "MapKit/MapKit.h"
#import <CoreLocation/CoreLocation.h>

@implementation LocalWeatherViewController

@synthesize locationManager, delegate;
@synthesize currentTempLabel, highTempLabel, lowTempLabel, conditionsLabel, cityLabel;
@synthesize conditionsImageView;
@synthesize conditionsImage;
@synthesize updata, back;

BOOL didUpdate = NO;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    if (1) //you have coordinates but need a city
    {   
        NSLog(@"Starting Location Updates");
        
        if (locationManager == nil)
            locationManager = [[CLLocationManager alloc] init];
        
        locationManager.delegate = self;
        
        // You have some options here, though higher accuracy takes longer to resolve.
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        while (locationManager.location.coordinate.latitude == 0 || locationManager.location.coordinate.longitude == 0) {
            [locationManager startUpdatingLocation]; 
        }*/
        // Check out Part 1 of the tutorial to see how to find your Location with CoreLocation
        /*CLLocationCoordinate2D coord;    
        coord.latitude = locationManager.location.coordinate.latitude;
        coord.longitude = locationManager.location.coordinate.longitude;*/
        
      //  int a = locationManager.location.coordinate.latitude * 1000000;
       // int b = locationManager.location.coordinate.longitude * 1000000;
        
       // NSString *locatcoord =[[NSString alloc]initWithFormat:@",,,%i,%i",a,b];
        
        // Geocode coordinate (normally we'd use location.coordinate here instead of coord).
        //This will get us something we can query Google's Weather API with
        
        /*MKReverseGeocoder *geocoder = [[MKReverseGeocoder alloc] initWithCoordinate:coord];
        geocoder.delegate = self;
        [geocoder start];*/
        
  //      [self performSelectorInBackground:@selector(showWeatherFor:) withObject:locatcoord];
   // }
   // else // You already know your users zipcode, city, or otherwise.
    //{
        // Do this in the background so we don't lock up the UI.
     //   [self performSelectorInBackground:@selector(showWeatherFor:) withObject:@"97217"];
    //}
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

// This will run in the background
- (void)showWeatherFor:(NSString *)query
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    ICB_WeatherConditions *weather = [[ICB_WeatherConditions alloc] initWithQuery:query];
    
    self.conditionsImage = [[UIImage imageWithData:[NSData dataWithContentsOfURL:weather.conditionImageURL]] retain];

    [self performSelectorOnMainThread:@selector(updateUI:) withObject:weather waitUntilDone:NO];
    
    
    [pool release];
}

// This happens in the main thread
- (void)updateUI:(ICB_WeatherConditions *)weather
{
    self.conditionsImageView.image = self.conditionsImage;
    [self.conditionsImage release];
    
    [self.currentTempLabel setText:[NSString stringWithFormat:@"%d", weather.currentTemp]];
    [self.highTempLabel setText:[NSString stringWithFormat:@"%d", weather.highTemp]];
    [self.lowTempLabel setText:[NSString stringWithFormat:@"%d", weather.lowTemp]];
    [self.conditionsLabel setText:weather.condition];
    //[self.cityLabel setText:weather.location];
    [weather release];
}

- (IBAction)updateTheWeather:(id)sender
{
    //NSLog(@"Starting Location Updates");
    
    if (locationManager == nil)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    while (locationManager.location.coordinate.latitude == 0 || locationManager.location.coordinate.longitude == 0) {
        [locationManager startUpdatingLocation]; 
    }
    
    int a = locationManager.location.coordinate.latitude * 1000000;
    int b = locationManager.location.coordinate.longitude * 1000000;
    
    NSString *locatcoord =[[NSString alloc]initWithFormat:@",,,%i,%i",a,b];
    
    [self performSelectorInBackground:@selector(showWeatherFor:) withObject:locatcoord];
}

#pragma mark MKReverseGeocoder Delegate Methods
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    [geocoder release];

    [self performSelectorInBackground:@selector(showWeatherFor:) withObject:[placemark.addressDictionary objectForKey:@"ZIP"]];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{    
    NSLog(@"reverseGeocoder:%@ didFailWithError:%@", geocoder, error);
    
    //[geocoder release];
    [geocoder start];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your location could not be determined." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];      
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manage didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (didUpdate)
        return;
    
    didUpdate = YES;
    
	// Disable future updates to save power.
    [locationManager stopUpdatingLocation];
    
    // let our delegate know we're done
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [locationManager release];
    [super dealloc];
}

@end
