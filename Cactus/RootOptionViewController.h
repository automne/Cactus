//
//  RootOptionViewController.h
//  Cactus
//
//  Created by nthu on 12/1/1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventViewController.h"
#import "FBListViewController.h"
#import "LocalWeatherViewController.h"

@interface RootOptionViewController : UIViewController
{
    EventViewController *events;
    FBListViewController *birthdayList;
    LocalWeatherViewController *weather;
    UIViewController *superViewController;
}

@property (strong, nonatomic) UIViewController *superViewController;

- (IBAction)back:(id)sender;
- (IBAction)toWeather:(id)sender;
- (IBAction)toBirthday:(id)sender;
- (IBAction)toReminder:(id)sender;
@end
