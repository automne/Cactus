//
//  LocalWeatherViewController.h
//  LocalWeather
//
//  Created by Automne on 12/30/11.
//  Copyright (c) 2011 Automne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "ICB_WeatherConditions.h"
#import <CoreLocation/CoreLocation.h>

@interface LocalWeatherViewController : UIViewController <MKReverseGeocoderDelegate> {
    IBOutlet UILabel *currentTempLabel, *highTempLabel, *lowTempLabel, *conditionsLabel, *cityLabel;
    IBOutlet UIImageView *conditionsImageView;
    IBOutlet UIButton *updata, *back;
    UIImage *conditionsImage;
    CLLocationManager *locationManager;
    id delegate;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic , retain) id delegate;
@property (nonatomic,retain) IBOutlet UILabel *currentTempLabel, *highTempLabel, *lowTempLabel, *conditionsLabel, *cityLabel;
@property (nonatomic,retain) IBOutlet UIImageView *conditionsImageView;
@property (nonatomic,retain) IBOutlet UIButton *updata, *back;
@property (nonatomic,retain) UIImage *conditionsImage;
//- (void)startUpdates;
- (void)showWeatherFor:(NSString *)query;
- (void)updateUI:(ICB_WeatherConditions *)weather;
- (IBAction)updateTheWeather:(id)sender;
- (IBAction)goBack :(id)sender;

@end

